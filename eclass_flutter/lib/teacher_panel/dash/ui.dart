import 'package:flutter/material.dart';

class TeacherDash extends StatelessWidget {
  const TeacherDash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarW(),
      body: Column(
        children: [
          Header(),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),     
              child: Column(    
                crossAxisAlignment: CrossAxisAlignment.start,  
                children: [
                  Text(
                    'Latest Notices',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

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
          )
        ],
      ),
    );
  }
}


class AppBarW extends StatelessWidget implements PreferredSizeWidget {
  const AppBarW({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

 @override
  Widget build(BuildContext context) {
    return AppBar(
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