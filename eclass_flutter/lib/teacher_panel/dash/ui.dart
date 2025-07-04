import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_filex/open_filex.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherDash extends StatefulWidget {
  const TeacherDash({super.key});

  @override
  State<TeacherDash> createState() => _TeacherDashState();
}

class _TeacherDashState extends State<TeacherDash> {
  String firstName = '';
  List notices = [];
  List classes = [];

  bool isLoading = true;

  Future<void> loadNotices() async {
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    final response = 
    await get(
      Uri.parse('http://10.173.158.188:8080/teacher/notices/getAll'),
      headers: {"Authorization": "Bearer $idToken"},
    );
    Map body = jsonDecode(response.body);
    if (!mounted) return;
    setState(() {
      notices = body['notices'];
    });
  }

  Future<void> loadClasses() async {
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    final response = await get(
      Uri.parse('http://10.173.158.188:8080/teacher/class/get/all'),
      headers: {'Authorization': 'Bearer $idToken'},
    );

    if (response.statusCode == 200 && mounted) {
      setState(() {
        classes = jsonDecode(response.body);
      });
    }
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    await loadNotices();
    await loadClasses();

    if (!mounted) return;
    setState(() {
      firstName = prefs.getString('name')!.split(' ')[0];
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            spacing: 28.0,
            children: [
              Header(prefs: firstName),
              LatestNotices(noticeList: notices),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8.0,
                  children: [
                    Text(
                      "Today's Classes",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TeacherClass(
                            lesson: "Theory of Knowledge",
                            classGrade: "DP2",
                            startTime: TimeOfDay(hour: 8, minute: 20),
                            endTime: TimeOfDay(hour: 9, minute: 0),
                            first: true,
                          ),
                          TeacherClass(
                            lesson: "Theory of Knowledge",
                            classGrade: "DP2",
                            startTime: TimeOfDay(hour: 9, minute: 10),
                            endTime: TimeOfDay(hour: 9, minute: 50),
                          ),
                          TeacherClass(
                            lesson: "English B",
                            classGrade: "MYP5",
                            startTime: TimeOfDay(hour: 10, minute: 0),
                            endTime: TimeOfDay(hour: 10, minute: 40),
                          ),
                          TeacherClass(
                            lesson: "English B",
                            classGrade: "MYP5",
                            startTime: TimeOfDay(hour: 10, minute: 50),
                            endTime: TimeOfDay(hour: 11, minute: 30),
                          ),
                          TeacherClass(
                            lesson: "English B",
                            classGrade: "MYP5",
                            startTime: TimeOfDay(hour: 11, minute: 40),
                            endTime: TimeOfDay(hour: 12, minute: 20),
                            last: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  spacing: 8.0,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Quick Actions",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Column(
                      spacing: 8.0,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FilledButton.icon(
                              onPressed:
                                  () => {
                                    showModalBottomSheet<dynamic>(
                                      context: context,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(16.0),
                                        ),
                                      ),
                                      showDragHandle: true,
                                      builder: (BuildContext context) {
                                        return AnimatedPadding(
                                          padding: EdgeInsetsGeometry.only(
                                            bottom:
                                                MediaQuery.of(
                                                  context,
                                                ).viewInsets.bottom,
                                          ),
                                          duration: Duration(milliseconds: 100),
                                          curve: Curves.easeOut,
                                          child: DraggableScrollableSheet(
                                            expand: false,
                                            maxChildSize: 0.9,
                                            builder: (
                                              context,
                                              scrollContainer,
                                            ) {
                                              return SingleChildScrollView(
                                                controller: scrollContainer,
                                                child: HomeworkModal(
                                                  classes: classes,
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      isScrollControlled: true,
                                    ),
                                  },
                              label: Text(
                                "Add homework",
                                style: Theme.of(
                                  context,
                                ).textTheme.titleMedium?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                              icon: Icon(Icons.add_circle_outline),
                              style: FilledButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                foregroundColor:
                                    Theme.of(context).colorScheme.onPrimary,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24.0,
                                  vertical: 16.0,
                                ),
                              ),
                            ),
                            SizedBox(width: 8.0),
                            FilledButton.tonalIcon(
                              onPressed:
                                  () => {
                                    showModalBottomSheet(
                                      context: context,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(16.0),
                                        ),
                                      ),
                                      showDragHandle: true,
                                      isScrollControlled: true,
                                      builder:
                                          (context) => AnimatedPadding(
                                            duration: Duration(
                                              milliseconds: 100,
                                            ),
                                            curve: Curves.easeOut,
                                            padding: EdgeInsetsGeometry.only(
                                              bottom:
                                                  MediaQuery.of(
                                                    context,
                                                  ).viewInsets.bottom,
                                            ),
                                            child: DraggableScrollableSheet(
                                              expand: false,
                                              maxChildSize: 0.9,
                                              builder:
                                                  (context, scrollController) =>
                                                      SingleChildScrollView(
                                                        controller:
                                                            scrollController,
                                                        child: TestModal(
                                                          classes: classes,
                                                        ),
                                                      ),
                                            ),
                                          ),
                                    ),
                                  },
                              label: Text(
                                "Add test",
                                style: Theme.of(
                                  context,
                                ).textTheme.titleMedium?.copyWith(
                                  color:
                                      Theme.of(
                                        context,
                                      ).colorScheme.onSecondaryContainer,
                                ),
                              ),
                              icon: Icon(Icons.today_rounded),
                              style: FilledButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  vertical: 16.0,
                                  horizontal: 24.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        ConnectedButtonGroup(
                          selected: 0,
                          labels: ["In school", "Busy", "Sick"],
                        ),
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 4.0,
                          children: [
                            FilledButton.tonal(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16.0),
                                    ),
                                  ),
                                  showDragHandle: true,
                                  isScrollControlled: true,
                                  builder: (context) => CancelLessonModal(),
                                );
                              },
                              style: FilledButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  vertical: 6.0,
                                  horizontal: 12.0,
                                ),
                              ),
                              child: Text("Cancel lesson"),
                            ),
                            FilledButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  showDragHandle: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16.0),
                                    ),
                                  ),
                                  builder:
                                      (context) => AnimatedPadding(
                                        duration: Duration(milliseconds: 100),
                                        curve: Curves.easeOut,
                                        padding: EdgeInsetsGeometry.only(
                                          bottom:
                                              MediaQuery.of(
                                                context,
                                              ).viewInsets.bottom,
                                        ),
                                        child: LessonTopicModal(),
                                      ),
                                );
                              },
                              style: FilledButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  vertical: 6.0,
                                  horizontal: 12.0,
                                ),
                              ),
                              child: Text("Add lesson topic"),
                            ),
                            FilledButton.tonal(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  showDragHandle: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16.0),
                                    ),
                                  ),
                                  builder:
                                      (context) => AnimatedPadding(
                                        duration: Duration(milliseconds: 100),
                                        curve: Curves.easeOut,
                                        padding: EdgeInsetsGeometry.only(
                                          bottom:
                                              MediaQuery.of(
                                                context,
                                              ).viewInsets.bottom,
                                        ),
                                        child: DraggableScrollableSheet(
                                          expand: false,
                                          maxChildSize: 0.9,
                                          initialChildSize: 0.7,
                                          minChildSize: 0.7,
                                          builder: (context, scrollController) {
                                            return CreateNoticeModal(
                                              scrollController:
                                                  scrollController,
                                            );
                                          },
                                        ),
                                      ),
                                );
                              },
                              style: FilledButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  vertical: 6.0,
                                  horizontal: 12.0,
                                ),
                              ),
                              child: Text("Add notice"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8.0,
                  children: [
                    Text(
                      "Your Classes",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ...classes.map((e) {
                          return TeacherClass(
                            lesson: e['name'],
                            classGrade: e['grade'],
                            first: e == classes[0] ? true : false,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/class',
                                arguments: e['id'],
                              );
                            },
                          );
                        }),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16.0),
                                ),
                              ),
                              showDragHandle: true,
                              isScrollControlled: true,
                              builder:
                                  (context) => AnimatedPadding(
                                    duration: Duration(milliseconds: 100),
                                    curve: Curves.easeOut,
                                    padding: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(
                                            context,
                                          ).viewInsets.bottom,
                                    ),
                                    child: NewClassModal(),
                                  ),
                            );
                          },
                          child: Card(
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                                bottomLeft: Radius.circular(12.0),
                                bottomRight: Radius.circular(12.0),
                              ),
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Icon(Icons.add_circle_outline),
                                  ),
                                  Text(
                                    "Create new class",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.0),
            ],
          ),
        ),

        if (isLoading)
          Positioned.fill(
            child: AbsorbPointer(
              absorbing: true,
              child: Stack(
                children: [
                  const ModalBarrier(dismissible: false, color: Colors.black54),
                  const Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class NewClassModal extends StatefulWidget {
  const NewClassModal({super.key});

  @override
  State<NewClassModal> createState() => _NewClassModalState();
}

class _NewClassModalState extends State<NewClassModal> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController gradeController = TextEditingController();

  String? nameError;
  String? gradeError;

  bool created = false;

  Future<void> createNewClassHandler() async {
    if (nameController.text.trim().isEmpty) {
      setState(() {
        nameError = 'Class/course name cannot be empty!';
      });
      return;
    }
    if (gradeController.text.trim().isEmpty) {
      setState(() {
        gradeError = 'Grade name cannot be empty!';
      });
      return;
    }

    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    final response = await post(
      Uri.parse('http://10.173.158.188:8080/teacher/class/new'),
      headers: {'Authorization': 'Bearer $idToken'},
      body: {
        'name': nameController.text.trim(),
        'grade': gradeController.text.trim(),
      },
    );

    if (response.statusCode == 201) {
      setState(() {
        created = true;
      });
      Future.delayed(Duration(seconds: 1), () {
        Navigator.pop(context);
      });
    } else {
      setState(() {
        nameError =
            'Failed to create class (${response.statusCode}). Try again later or contact support.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        spacing: 30.0,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Create New Class",
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
          TextField(
            controller: nameController,
            maxLines: null,
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: InputDecoration(
              labelText: "Class/course name",
              labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              errorText: nameError,
              errorMaxLines: 2,
              errorStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
              border: UnderlineInputBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              ),
            ),
          ),
          TextField(
            controller: gradeController,
            maxLines: null,
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: InputDecoration(
              labelText: "Class grade",
              labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              helperText:
                  "Enter the grade with the corresponding letters, eg. 11A or DP2",
              helperMaxLines: 2,
              filled: true,
              errorText: gradeError,
              errorMaxLines: 2,
              errorStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
              fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
              border: UnderlineInputBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FilledButton.icon(
                onPressed: createNewClassHandler,
                icon: Icon(created ? Icons.check : Icons.add),
                label: Text(created ? 'Created' : "Create"),
                style: FilledButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 24.0,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }
}

class CreateNoticeModal extends StatefulWidget {
  const CreateNoticeModal({super.key, required this.scrollController});
  final ScrollController scrollController;

  @override
  State<CreateNoticeModal> createState() => _CreateNoticeModalState();
}

class _CreateNoticeModalState extends State<CreateNoticeModal> {
  final TextEditingController titleController = TextEditingController();
  late QuillController _controller;
  late FocusNode _focusNode;

  late bool isBold;
  late bool isUnderlined;
  late bool isItalicised;

  bool isSending = false;
  bool isError = false;

  String? titleError;

  var files = [];

  @override
  void initState() {
    super.initState();
    _controller = QuillController(
      document: Document(),
      selection: const TextSelection.collapsed(offset: 0),
    );
    _focusNode = FocusNode();
    final attr = _controller.getSelectionStyle().attributes;
    isBold = attr.containsKey(Attribute.bold.key);
    isUnderlined = attr.containsKey(Attribute.underline.key);
    isItalicised = attr.containsKey(Attribute.italic.key);
    _controller.addListener(_handleQuillChange);
  }

  void _handleQuillChange() {
    final attr = _controller.getSelectionStyle().attributes;
    setState(() {
      isBold = attr.containsKey(Attribute.bold.key);
      isUnderlined = attr.containsKey(Attribute.underline.key);
      isItalicised = attr.containsKey(Attribute.italic.key);
    });
  }

  Future<void> _handleNoticeCreation() async {
    if (titleController.text.trim().isEmpty ||
        _controller.document.length == 0) {
      setState(() {
        titleError = 'Title and content cannot be empty!';
      });
    }

    setState(() {
      isSending = true;
      isError = false;
    });
    final req = MultipartRequest(
      'POST',
      Uri.parse('http://10.173.158.188:8080/teacher/notices/create'),
    );
    req.fields['title'] = titleController.text.trim();
    req.fields['tags'] = jsonEncode(['tag1', 'tag2']);
    req.fields['content'] = jsonEncode(_controller.document.toDelta().toJson());

    req.headers.addAll({
      "Authorization":
          "Bearer ${await FirebaseAuth.instance.currentUser?.getIdToken()}",
    });

    for (var file in files) {
      req.files.add(await MultipartFile.fromPath('files', file.path!));
    }

    final response = await req.send();
    if (response.statusCode == 201) {
      setState(() {
        isError = false;
        isSending = false;
      });
      Navigator.pop(context);
    } else {
      setState(() {
        isSending = false;
        isError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            controller: widget.scrollController,
            child: Column(
              spacing: 30.0,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Create Notice",
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                TextField(
                  controller: titleController,
                  maxLines: null,
                  style: Theme.of(context).textTheme.bodyLarge,
                  decoration: InputDecoration(
                    errorText: titleError,
                    helperText: "By Maggie Smith",
                    labelText: "Heading",
                    labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    filled: true,
                    fillColor:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(8),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 296,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHigh,
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    ),
                    child: QuillEditor.basic(
                      controller: _controller,
                      scrollController: ScrollController(),
                      focusNode: _focusNode,
                      config: QuillEditorConfig(
                        placeholder: "Notice",
                        padding: EdgeInsets.all(16.0),
                        minHeight: 296.0,
                        customStyles: DefaultStyles(
                          paragraph: DefaultTextBlockStyle(
                            Theme.of(context).textTheme.bodySmall!,
                            HorizontalSpacing(0, 0),
                            VerticalSpacing(0, 0),
                            VerticalSpacing(0, 0),
                            null,
                          ),
                          placeHolder: DefaultTextBlockStyle(
                            Theme.of(context).textTheme.bodySmall!,
                            HorizontalSpacing(0, 0),
                            VerticalSpacing(0, 0),
                            VerticalSpacing(0, 0),
                            null,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  ),
                  child: Column(
                    spacing: 8.0,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Uploads",
                        style: Theme.of(
                          context,
                        ).textTheme.labelMedium?.copyWith(
                          color:
                              Theme.of(context).colorScheme.onTertiaryContainer,
                        ),
                      ),

                      ...files.map((file) {
                        List<String> parts = file.name.split('.');
                        String name = parts
                            .sublist(0, parts.length - 1)
                            .join('.');
                        String extension = parts.last;
                        return Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.tertiary,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(12.0),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            spacing: 0,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                              ).colorScheme.onTertiary,
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
                                            ).colorScheme.onTertiary,
                                      ),
                                    ),
                                    SizedBox(width: 4.0),
                                  ],
                                ),
                              ),
                              Text(
                                formatFileSize(file.size),
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
                                icon: Icon(Icons.remove_circle_outline),
                                color:
                                    Theme.of(
                                      context,
                                    ).colorScheme.errorContainer,
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
                                color: Theme.of(context).colorScheme.onTertiary,
                              ),
                            ],
                          ),
                        );
                      }),

                      if (files.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(
                                color:
                                    Theme.of(
                                      context,
                                    ).colorScheme.onTertiaryContainer,
                              ),
                              children: [
                                TextSpan(text: "Upload a file by pressing "),
                                WidgetSpan(
                                  child: Icon(
                                    Icons.attach_file,
                                    color:
                                        Theme.of(
                                          context,
                                        ).colorScheme.onTertiaryContainer,
                                  ),
                                  alignment: PlaceholderAlignment.middle,
                                ),
                                TextSpan(text: ' in the toolbar.'),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 80),
              ],
            ),
          ),
        ),

        // TOOLBAR
        Positioned(
          bottom: 24,
          left: 24,
          right: 24,
          child: Row(
            spacing: 12.0,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Material(
                elevation: 2,
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 12.0,
                  ),
                  child: Row(
                    spacing: 4,
                    children: [
                      iconToggleButton(
                        isBold,
                        context,
                        Icons.format_bold,
                        Attribute.bold,
                      ),
                      iconToggleButton(
                        isUnderlined,
                        context,
                        Icons.format_underline,
                        Attribute.underline,
                      ),
                      iconToggleButton(
                        isItalicised,
                        context,
                        Icons.format_italic,
                        Attribute.italic,
                      ),
                      IconButton(
                        icon: Icon(Icons.attach_file),
                        onPressed: () async {
                          final result = await FilePicker.platform.pickFiles();

                          if (result != null) {
                            setState(() {
                              files.add(result.files.single);
                            });
                          }
                        },
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ],
                  ),
                ),
              ),
              FloatingActionButton(
                backgroundColor:
                    isError
                        ? Theme.of(context).colorScheme.error
                        : Theme.of(context).colorScheme.primary,
                foregroundColor:
                    isError
                        ? Theme.of(context).colorScheme.onError
                        : Theme.of(context).colorScheme.onPrimary,
                onPressed: _handleNoticeCreation,
                child:
                    isSending
                        ? CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.onPrimary,
                        )
                        : isError
                        ? Icon(Icons.error_outline)
                        : Icon(Icons.send_outlined),
              ),
            ],
          ),
        ),
      ],
    );
  }

  IconButton iconToggleButton(
    bool isSelected,
    BuildContext context,
    IconData icon,
    Attribute attribute,
  ) {
    return IconButton(
      icon: Icon(
        icon,
        color:
            isSelected
                ? Theme.of(context).colorScheme.onSurface
                : Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      onPressed: () {
        _controller.formatSelection(
          isSelected ? Attribute.clone(attribute, null) : attribute,
        );
        setState(() {});
      },
      isSelected: isSelected,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
          return isSelected
              ? Theme.of(context).colorScheme.surfaceContainer
              : null;
        }),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}

