import 'package:eclass_flutter/teacher_panel/teacherUI.dart';
import 'package:flutter/material.dart';

class TeacherLesson extends StatelessWidget {
  const TeacherLesson({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(selected: 1,),
    );
  }
}