import 'dart:convert';
import 'package:animations/animations.dart';
import 'package:eclass_flutter/teacher_panel/dash/ui.dart';
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
      Uri.parse('http://10.173.158.188:8080/teacher/class/get?id=$classID'),
      headers: {'Authorization': 'Bearer $idToken'},
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
                                      Theme.of(
                                        context,
                                      ).colorScheme.tertiaryContainer,
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
                                      Theme.of(
                                        context,
                                      ).colorScheme.tertiaryContainer,
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
                                    Theme.of(
                                      context,
                                    ).colorScheme.onPrimaryContainer,
                              ),
                            ),
                            TroubleStudent(
                              name: "John Smith",
                              reason: "Avg grade 3.1",
                            ),
                            TroubleStudent(
                              name: "John Doe",
                              reason: "12 absences",
                            ),
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
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
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
                      Text(
                        "Settings",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
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
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  showDragHandle: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16.0),
                                    ),
                                  ),
                                  builder:
                                      (context) => AnimatedPadding(
                                        padding: EdgeInsetsGeometry.only(
                                          bottom:
                                              MediaQuery.of(
                                                context,
                                              ).viewInsets.bottom,
                                        ),
                                        duration: Duration(milliseconds: 100),
                                        curve: Curves.easeOut,
                                        child: DraggableScrollableSheet(
                                          maxChildSize: 0.9,
                                          expand: false,
                                          builder:
                                              (context, scrollController) =>
                                                  SingleChildScrollView(
                                                    controller:
                                                        scrollController,
                                                    child: ScheduleLessonsModal(
                                                      className: className,
                                                      gradeName: gradeName,
                                                    ),
                                                  ),
                                        ),
                                      ),
                                );
                              },
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
                                backgroundColor:
                                    Theme.of(context).colorScheme.error,
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

class ScheduleLessonsModal extends StatefulWidget {
  const ScheduleLessonsModal({
    super.key,
    required this.className,
    required this.gradeName,
  });

  final String className;
  final String gradeName;

  @override
  State<ScheduleLessonsModal> createState() => _ScheduleLessonsModalState();
}

class _ScheduleLessonsModalState extends State<ScheduleLessonsModal> {
  List schedules = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(26.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  'Schedule Lessons',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text(' \u2022 '),
                // TODO: YOU LEFT HERE. do full-screen dialog below
              ],
            ),
          ),
          OpenContainer(
            openColor: Theme.of(context).colorScheme.surfaceContainerLow,
            closedColor: Theme.of(context).colorScheme.surfaceContainerLow,
            transitionType: ContainerTransitionType.fadeThrough,
            closedElevation: 0.0,
            openBuilder:
                (context, _) => NewScheduleDialog(
                  className: widget.className,
                  gradeName: widget.gradeName,
                ),
            closedBuilder:
                (context, openContainer) => GestureDetector(
                  onTap: openContainer,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(4.0),
                        bottom: Radius.circular(12.0),
                      ),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    child: Column(
                      spacing: 16,
                      children: [
                        Icon(Icons.add_circle),
                        Text(
                          'Schedule more lessons',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ),
                ),
          ),
        ],
      ),
    );
  }
}

class NewScheduleDialog extends StatefulWidget {
  const NewScheduleDialog({
    super.key,
    required this.className,
    required this.gradeName,
  });

  final String className;
  final String gradeName;

  @override
  State<NewScheduleDialog> createState() => _NewScheduleDialogState();
}

