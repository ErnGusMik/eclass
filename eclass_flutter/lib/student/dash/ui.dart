import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class StudentDash extends StatefulWidget {
  const StudentDash({super.key});

  @override
  State<StudentDash> createState() => _StudentDashState();
}

class _StudentDashState extends State<StudentDash> {
  String firstName = '';
  List notices = [];
  List classes = [];

  bool isLoading = true;

  Future<void> loadNotices() async {
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    final response = await get(
      Uri.parse('http://192.168.1.106:8080/notices/latest'),
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
      Uri.parse('http://192.168.1.106:8080/teacher/class/get/all'),
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
                      "Your classes",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Lessons(),
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
                      "Grades",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(
                      height: 250,
                      child: CarouselView(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28.0),
                        ),
                        padding: EdgeInsets.all(8.0),
                        itemSnapping: true,
                        scrollDirection: Axis.horizontal,
                        itemExtent: MediaQuery.of(context).size.width * 0.5,
                        shrinkExtent: MediaQuery.of(context).size.width * 0.5,
                        onTap: (i) {
                          // Handle tap
                        },
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(context)
                                      .colorScheme
                                      .primaryContainer, // TODO: change to error background if below avg
                              borderRadius: BorderRadius.circular(28.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'English HL',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium?.copyWith(
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.onPrimaryContainer,
                                    ),
                                  ),
                                  Text(
                                    'Mrs. Smith',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall?.copyWith(
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    spacing: 10.0,
                                    children: [
                                      Text('6.8', style: Theme.of(context).textTheme.displayLarge?.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer)),
                                      Icon(Icons.arrow_drop_up, color: Theme.of(context).colorScheme.onPrimaryContainer),
                                    ],
                                  ),
                                  Text('Keep it up!', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer)),
                                  Expanded(child: SizedBox(),),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(onPressed: () {
                                        // Handle view more
                                      }, child: Text('View more'))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(context)
                                      .colorScheme
                                      .primaryContainer, // TODO: change to error background if below avg
                              borderRadius: BorderRadius.circular(28.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'English HL',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium?.copyWith(
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.onPrimaryContainer,
                                    ),
                                  ),
                                  Text(
                                    'Mrs. Smith',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall?.copyWith(
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    spacing: 10.0,
                                    children: [
                                      Text('6.8', style: Theme.of(context).textTheme.displayLarge?.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer)),
                                      Icon(Icons.arrow_drop_up, color: Theme.of(context).colorScheme.onPrimaryContainer),
                                    ],
                                  ),
                                  Text('Keep it up!', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer)),
                                  Expanded(child: SizedBox(),),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(onPressed: () {
                                        // Handle view more
                                      }, child: Text('View more'))
                                    ],
                                  )
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

              ClassGroup(classes: classes),
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

class Lessons extends StatefulWidget {
  const Lessons({
    super.key,
  });

  @override
  State<Lessons> createState() => _LessonsState();
}

class _LessonsState extends State<Lessons> {
  DateTime selectedDate = DateTime.now();
  List lessons = [];
  bool _isLoading = true;

  Future<void> loadLessons() async {
    setState(() {
      _isLoading = true;
      lessons = [];
    });
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    final response = await get(
      Uri.parse(
        'http://192.168.1.106:8080/student/lessons/get?date=${selectedDate.toIso8601String()}',
      ),
      headers: {'Authorization': 'Bearer $idToken'},
    );
    final body = jsonDecode(response.body);
    // final allLessons = await get(
    //   Uri.parse(
    //     'http://192.168.1.106:8080/teacher/lesson/get/all?classId=1',
    //   ),
    //   headers: {'Authorization': 'Bearer $idToken'},
    // );
    // if (allLessons.statusCode != 200) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('An error occured while loading lessons')),
    //   );
    // }
    setState(() {
      lessons = body['lessons'];
      _isLoading = false;
    });
  }

