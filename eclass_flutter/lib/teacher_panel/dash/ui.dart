import 'package:flutter/material.dart';

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
                            onPressed: () => {},
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
                            onPressed: () => {},
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
                            onPressed: () => {},
                            style: FilledButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                vertical: 6.0,
                                horizontal: 12.0,
                              ),
                            ),
                            child: Text("Cancel lesson"),
                          ),
                          FilledButton(
                            onPressed: () => {},
                            style: FilledButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                vertical: 6.0,
                                horizontal: 12.0,
                              ),
                            ),
                            child: Text("Add lesson topic"),
                          ),
                          FilledButton.tonal(
                            onPressed: () => {},
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
                      TeacherClass(
                        lesson: "English B HL",
                        classGrade: "MYP4",
                      ),
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
                            color: Theme.of(context).colorScheme.outline
                          )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              IconButton(onPressed: () => {}, icon: Icon(Icons.add_circle_outline),),
                              Text(
                                "Create new class",
                                style: Theme.of(context).textTheme.titleMedium,
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.0)
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        destinations: [
            NavigationDestination(icon: Icon(Icons.home_outlined), label: "Dashboard", selectedIcon: Icon(Icons.home),),
            NavigationDestination(icon: Icon(Icons.school_outlined), label: "Overviews", selectedIcon: Icon(Icons.school),),
            NavigationDestination(icon: Icon(Icons.schedule), label: "Schedule", selectedIcon: Icon(Icons.schedule), enabled: false,),
            NavigationDestination(icon: Icon(Icons.inbox_outlined), label: "E-mail", selectedIcon: Icon(Icons.inbox), enabled: false,)
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
              height: 220.0,
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
