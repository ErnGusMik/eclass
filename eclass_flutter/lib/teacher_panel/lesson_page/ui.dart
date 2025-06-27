import 'dart:convert';

import 'package:eclass_flutter/teacher_panel/teacherUI.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class TeacherLesson extends StatefulWidget {
  const TeacherLesson({super.key});

  @override
  State<TeacherLesson> createState() => _TeacherLessonState();
}

class _TeacherLessonState extends State<TeacherLesson> {

  String imgUrl = '';
  String className = '';
  String gradeName = '';
  String classCode = '';
  bool _isLoading = true;

  Future<void> getClassData() async {
    final classID = ModalRoute.of(context)?.settings.arguments as int;
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    final response = await get(
      Uri.parse('http://192.168.88.171:8080/teacher/class/get?id=$classID'),
      headers: {
        'Authorization': 'Bearer $idToken'
      }
    );
    final body = jsonDecode(response.body);
    setState(() {
      className = body['name'];
      gradeName = body['grade'];
      classCode = body['code'];
    });
  }

  Future<void> _loadAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      imgUrl = prefs.getString('picture')!;
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await _loadAvatar();
    await getClassData();
    setState(() {
      _isLoading = false;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppBarW(imgUrl: imgUrl),
            Padding(
              padding: EdgeInsetsGeometry.all(16.0),
              child: Column(
                spacing: 32.0,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(
                    name: className,
                    grade: gradeName,
                    code: classCode,
                    isLoading: _isLoading,
                  ),
                  LessonsSection(),
                  Column(
                    spacing: 16.0,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Class Overview",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          spacing: 16,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(
                                        context,
                                      ).colorScheme.secondaryContainer,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 10,
                                  children: [
                                    Text(
                                      "Total no. of lessons",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.labelSmall?.copyWith(
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.onSecondaryContainer,
                                      ),
                                    ),
                                    Text(
                                      "325",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.headlineLarge?.copyWith(
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.onSecondaryContainer,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.tertiaryContainer,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 10,
                                  children: [
                                    Text(
                                      "Avg. attendance rate",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.labelSmall?.copyWith(
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.onTertiaryContainer,
                                      ),
                                    ),
                                    Text(
                                      "91.7%",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.headlineLarge?.copyWith(
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.onTertiaryContainer,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          spacing: 16,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.tertiaryContainer,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 10,
                                  children: [
                                    Text(
                                      "Avg. grade",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.labelSmall?.copyWith(
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.onTertiaryContainer,
                                      ),
                                    ),
                                    Text(
                                      "6.5",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.headlineLarge?.copyWith(
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.onTertiaryContainer,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(
                                        context,
                                      ).colorScheme.secondaryContainer,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 10,
                                  children: [
                                    Text(
                                      "Avg. score",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.labelSmall?.copyWith(
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.onSecondaryContainer,
                                      ),
                                    ),
                                    Text(
                                      "60.0%",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.headlineLarge?.copyWith(
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.onSecondaryContainer,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Students requiring attention",
                              style: Theme.of(
                                context,
                              ).textTheme.labelMedium?.copyWith(
                                color:
                                    Theme.of(context).colorScheme.onPrimaryContainer,
                              ),
                            ),
                            TroubleStudent(
                              name: "John Smith",
                              reason: "Avg grade 3.1",
                            ),
                            TroubleStudent(name: "John Doe", reason: "12 absences"),
                            TroubleStudent(
                              name: "Elizabeth Gonzalez",
                              reason: "Late 23 times",
                            ),
                            TroubleStudent(
                              name: "Benjamin Dover",
                              reason: "2 missing assignments",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: 8.0,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Upcoming Assessments",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      AssessmentCard(
                        date: 'Thursday',
                        title: "Knowledge and politics: summative assessment",
                      ),
                      AssessmentCard(
                        date: "Friday",
                        title: "Knowledge and science: introduction quiz",
                        summative: false,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 8.0,
                              children: [
                                Icon(Icons.add_circle_outline),
                                Center(
                                  child: Text(
                                    "Create new assessment",
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  StudentsSection(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8.0,
                    children: [
                      Text("Settings", style: Theme.of(context).textTheme.titleLarge),
                      Padding(
                        padding: EdgeInsetsGeometry.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FilledButton.tonalIcon(
                              onPressed: () {},
                              label: Text("Rename"),
                              icon: Icon(Icons.swap_horiz),
                            ),
                            FilledButton.tonalIcon(
                              onPressed: () {},
                              label: Text("Schedule lessons"),
                              icon: Icon(Icons.calendar_today),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsGeometry.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FilledButton.tonal(
                              onPressed: null,
                              child: Text("Add co-teacher"),
                            ),
                            FilledButton.icon(
                              onPressed: () {},
                              label: Text("Delete"),
                              icon: Icon(Icons.delete_outline),
                              style: FilledButton.styleFrom(
                                backgroundColor: Theme.of(context).colorScheme.error,
                                foregroundColor:
                                    Theme.of(context).colorScheme.onError,
                              ),
                            ),
                          ],
                        ),
                      ),
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

class StudentsSection extends StatelessWidget {
  const StudentsSection({super.key});

  static const List<String> students = [
    "John Doe1",
    "John Doe2",
    "John Doe3",
    "John Doe4",
    "John Doe5",
    "John Doe6",
    "John Doe7",
    "John Doe8",
    "John Doe9",
    "John Doe0",
    "John Doe11",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Students", style: Theme.of(context).textTheme.titleLarge),
        SizedBox(height: 8.0),
        ...students.map(
          (student) => Container(
            decoration: BoxDecoration(
              border:
                  student == students[students.length - 1]
                      ? Border()
                      : Border(
                        bottom: BorderSide(
                          color: Theme.of(context).colorScheme.outlineVariant,
                        ),
                      ),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Text(
                  student.split(" ")[0].substring(0, 1) +
                      student
                          .split(" ")[student.split(" ").length - 1]
                          .substring(0, 1),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              title: Text(student, overflow: TextOverflow.ellipsis),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_right_sharp),
              ),
              tileColor: Theme.of(context).colorScheme.surfaceContainerLowest,
              shape: RoundedRectangleBorder(
                borderRadius:
                    students[0] == student
                        ? BorderRadius.vertical(top: Radius.circular(12.0))
                        : students[students.length - 1] == student
                        ? BorderRadius.vertical(bottom: Radius.circular(12.0))
                        : BorderRadius.zero,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AssessmentCard extends StatelessWidget {
  const AssessmentCard({
    super.key,
    required this.date,
    required this.title,
    this.summative = true,
  });

  final String date;
  final String title;
  final bool summative;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          spacing: 10.0,
          children: [
            Expanded(
              child: Column(
                spacing: 10.0,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(date, style: Theme.of(context).textTheme.labelMedium),
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  Text(
                    summative
                        ? "Summative assessment"
                        : "Internal school assessment",
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              spacing: 10.0,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.delete_outlined,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.edit_outlined)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TroubleStudent extends StatelessWidget {
  const TroubleStudent({super.key, required this.name, required this.reason});

  final String name;
  final String reason;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            name,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          reason,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.chat_bubble_outline)),
      ],
    );
  }
}

class LessonsSection extends StatefulWidget {
  const LessonsSection({super.key});

  @override
  State<LessonsSection> createState() => _LessonsSectionState();
}

class _LessonsSectionState extends State<LessonsSection> {
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.0,
      children: [
        Text("Lessons", style: Theme.of(context).textTheme.titleLarge),
        GestureDetector(
          onTap: () async {
            var selectedDateModal = await showDatePicker(
              context: context,
              firstDate: DateTime(2020),
              lastDate: DateTime(2100),
              initialDate: selectedDate,
            );
            if (selectedDateModal != null) {
              setState(() {
                selectedDate = selectedDateModal;
              });
            }
          },
          child: Chip(
            label: Text(DateFormat('dd/MM/yy').format(selectedDate)),
            avatar: Icon(
              Icons.calendar_today,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            labelStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
        ),
        LessonCard(),
        LessonCard(),
      ],
    );
  }
}

class LessonCard extends StatefulWidget {
  const LessonCard({super.key});

  @override
  State<LessonCard> createState() => _LessonCardState();
}

class _LessonCardState extends State<LessonCard> {
  TextEditingController notesController = TextEditingController();
  FocusNode notesFocusNode = FocusNode();
  bool editingNotes = false;

  TextEditingController topicController = TextEditingController();
  FocusNode topicFocusNode = FocusNode();
  bool editingTopic = false;

  TextEditingController hwDueController = TextEditingController();
  FocusNode hwDueFocusNode = FocusNode();
  bool editingHwDue = false;

  TextEditingController hwAssignedController = TextEditingController();
  FocusNode hwAssignedFocusNode = FocusNode();
  bool editingHwAssigned = false;

  TextEditingController assessmentController = TextEditingController();
  FocusNode assessmentFocusNode = FocusNode();
  bool editingAssessment = false;

  @override
  void initState() {
    super.initState();
    notesController.text =
        "Hi class!\nNew topic today -- be ready! I will quiz you on your current knowledge. Don't worry, this will not impact your grades.";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16.0),
      ),
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
      child: Column(
        spacing: 10.0,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "08:20 - 09:00",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                "Room 302",
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4.0,
            children: [
              Text(
                "Notes to class",
                style: Theme.of(context).textTheme.labelSmall,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: notesController,
                      focusNode: notesFocusNode,
                      enabled: editingNotes,
                      decoration: InputDecoration.collapsed(
                        hintText: 'None',
                        hintStyle: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      maxLines: null,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      editingNotes ? Icons.check : Icons.edit_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        editingNotes = !editingNotes;
                      });
                      if (editingNotes) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          notesFocusNode.requestFocus();
                        });
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiaryContainer,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.0,
              children: [
                Text(
                  "Topic",
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onTertiaryContainer,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: topicController,
                        focusNode: topicFocusNode,
                        enabled: editingTopic,
                        decoration: InputDecoration.collapsed(
                          hintText: 'None',
                          hintStyle: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                            color:
                                Theme.of(
                                  context,
                                ).colorScheme.onTertiaryContainer,
                          ),
                        ),
                        maxLines: null,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color:
                              Theme.of(context).colorScheme.onTertiaryContainer,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        editingTopic ? Icons.check : Icons.edit_outlined,
                        color:
                            Theme.of(context).colorScheme.onTertiaryContainer,
                      ),
                      onPressed: () {
                        setState(() {
                          editingTopic = !editingTopic;
                        });
                        if (editingTopic) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            topicFocusNode.requestFocus();
                          });
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.0,
              children: [
                Text(
                  "Homework due",
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: hwDueController,
                        focusNode: hwDueFocusNode,
                        enabled: editingHwDue,
                        decoration: InputDecoration.collapsed(
                          hintText: 'None',
                          hintStyle: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                            color:
                                Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                          ),
                        ),
                        maxLines: null,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        editingHwDue ? Icons.check : Icons.edit_outlined,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      onPressed: () {
                        setState(() {
                          editingHwDue = !editingHwDue;
                        });
                        if (editingHwDue) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            hwDueFocusNode.requestFocus();
                          });
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.0,
              children: [
                Text(
                  "Assigned homework",
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: hwAssignedController,
                        focusNode: hwAssignedFocusNode,
                        enabled: editingHwAssigned,
                        decoration: InputDecoration.collapsed(
                          hintText: 'None',
                          hintStyle: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                            color:
                                Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                          ),
                        ),
                        maxLines: null,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        editingHwAssigned ? Icons.check : Icons.edit_outlined,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      onPressed: () {
                        setState(() {
                          editingHwAssigned = !editingHwAssigned;
                        });
                        if (editingHwAssigned) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            hwAssignedFocusNode.requestFocus();
                          });
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiaryContainer,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.0,
              children: [
                Text(
                  "Assessment",
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onTertiaryContainer,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: assessmentController,
                        focusNode: assessmentFocusNode,
                        enabled: editingAssessment,
                        decoration: InputDecoration.collapsed(
                          hintText: 'None',
                          hintStyle: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                            color:
                                Theme.of(
                                  context,
                                ).colorScheme.onTertiaryContainer,
                          ),
                        ),
                        maxLines: null,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color:
                              Theme.of(context).colorScheme.onTertiaryContainer,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        editingAssessment ? Icons.check : Icons.edit_outlined,
                        color:
                            Theme.of(context).colorScheme.onTertiaryContainer,
                      ),
                      onPressed: () {
                        setState(() {
                          editingAssessment = !editingAssessment;
                        });
                        if (editingAssessment) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            assessmentFocusNode.requestFocus();
                          });
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [FilledButton(child: Text("Details"), onPressed: () {})],
          ),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key, required this.name, required this.grade, required this.code, required this.isLoading});

  final bool isLoading;
  final String name;
  final String grade;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4.0,
      children: [
        isLoading ? loadingBlocks(Theme.of(context).textTheme.displayMedium!, 200) : Text(
          name,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        isLoading ? loadingBlocks(Theme.of(context).textTheme.titleMedium!, 150) : Text(
          'Class $grade \u2022 Code: $code',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}


// helper
Widget loadingBlocks(TextStyle theme, double width, {bool onPrimary = false}) {
  final height = theme.height! * theme.fontSize!;

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      child: Shimmer.fromColors(
        baseColor: onPrimary ? Colors.grey[350]! : Colors.grey[300]!,
        highlightColor: onPrimary ? Colors.grey[200]! : Colors.grey[100]!,
        child: Container(color: Colors.white, height: height, width: width),
      ),
    ),
  );
}
