import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TeacherLesson extends StatelessWidget {
  const TeacherLesson({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsetsGeometry.all(16.0),
        child: Column(
          spacing: 32.0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(),
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
                      TroubleStudent(name: "John Smith", reason: "Avg grade 3.1",)
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TroubleStudent extends StatelessWidget {
  const TroubleStudent({
    super.key,
    required this.name,
    required this.reason
  });

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
              color: Theme.of(context).colorScheme.onPrimaryContainer
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          reason,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant
          ),
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.chat_bubble_outline))
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
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4.0,
      children: [
        Text(
          'Theory of Knowledge',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        Text(
          'Class DP2 \u2022 Code: XYZ123',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
