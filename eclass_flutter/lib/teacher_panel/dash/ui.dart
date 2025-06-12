import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:intl/intl.dart';

class TeacherDash extends StatelessWidget {
  const TeacherDash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarW(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          spacing: 28.0,
          children: [
            Header(),
            LatestNotices(),
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
                                      return DraggableScrollableSheet(
                                        expand: false,
                                        maxChildSize: 0.9,
                                        builder: (context, scrollContainer) {
                                          return SingleChildScrollView(
                                            controller: scrollContainer,
                                            child: HomeworkModal(),
                                          );
                                        },
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
                                color: Theme.of(context).colorScheme.onPrimary,
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
                                        (context) => DraggableScrollableSheet(
                                          expand: false,
                                          maxChildSize: 0.9,
                                          builder:
                                              (context, scrollController) =>
                                                  SingleChildScrollView(
                                                    controller:
                                                        scrollController,
                                                    child: TestModal(),
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
                                builder: (context) => LessonTopicModal(),
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
                                    (context) => DraggableScrollableSheet(
                                      expand: false,
                                      maxChildSize: 0.9,
                                      builder:
                                          (context, scrollController) =>
                                              CreateNoticeModal(
                                                scrollController:
                                                    scrollController,
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
                      TeacherClass(
                        lesson: "Theory of Knowledge",
                        classGrade: "DP2",
                        first: true,
                      ),
                      TeacherClass(
                        lesson: "Theory of Knowledge",
                        classGrade: "DP1",
                      ),
                      TeacherClass(lesson: "English B SL", classGrade: "MYP5"),
                      TeacherClass(lesson: "English B HL", classGrade: "MYP5"),
                      TeacherClass(lesson: "English B HL", classGrade: "MYP4"),
                      Card(
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
                              IconButton(
                                onPressed: () => {},
                                icon: Icon(Icons.add_circle_outline),
                              ),
                              Text(
                                "Create new class",
                                style: Theme.of(context).textTheme.titleMedium,
                                textAlign: TextAlign.center,
                              ),
                            ],
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
      bottomNavigationBar: NavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: "Dashboard",
            selectedIcon: Icon(Icons.home),
          ),
          NavigationDestination(
            icon: Icon(Icons.school_outlined),
            label: "Overviews",
            selectedIcon: Icon(Icons.school),
          ),
          NavigationDestination(
            icon: Icon(Icons.schedule),
            label: "Schedule",
            selectedIcon: Icon(Icons.schedule),
            enabled: false,
          ),
          NavigationDestination(
            icon: Icon(Icons.inbox_outlined),
            label: "E-mail",
            selectedIcon: Icon(Icons.inbox),
            enabled: false,
          ),
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
  late QuillController _controller;

  @override
  void initState() {
    super.initState();
    _controller = QuillController(
      document: Document(),
      selection: const TextSelection.collapsed(offset: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 100),
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
                    maxLines: null,
                    style: Theme.of(context).textTheme.bodyLarge,
                    decoration: InputDecoration(
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
                    height: 224,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainerHigh,
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      ),
                      child: QuillEditor.basic(
                        controller: _controller,
                        scrollController: ScrollController(),
                        config: QuillEditorConfig(
                          placeholder: "Notice",
                          padding: EdgeInsets.all(16.0),
                          minHeight: 224.0,
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
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.format_bold),
                    onPressed: () => _controller.formatSelection(Attribute.bold),
                  ),
                  Text("Some text goes here"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
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
  const TestModal({super.key});

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
                ClassGroup(),
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
  const HomeworkModal({super.key});

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
                ClassGroup(),
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
  const ClassGroup({super.key});

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
        ClassTile(
          value: "DP2E",
          headline: "DP2 English",
          groupValue: _selectedValue,
          onChanged: _handleStateChange,
        ),
        ClassTile(
          value: "DP1E",
          headline: "DP1 English",
          groupValue: _selectedValue,
          onChanged: _handleStateChange,
        ),
        ClassTile(
          value: "MYP5E",
          headline: "MYP5 English",
          groupValue: _selectedValue,
          onChanged: _handleStateChange,
        ),
        ClassTile(
          value: "MYP4E",
          headline: "MYP4 English",
          groupValue: _selectedValue,
          onChanged: _handleStateChange,
        ),
        ClassTile(
          value: "MYP3E",
          headline: "MYP3 English",
          groupValue: _selectedValue,
          onChanged: _handleStateChange,
        ),
        ClassTile(
          value: "MYP2E",
          headline: "MYP2 English",
          groupValue: _selectedValue,
          onChanged: _handleStateChange,
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

class ConnectedButtonGroup extends StatelessWidget {
  const ConnectedButtonGroup({
    super.key,
    this.selected = 0,
    this.labels = const ["Item 1", "Item 2", "Item 3"],
  });

  final int selected;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 2.0,
      children:
          labels.asMap().entries.map((entry) {
            final idx = entry.key;
            final label = entry.value;
            final isSelected = idx == selected;
            if (isSelected) {
              return FilledButton(
                onPressed: () => {},
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  foregroundColor: Theme.of(context).colorScheme.onSecondary,
                ),
                child: Text(label),
              );
            } else {
              return FilledButton.tonal(
                onPressed: () => {},
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        idx == 0
                            ? BorderRadius.horizontal(
                              right: Radius.circular(8.0),
                              left: Radius.circular(24.0),
                            )
                            : idx == labels.length - 1
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
  });

  final String lesson;
  final String classGrade;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final bool first;
  final bool last;

  @override
  Widget build(BuildContext context) {
    var startTimeStr = startTime?.format(context).toString();

    var endTimeStr = endTime?.format(context).toString();
    return Card(
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
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
            IconButton(onPressed: () => {}, icon: Icon(Icons.arrow_right)),
          ],
        ),
      ),
    );
  }
}

class LatestNotices extends StatelessWidget {
  const LatestNotices({super.key});

  @override
  Widget build(BuildContext context) {
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
              height: 230,
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
                  Notice(
                    title: "Exam Schedule for MYP5 & DP2",
                    author: "Jonathan Stevenson",
                    date: DateTime(2025, 5, 27),
                    content:
                        "Hi all!\nAttached is the exam schedule for MYP Year 5 and DP Year 2. Please note, this stuff won't be seen.",
                    tags: [
                      "Exam",
                      "Schedule changes",
                      "Important",
                      "MYP5",
                      "DP2",
                    ],
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
  final List<String> tags;

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

    return Padding(
      padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
      child: Column(
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
            content,
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
                          children: [NoticeTag(tag: tag), SizedBox(width: 8.0)],
                        ),
                      )
                      .toList(),
            ),
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

class Header extends StatelessWidget {
  const Header({super.key});

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
            'Good Morning, Maggie!',
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

class AppBarW extends StatelessWidget implements PreferredSizeWidget {
  const AppBarW({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      leading: Icon(Icons.menu),
      actionsPadding: const EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 0.0),
      title: SearchBar(
        hintText: 'Search all entries',
        elevation: WidgetStateProperty.all(0.0),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
            child: Icon(Icons.person),
          ),
        ),
      ],
    );
  }
}