  // @override
  // void didUpdateWidget(oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   // reload data only when chip date changes
  //   if (selectedDate != oldWidget.selectedDate) {
  //     loadLessons(); // reload data if input changes
  //   }
  // }
  @override
  void initState() {
    super.initState();
    loadLessons();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.0,
      children: [
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
              loadLessons();
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

        if (_isLoading)
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                color: Colors.white,
                height: 400,
                width: double.maxFinite,
              ),
            ),
          ),

          ...lessons.map((lesson) {
            return TeacherClass(
              lesson: lesson,
              startTime: TimeOfDay.fromDateTime(DateTime.parse(lesson['datetime'])),
              endTime: TimeOfDay.fromDateTime(DateTime.parse(lesson['datetime'])),
            );
          }),

        // ...lessons.map((lesson) {
        //   final assessment = lesson['assessment'];
        //   return LessonCard(
        //     assessmentFunc: widget.assessmentFunc,
        //     duration: lesson['duration'],
        //     notes: lesson['notes'] ?? '',
        //     topic: lesson['topic'] ?? '',
        //     lessonId: lesson['id'],
        //     room: lesson['room'],
        //     time: DateTime.parse(lesson['datetime']),
        //     hwAssigned: lesson['hw_assigned'],
        //     hwDue: lesson['hw_due'],
        //     allLessonsList: allLessonsList,
        //     assessment: assessment == false ? '' : assessment['topic'],
        //     assessmentSys: assessment == false ? '' : assessment['sys'],
        //     assessmentId: assessment == false ? null : assessment['id'],
        //     className: widget.className,
        //     gradeName: widget.gradeName,
        //   );
        // }),

        if (lessons.isEmpty && !_isLoading)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: Center(
              child: Text(
                "Hooray! No lessons today!",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
      ],
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 10.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         TeacherClass(
  //           lesson: "Theory of Knowledge",
  //           classGrade: "DP2",
  //           startTime: TimeOfDay(hour: 8, minute: 20),
  //           endTime: TimeOfDay(hour: 9, minute: 0),
  //           first: true,
  //         ),
  //         TeacherClass(
  //           lesson: "Theory of Knowledge",
  //           classGrade: "DP2",
  //           startTime: TimeOfDay(hour: 9, minute: 10),
  //           endTime: TimeOfDay(hour: 9, minute: 50),
  //         ),
  //         TeacherClass(
  //           lesson: "English B",
  //           classGrade: "MYP5",
  //           startTime: TimeOfDay(hour: 10, minute: 0),
  //           endTime: TimeOfDay(hour: 10, minute: 40),
  //         ),
  //         TeacherClass(
  //           lesson: "English B",
  //           classGrade: "MYP5",
  //           startTime: TimeOfDay(hour: 10, minute: 50),
  //           endTime: TimeOfDay(hour: 11, minute: 30),
  //         ),
  //         TeacherClass(
  //           lesson: "English B",
  //           classGrade: "MYP5",
  //           startTime: TimeOfDay(hour: 11, minute: 40),
  //           endTime: TimeOfDay(hour: 12, minute: 20),
  //           last: true,
  //         ),
  //       ],
  //     ),
  //   );
  // }
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

class TeacherClass extends StatelessWidget {
  const TeacherClass({
    super.key,
    required this.lesson,
    this.startTime,
    this.endTime,
    this.first = false,
    this.last = false,
    this.onTap,
  });

  final lesson;
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
                      lesson['name']
                          .toString()
                          .split(' ')
                          .map((e) => e.isNotEmpty ? e[0] : '')
                          .take(3)
                          .join()
                          .toUpperCase(),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lesson['name'],
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
                            ? "$startTimeStr - $endTimeStr"
                            : '',
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
                  Navigator.pushNamed(
                    context,
                    '/notice',
                    arguments: noticeList[i]['id'],
                  );
                },
                children: [
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
