import 'package:eclass_flutter/teacher_panel/dash/ui.dart';
import 'package:eclass_flutter/teacher_panel/lesson_page/ui.dart';
import 'package:flutter/material.dart';

final List<Widget> _pages = [TeacherDash(), TeacherLesson()];

class TeacherUI extends StatefulWidget {
  const TeacherUI({super.key});

  @override
  State<TeacherUI> createState() => _TeacherUIState();
}

class _TeacherUIState extends State<TeacherUI> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        selectedIndex: selected,
        onDestinationSelected: (int index) {
          setState(() {
            selected = index;
          });
        },
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
      appBar: AppBarW(),
      body: AnimatedSwitcher(
        transitionBuilder:
            (child, animation) =>
                FadeTransition(opacity: animation, child: child),
        duration: Duration(milliseconds: 50),
        child: _pages[selected],
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