class _NewScheduleDialogState extends State<NewScheduleDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String name = '';
  TextEditingController dayController = TextEditingController();
  String? dayError;
  TimeOfDay startTime = TimeOfDay(hour: 8, minute: 0);
  Duration duration = Duration(minutes: 40);
  List<DateTimeRange> exceptions = [];
  DateTimeRange? editingRange;
  String? rangeError;

  Future<void> handleSubmit() async {
    final idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    final response = await post(
      Uri.parse('') // TODO: YOU LEFT HERE. do the server now.
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                  child: AppBar(
                    backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close),
                    ),
                    title: Text(
                      "Schedule lessons",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (dayController.text == 'null') {
                              setState(() {
                                dayError = 'Select a day of the week';
                              });
                              return;
                            }
                            _formKey.currentState!.save();
                            handleSubmit();
                          }
                        },
                        child: Text("Save"),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 26.0,
                    vertical: 32.0,
                  ),
                  child: Column(
                    spacing: 16.0,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        style: Theme.of(context).textTheme.bodyLarge,
                        decoration: InputDecoration(
                          labelText: "Schedule name",
                          helperText:
                              'This schedule will be generated until June 31st.',
                          helperMaxLines: 2,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter a schedule name";
                          }
                        },
                        onSaved: (newValue) {
                          setState(() {
                            name = newValue!;
                          });
                        },
                      ),
                      TextFormField(
                        readOnly: true,
                        controller: TextEditingController(
                          text: '${widget.gradeName} ${widget.className}',
                        ),
                        decoration: InputDecoration(
                          labelText: "Class/course",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                          enabled: false,
                        ),
                      ),
                      Divider(
                        color: Theme.of(context).colorScheme.outlineVariant,
                      ),
                      DropdownMenu(
                        helperText:
                            "You will be able to add more schedules later.",
                        width: double.infinity,
                        initialSelection: 'null',
                        label: Text('Day of week'),
                        textStyle: Theme.of(context).textTheme.bodyLarge,
                        trailingIcon: Icon(Icons.arrow_drop_down),
                        menuStyle: MenuStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Theme.of(context).colorScheme.surfaceContainer,
                          ),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          elevation: WidgetStatePropertyAll(2),
                          shadowColor: WidgetStatePropertyAll(
                            Theme.of(context).colorScheme.shadow,
                          ),
                          minimumSize: WidgetStatePropertyAll(
                            Size(MediaQuery.of(context).size.width - 26 * 2, 0),
                          ),
                          maximumSize: WidgetStatePropertyAll(
                            Size(
                              MediaQuery.of(context).size.width - 26 * 2,
                              double.infinity,
                            ),
                          ),
                        ),
                        dropdownMenuEntries: [
                          DropdownMenuEntry(value: 'null', label: 'Select one'),
                          DropdownMenuEntry(value: 'mon', label: 'Monday'),
                          DropdownMenuEntry(value: 'tue', label: 'Tuesday'),
                          DropdownMenuEntry(value: 'wed', label: 'Wednesday'),
                          DropdownMenuEntry(value: 'thu', label: 'Thursday'),
                          DropdownMenuEntry(value: 'fri', label: 'Friday'),
                          DropdownMenuEntry(value: 'sat', label: 'Saturday'),
                          DropdownMenuEntry(value: 'sun', label: 'Sunday'),
                        ],
                        controller: dayController,
                        errorText: dayError,
                      ),
                      Row(
                        spacing: 16.0,
                        children: [
                          Expanded(
                            child: TextFormField(
                              onTap: () async {
                                final newTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay(hour: 0, minute: 0),
                                  helpText: "Select start time",
                                );
                                setState(() {
                                  startTime = newTime!;
                                });
                              },
                              readOnly: true,
                              controller: TextEditingController(
                                text: startTime.format(context),
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                  ),
                                ),
                                labelText: "Start time",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Select a lesson start time!';
                                }
                              },
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: TextEditingController(text: '40'),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                  ),
                                ),
                                labelText: "Duration",
                                suffixText: 'min',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter a lesson duration';
                                }

                                try {
                                  if (int.parse(value!) < 1) {
                                    return 'Enter a valid lesson duration';
                                  }
                                } catch (e) {
                                  return 'Did you enter a valid duration?';
                                }
                              },
                              onSaved: (newValue) {
                                setState(() {
                                  duration = Duration(
                                    minutes: int.parse(newValue!),
                                  );
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Theme.of(context).colorScheme.outlineVariant,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8.0,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller:
                                  editingRange == null
                                      ? null
                                      : TextEditingController(
                                        text:
                                            '${DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(editingRange!.start)} - ${DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(editingRange!.end)}',
                                      ),
                              readOnly: true,
                              onTap: () async {
                                final newDateRange = await showDateRangePicker(
                                  context: context,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2030),
                                  helpText: "Select exception date range",
                                );
                                setState(() {
                                  editingRange = newDateRange;
                                });
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                  ),
                                ),
                                labelText: "Exception",
                                helperText:
                                    'Lessons won\'t be added on these days, e.g school holidays.',
                                helperMaxLines: 3,
                                errorText: rangeError,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: FilledButton.tonalIcon(
                              onPressed: () {
                                if (editingRange == null) {
                                  setState(() {
                                    rangeError = 'Enter a valid date range';
                                  });
                                  return;
                                } else if (exceptions.contains(editingRange)) {
                                  setState(() {
                                    rangeError =
                                        'This exception already exists';
                                  });
                                  return;
                                }

                                setState(() {
                                  rangeError = null;
                                });
                                exceptions.add(editingRange!);
                              },
                              label: Text('Add'),
                              icon: Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),

                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            spacing: 8.0,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Exceptions',
                                style: Theme.of(
                                  context,
                                ).textTheme.labelSmall?.copyWith(
                                  color:
                                      Theme.of(
                                        context,
                                      ).colorScheme.onPrimaryContainer,
                                ),
                              ),
                              ...exceptions.map((exception) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    borderRadius: BorderRadius.vertical(
                                      top:
                                          exception == exceptions[0]
                                              ? Radius.circular(12.0)
                                              : Radius.circular(4.0),
                                      bottom:
                                          exception ==
                                                  exceptions[exceptions.length -
                                                      1]
                                              ? Radius.circular(12.0)
                                              : Radius.circular(4.0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(exception.start)} - ${DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(exception.end)}',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.labelLarge?.copyWith(
                                            color:
                                                Theme.of(
                                                  context,
                                                ).colorScheme.onPrimary,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              exceptions.remove(exception);
                                            });
                                          },
                                          icon: Icon(Icons.delete_outline),
                                          color:
                                              Theme.of(
                                                context,
                                              ).colorScheme.onPrimary,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                              if (exceptions.isEmpty)
                                Padding(
                                  padding: EdgeInsetsGeometry.all(16.0),
                                  child: Center(
                                    child: Text(
                                      'You haven\'t added any exceptions yet!',
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
  const Header({
    super.key,
    required this.name,
    required this.grade,
    required this.code,
    required this.isLoading,
  });

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
        isLoading
            ? loadingBlocks(Theme.of(context).textTheme.displayMedium!, 200)
            : Text(name, style: Theme.of(context).textTheme.displayMedium),
        isLoading
            ? loadingBlocks(Theme.of(context).textTheme.titleMedium!, 150)
            : Text(
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