class LessonTopicModal extends StatelessWidget {
  const LessonTopicModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        spacing: 30.0,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Add Lesson Topic",
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
          TextField(
            maxLines: null,
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: InputDecoration(
              labelText: "Topic",
              labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
              border: UnderlineInputBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              ),
            ),
          ),
          TimeSelector(label: "Lesson", expanded: true),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FilledButton.icon(
                onPressed: () {},
                icon: Icon(Icons.add),
                label: Text("Add"),
                style: FilledButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 24.0,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }
}

class CancelLessonModal extends StatelessWidget {
  const CancelLessonModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        spacing: 30.0,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Cancel Lesson",
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
          Column(
            spacing: 8.0,
            children: [
              TimeSelector(label: "Lesson", expanded: true),
              Text(
                "Students do not receive notifications for lesson cancellations, so please inform them.",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FilledButton.icon(
                onPressed: () {},
                icon: Icon(Icons.delete_outline),
                label: Text("Cancel"),
                style: FilledButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 24.0,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.error,
                  foregroundColor: Theme.of(context).colorScheme.onError,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }
}

class TestModal extends StatelessWidget {
  const TestModal({super.key, required this.classes});

  final List classes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        spacing: 30.0,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Create New Assessment",
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
          TextField(
            maxLines: null,
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: InputDecoration(
              labelText: "Topic",
              labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
              border: UnderlineInputBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              ),
            ),
          ),
          Column(
            spacing: 8.0,
            children: [
              GradingSysSelector(),
              Text(
                "Practice assessments don't count towards the final grade and are assessed in percent by the teacher.",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerLowest,
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
            child: Column(
              spacing: 8.0,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Class", style: Theme.of(context).textTheme.labelMedium),
                ClassGroup(classes: classes),
              ],
            ),
          ),
          TimeSelector(label: "Lesson", expanded: true),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FilledButton.icon(
                onPressed: () {},
                icon: Icon(Icons.add),
                label: Text("Create"),
                style: FilledButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 24.0,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }
}

class GradingSysSelector extends StatefulWidget {
  const GradingSysSelector({super.key});

  @override
  State<GradingSysSelector> createState() => _GradingSysSelectorState();
}

class _GradingSysSelectorState extends State<GradingSysSelector> {
  String? _selectodMethod;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16.0,
      children: [
        Expanded(
          child: ListTile(
            title: Text(
              "Graded assessment",
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color:
                    _selectodMethod == "graded"
                        ? Theme.of(context).colorScheme.onPrimaryContainer
                        : Theme.of(context).colorScheme.onSurface,
              ),
            ),
            trailing: Radio.adaptive(
              value: "graded",
              groupValue: _selectodMethod,
              onChanged: (String? val) {
                setState(() {
                  _selectodMethod = val;
                });
              },
            ),
            onTap: () {
              setState(() {
                _selectodMethod = "graded";
              });
            },
            tileColor: Theme.of(context).colorScheme.surfaceContainerHighest,
            selectedTileColor: Theme.of(context).colorScheme.primaryContainer,
            selected: _selectodMethod == "graded",
            contentPadding: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
            selectedColor: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        Expanded(
          child: ListTile(
            title: Text(
              "Practice assessment",
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color:
                    _selectodMethod == "practice"
                        ? Theme.of(context).colorScheme.onPrimaryContainer
                        : Theme.of(context).colorScheme.onSurface,
              ),
            ),
            trailing: Radio.adaptive(
              value: "practice",
              groupValue: _selectodMethod,
              onChanged: (String? val) {
                setState(() {
                  _selectodMethod = val;
                });
              },
            ),
            onTap: () {
              setState(() {
                _selectodMethod = "practice";
              });
            },
            tileColor: Theme.of(context).colorScheme.surfaceContainerHighest,
            selectedTileColor: Theme.of(context).colorScheme.primaryContainer,
            selected: _selectodMethod == "practice",
            contentPadding: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            selectedColor: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
      ],
    );
  }
}

class HomeworkModal extends StatelessWidget {
  const HomeworkModal({super.key, required this.classes});

  final List classes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        spacing: 30.0,
        children: [
          Text(
            "Add Homework",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          TextField(
            maxLines: null,
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: InputDecoration(
              labelText: "Assignment",
              labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
              border: UnderlineInputBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerLowest,
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
            child: Column(
              spacing: 8.0,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Class", style: Theme.of(context).textTheme.labelMedium),
                ClassGroup(classes: classes),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TimeSelector(label: "Assigned"),
              TimeSelector(label: "Due"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FilledButton.icon(
                onPressed: () {},
                icon: Icon(Icons.add),
                label: Text("Add"),
                style: FilledButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 24.0,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }
}

class ClassGroup extends StatefulWidget {
  const ClassGroup({super.key, required this.classes});
  final List classes;
  @override
  State<ClassGroup> createState() => _ClassGroupState();
}

class _ClassGroupState extends State<ClassGroup> {
  String? _selectedValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 6.0,
      children: [
        ...widget.classes.map(
          (e) => ClassTile(
            onChanged: _handleStateChange,
            groupValue: _selectedValue,
            headline: '${e['grade']} ${e['name']}',
            value:
                e['grade'].toString().substring(0, 3) +
                e['name'].toString().substring(0, 1),
          ),
        ),
      ],
    );
  }

  void _handleStateChange(String? val) {
    setState(() {
      _selectedValue = val;
    });
  }
}

class ClassTile extends StatelessWidget {
  const ClassTile({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.headline,
  });

  final String headline;
  final String value;
  final String? groupValue;
  final ValueChanged<String?>? onChanged;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        selected: groupValue == value,
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          child: Text(
            value.substring(0, 2) + value.substring(value.length - 1),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.onTertiary,
            ),
          ),
        ),
        trailing: Radio.adaptive(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        title: Text(
          headline,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onTertiaryContainer,
          ),
        ),
        tileColor: Theme.of(context).colorScheme.tertiaryContainer,
        selectedTileColor: Theme.of(context).colorScheme.tertiaryContainer,
        contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        onTap: () => onChanged!(value),
      ),
    );
  }
}

class TimeSelector extends StatefulWidget {
  const TimeSelector({super.key, required this.label, this.expanded = false});

  final bool expanded;
  final String label;

  @override
  State<TimeSelector> createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<TimeSelector> {
  DateTime _date = DateTime.now();
  DateTime _startTime = DateTime.now();
  DateTime _endTime = DateTime.now().add(Duration(minutes: 40));

  void _editLogic() async {
    var resultingDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(Duration(days: 7)),
      lastDate: DateTime.now().add(Duration(days: 30)),
      initialDate: _date,
      helpText: "Select a date with a lesson",
    );
    setState(() {
      _date = resultingDate ?? DateTime.now();
    });
    // ? MAYBE CHANGE TO NORMAL LIST DIALOG? (with lessons)

    var startTimeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: _startTime.hour, minute: _startTime.minute),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
      helpText:
          "Select lesson start time on ${resultingDate != null ? DateFormat('dd/MM/yy').format(resultingDate) : ""}",
    );
    setState(() {
      if (startTimeOfDay != null) {
        _startTime = DateTime(
          _date.year,
          _date.month,
          _date.day,
          startTimeOfDay.hour,
          startTimeOfDay.minute,
        );
        _endTime = DateTime(
          _date.year,
          _date.month,
          _date.day,
          startTimeOfDay.hour,
          startTimeOfDay.minute,
        ).add(Duration(minutes: 40));
      }
    });
    var endTimeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: _endTime.hour, minute: _endTime.minute),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
      helpText:
          "Select lesson end time on ${resultingDate != null ? DateFormat('dd/MM/yy').format(resultingDate) : ""}",
    );
    setState(() {
      if (endTimeOfDay != null) {
        _endTime = DateTime(
          _date.year,
          _date.month,
          _date.day,
          endTimeOfDay.hour,
          endTimeOfDay.minute,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      width: widget.expanded ? null : 180,
      padding: EdgeInsets.all(10.0),
      child:
          widget.expanded
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.label,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat("dd.MM.yy").format(_date),
                        style: Theme.of(
                          context,
                        ).textTheme.headlineSmall?.copyWith(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                      Text(
                        "${DateFormat(DateFormat.HOUR24_MINUTE).format(_startTime)} - ${DateFormat(DateFormat.HOUR24_MINUTE).format(_endTime)}",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                      OutlinedButton.icon(
                        onPressed: _editLogic,
                        label: Text(
                          "Edit",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        icon: Icon(
                          Icons.today,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              )
              : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Text(
                    widget.label,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  Text(
                    DateFormat("dd.MM.yy").format(_date),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  Text(
                    "${DateFormat(DateFormat.HOUR24_MINUTE).format(_startTime)} - ${DateFormat(DateFormat.HOUR24_MINUTE).format(_endTime)}",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton.icon(
                        onPressed: _editLogic,
                        label: Text(
                          "Edit",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        icon: Icon(
                          Icons.today,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
    );
  }
}

class ConnectedButtonGroup extends StatefulWidget {
  const ConnectedButtonGroup({
    super.key,
    this.selected = 0,
    this.labels = const ["Item 1", "Item 2", "Item 3"],
  });

  final int selected;
  final List<String> labels;

  @override
  State<ConnectedButtonGroup> createState() => _ConnectedButtonGroupState();
}

class _ConnectedButtonGroupState extends State<ConnectedButtonGroup> {
  late int active;

  @override
  void initState() {
    super.initState();
    active = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 2.0,
      children:
          widget.labels.asMap().entries.map((entry) {
            final idx = entry.key;
            final label = entry.value;
            final isSelected = idx == active;
            if (isSelected) {
              return FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  foregroundColor: Theme.of(context).colorScheme.onSecondary,
                ),
                child: Text(label),
              );
            } else {
              return FilledButton.tonal(
                onPressed: () {
                  setState(() {
                    active = idx;
                  });
                },
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        idx == 0
                            ? BorderRadius.horizontal(
                              right: Radius.circular(8.0),
                              left: Radius.circular(24.0),
                            )
                            : idx == widget.labels.length - 1
                            ? BorderRadius.horizontal(
                              left: Radius.circular(8.0),
                              right: Radius.circular(24.0),
                            )
                            : BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
                child: Text(label),
              );
            }
          }).toList(),
    );
  }
}

class TeacherClass extends StatelessWidget {
  const TeacherClass({
    super.key,
    required this.lesson,
    required this.classGrade,
    this.startTime,
    this.endTime,
    this.first = false,
    this.last = false,
    this.onTap,
  });

  final String lesson;
  final String classGrade;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final bool first;
  final bool last;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    var startTimeStr = startTime?.format(context).toString();

    var endTimeStr = endTime?.format(context).toString();
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(first ? 12.0 : 4.0),
            topRight: Radius.circular(first ? 12.0 : 4.0),
            bottomLeft: Radius.circular(last ? 12.0 : 4.0),
            bottomRight: Radius.circular(last ? 12.0 : 4.0),
          ),
        ),
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    child: Text(
                      classGrade.substring(0, 2) +
                          classGrade.substring(classGrade.length - 1),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lesson,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        (startTime != null && endTime != null)
                            ? "$classGrade \u2022 $startTimeStr - $endTimeStr"
                            : classGrade,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.arrow_right),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LatestNotices extends StatelessWidget {
  const LatestNotices({super.key, required this.noticeList});

  final List noticeList;

  @override
  Widget build(BuildContext context) {
    noticeList.sort((a, b) {
      final sorted = DateTime.parse(
        a['createdAt'],
      ).compareTo(DateTime.parse(b['createdAt']));
      return sorted.isNegative ? 1 : -1;
    });
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceBright,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Latest Notices',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(
              height: 240,
              child: CarouselView(
                backgroundColor:
                    Theme.of(context).colorScheme.tertiaryContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28.0),
                ),
                padding: EdgeInsets.all(16.0),
                itemSnapping: true,
                scrollDirection: Axis.horizontal,
                itemExtent: MediaQuery.of(context).size.width * 0.8,
                shrinkExtent: MediaQuery.of(context).size.width * 0.8,
                onTap: (i) {
                  if (i == 0) {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      showDragHandle: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16.0),
                        ),
                      ),
                      builder:
                          (context) => AnimatedPadding(
                            duration: Duration(milliseconds: 100),
                            curve: Curves.easeOut,
                            padding: EdgeInsetsGeometry.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: DraggableScrollableSheet(
                              expand: false,
                              maxChildSize: 0.9,
                              initialChildSize: 0.7,
                              minChildSize: 0.7,
                              builder: (context, scrollController) {
                                return CreateNoticeModal(
                                  scrollController: scrollController,
                                );
                              },
                            ),
                          ),
                    );
                  } else {
                    Navigator.pushNamed(
                      context,
                      '/notice',
                      arguments: noticeList[i - 1]['id'],
                    );
                  }
                },
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceBright,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_circle,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        Text(
                          'Create new notice',
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...noticeList.map(
                    (notice) => Notice(
                      title: notice['title'],
                      author: notice['author'],
                      content: notice['content'],
                      date: DateTime.parse(notice['createdAt']),
                      tags: notice['tags'],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Notice extends StatelessWidget {
  const Notice({
    super.key,
    required this.title,
    required this.author,
    required this.date,
    required this.content,
    this.tags = const [],
  });

  final String title;
  final String author;
  final DateTime date;
  final String content;
  final List tags;

  @override
  Widget build(BuildContext context) {
    var daysAgo = DateTime.now().difference(date).inDays;
    String daysAgoText;

    if (daysAgo == 0) {
      daysAgoText = "Today";
    } else if (daysAgo == 1) {
      daysAgoText = "1 day ago";
    } else {
      daysAgoText = "$daysAgo days ago";
    }

    final Delta delta = Delta.fromJson(jsonDecode(content));
    final Document document = Document.fromDelta(delta);

    return Padding(
      padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                ),
              ),
              Text(
                "$author \u2022	$daysAgoText",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                document.toPlainText(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,

                child: Row(
                  children:
                      tags
                          .map(
                            (tag) => Row(
                              children: [
                                NoticeTag(tag: tag),
                                SizedBox(width: 8.0),
                              ],
                            ),
                          )
                          .toList(),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(child: Text("Read more"), onPressed: () => {}),
            ],
          ),
        ],
      ),
    );
  }
}

class NoticeTag extends StatelessWidget {
  const NoticeTag({super.key, required this.tag});

  final String tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(1000.0)),
        color: Theme.of(context).colorScheme.tertiary,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0),
        child: Text(
          "#$tag",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onTertiary,
          ),
        ),
      ),
    );
  }
}

// TODO: class count
class Header extends StatelessWidget {
  const Header({super.key, required this.prefs});

  final String? prefs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4.0,
        children: [
          Text(
            prefs != ''
                ? 'Good ${TimeOfDay.now().hour < 12 ? 'Morning' : 'Afternoon'}, $prefs!'
                : 'Good ${TimeOfDay.now().hour < 12 ? 'Morning' : 'Afternoon'}!',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          Text(
            'You have 5 classes today',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

// helper
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
