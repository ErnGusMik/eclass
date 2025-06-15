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
          children: [Header(), LessonsSection()],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
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
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(16.0)
          ),
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
          child: Column(
            spacing: 10.0,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("08:20 - 09:00", style: Theme.of(context).textTheme.titleMedium),
                  Text("Room 302", style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant))
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4.0,
                children: [
                  Text("Notes to class", style: Theme.of(context).textTheme.labelSmall),
                  Row(
                    spacing: 4.0,
                    children: [
                      Expanded(
                        child: Text("Hi class!\nNew topic today -- be ready! I will quiz you on your current knowledge. Don't worry, this will not impact your grades.", style: Theme.of(context).textTheme.bodySmall),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit_outlined),
                        onPressed: () {},
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        )
      ],
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
