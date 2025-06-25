import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:http/http.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:shimmer/shimmer.dart';

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
      Uri.parse('http://10.173.158.188:8080/notices/get?id=$id'),
      headers: {'Authorization': 'Bearer $idToken'},
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      setState(() {
        title = body['title'];
        author = body['author'];
        date = DateTime.parse(body['date']);
        content = body['content'];
        files = body['uploads'];
      });
      print(body['uploads']);
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

  Future<File> getFile(String url, String filename) async {
    final dir = await getApplicationDocumentsDirectory();
    final filePath = path.join(dir.path, filename);
    final file = File(filePath);

    if (await file.exists()) {
      // TODO: set state?
      return file;
    }
    try {
      final response = await get(Uri.parse('http://10.173.158.188:8080$url'));
      print(response.statusCode);

      await file.writeAsBytes(response.bodyBytes);
      return file;
    } catch (e) {
      throw Exception('Failed to download file: $e');
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
                        maxHeight: calculateFreeSpace(
                          context,
                          files.length,
                          title,
                        ),
                        minHeight: calculateFreeSpace(
                          context,
                          files.length,
                          title,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        spacing: 4.0,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                            List<String> parts = file['name'].split('.');
                            String name = parts
                                .sublist(0, parts.length - 1)
                                .join('.');
                            String extension = parts.last;
                            return Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.vertical(
                                  top:
                                      file == files[0]
                                          ? Radius.circular(12.0)
                                          : Radius.circular(4.0),
                                  bottom:
                                      file == files[files.length - 1]
                                          ? Radius.circular(12.0)
                                          : Radius.circular(4.0),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
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
                                            style: Theme.of(
                                              context,
                                            ).textTheme.labelLarge?.copyWith(
                                              color:
                                                  Theme.of(
                                                    context,
                                                  ).colorScheme.onPrimary,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            softWrap: false,
                                          ),
                                        ),
                                        Text(
                                          ".$extension",
                                          style: Theme.of(
                                            context,
                                          ).textTheme.labelLarge?.copyWith(
                                            color:
                                                Theme.of(
                                                  context,
                                                ).colorScheme.onPrimary,
                                          ),
                                        ),
                                        SizedBox(width: 4.0),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    formatFileSize(
                                      int.tryParse(file['size'] ?? '0') ?? 0,
                                    ),
                                    style: Theme.of(
                                      context,
                                    ).textTheme.labelSmall?.copyWith(
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.outlineVariant,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      final downloadedFile = await getFile(
                                        file['location'],
                                        file['name'],
                                      );
                                      OpenFilex.open(downloadedFile.path);
                                    },
                                    icon: Icon(Icons.arrow_forward),
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ],
                              ),
                            );
                          }),
                          if (files.isEmpty)
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Center(
                                child: Text(
                                  "The author didn't upload any file",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.copyWith(
                                    color:
                                        Theme.of(
                                          context,
                                        ).colorScheme.onPrimaryContainer,
                                  ),
                                ),
                              ),
                            ),
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
    );
  }
}

// helper

int calculateNumberOfLines({
  required String text,
  required TextStyle style,
  required double maxWidth,
  int? maxLines,
}) {
  final span = TextSpan(text: text, style: style);
  final tp = TextPainter(
    text: span,
    maxLines: maxLines,
    textDirection: TextDirection.ltr,
  )..layout(maxWidth: maxWidth);

  return tp.computeLineMetrics().length;
}

double calculateFreeSpace(
  BuildContext context,
  int fileLength,
  String titleText,
) {
  final mediaQuery = MediaQuery.of(context);
  final theme = Theme.of(context);

  int titleLines = calculateNumberOfLines(
    text: titleText,
    style: theme.textTheme.displaySmall ?? TextStyle(fontSize: 36),
    maxWidth: mediaQuery.size.width,
  );

  double appBarHeight = 56.0; // or 64.0 for web/desktop
  double statusBarHeight = mediaQuery.padding.top;
  double bottomPadding = mediaQuery.padding.bottom;

  double titleFontSize = theme.textTheme.displaySmall?.fontSize ?? 0.0;
  double titleLineHeight = theme.textTheme.displaySmall?.height ?? 1.0;
  double titleHeight = titleFontSize * titleLineHeight * titleLines;

  double authorFontSize = theme.textTheme.titleMedium?.fontSize ?? 0.0;
  double authorLineHeight = theme.textTheme.titleMedium?.height ?? 1.0;
  double authorHeight = authorFontSize * authorLineHeight;

  double labelFontSize = theme.textTheme.labelMedium?.fontSize ?? 0.0;
  double labelLineHeight = theme.textTheme.labelMedium?.height ?? 1.0;
  double labelHeight = labelFontSize * labelLineHeight;

  double uploadsPadding = 12.0 * 2;
  double containerPadding = 16.0 * 2;
  double sizedBoxHeight = 32.0 + 20.0 + 8.0;

  double filesHeight = fileLength * 48 + 4;

  double noFilesTextFontSize = theme.textTheme.bodySmall?.fontSize ?? 0.0;
  double noFilesTextLineHeight = theme.textTheme.bodySmall?.height ?? 1.0;
  double noFilesTextHeight = noFilesTextLineHeight * noFilesTextFontSize;
  double noFilesHeight =
      fileLength == 0
          ? 8 * 2 + noFilesTextHeight + 2
          : 0; // the +2 is literally an error or smth.

  double totalUsedSpace =
      appBarHeight +
      statusBarHeight +
      bottomPadding +
      titleHeight +
      authorHeight +
      uploadsPadding +
      containerPadding +
      sizedBoxHeight +
      filesHeight +
      noFilesHeight +
      22 +
      labelHeight;

  return max(0, mediaQuery.size.height - totalUsedSpace);
}

String formatFileSize(int bytes) {
  const int kb = 1024;
  const int mb = 1024 * kb;

  if (bytes >= mb) {
    return "${(bytes / mb).toStringAsFixed(1)} MB";
  } else if (bytes >= kb) {
    return "${(bytes / kb).toStringAsFixed(1)} KB";
  } else {
    return "$bytes B";
  }
}
