import 'dart:convert';

import 'package:eclass_flutter/teacher_panel/dash/ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:http/http.dart';
import 'package:open_filex/open_filex.dart';

class NoticePage extends StatefulWidget {
  const NoticePage({super.key});

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  List files = [];
  bool _hasLoaded = false;

  String title = '';
  String author = '';
  DateTime date = DateTime.now();
  String content = '';

  Future<void> loadNotice() async {
    final id = ModalRoute.of(context)!.settings.arguments;
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();

    final response = await get(
      Uri.parse('http://192.168.1.106:8080/notices/get?id=$id'),
      headers: {'Authorization': 'Bearer $idToken'},
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      setState(() {
        title = body['title'];
        author = body['author'];
        date = DateTime.parse(body['date']);
        content = body['content'];
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasLoaded) {
      _hasLoaded = true;
      loadNotice();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Delta delta = Delta.fromJson(
      content != ''
          ? jsonDecode(content)
          : [
            {"insert": "\n"},
          ],
    );
    final Document document = Document.fromDelta(delta);
    final QuillController controller = QuillController(
      document: document,
      selection: TextSelection.collapsed(offset: 0),
      readOnly: true,
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          spacing: 8.0,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
              ),
              elevation: 0.0,
              actions: [
                IconButton(onPressed: () {}, icon: Icon(Icons.search_off)),
              ],
              backgroundColor:
                  Theme.of(context).colorScheme.surfaceContainerLow,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8.0,
                children: [
                  Text(title, style: Theme.of(context).textTheme.displaySmall),
                  Text(
                    "$author \u2022 1 day ago",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(height: 32),
                    QuillEditor.basic(
                      controller: controller,
                      config: QuillEditorConfig(
                        autoFocus: false,
                        expands: false,
                      ),
                    ),
                    SizedBox(height: 20),
                    LayoutBuilder(
                      builder:
                          (context, constraints) => SizedBox(
                            height: constraints.maxHeight,
                            child: Column(
                              children: [
                                Expanded(child: Container()),
                                Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        "Uploads",
                                        style: Theme.of(
                                          context,
                                        ).textTheme.labelMedium?.copyWith(
                                          color:
                                              Theme.of(
                                                context,
                                              ).colorScheme.onPrimaryContainer,
                                        ),
                                      ),
                                      ...files.map((file) {
                                        List<String> parts = file.name.split(
                                          '.',
                                        );
                                        String name = parts
                                            .sublist(0, parts.length - 1)
                                            .join('.');
                                        String extension = parts.last;
                                        return Container(
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(
                                                  context,
                                                ).colorScheme.tertiary,
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(12.0),
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 12.0,
                                          ),
                                          child: Row(
                                            spacing: 0,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Row(
                                                  spacing: 0,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        name,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelLarge
                                                            ?.copyWith(
                                                              color:
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .colorScheme
                                                                      .onTertiary,
                                                            ),
                                                        overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                        maxLines: 1,
                                                        softWrap: false,
                                                      ),
                                                    ),
                                                    Text(
                                                      ".$extension",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelLarge
                                                          ?.copyWith(
                                                            color:
                                                                Theme.of(
                                                                      context,
                                                                    )
                                                                    .colorScheme
                                                                    .onTertiary,
                                                          ),
                                                    ),
                                                    SizedBox(width: 4.0),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                formatFileSize(file.size),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall
                                                    ?.copyWith(
                                                      color:
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .outlineVariant,
                                                    ),
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.remove_circle_outline,
                                                ),
                                                color:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .errorContainer,
                                                onPressed: () {
                                                  setState(() {
                                                    files.remove(file);
                                                  });
                                                },
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  OpenFilex.open(file.path);
                                                },
                                                icon: Icon(Icons.arrow_forward),
                                                color:
                                                    Theme.of(
                                                      context,
                                                    ).colorScheme.onTertiary,
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
