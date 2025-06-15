import 'package:flutter/material.dart';





class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
    required this.selected
  });
  final int selected;
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      selectedIndex: widget.selected,
      onDestinationSelected: (int index) {
        setState(() {
          // selected = index;
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
    );
  }
}