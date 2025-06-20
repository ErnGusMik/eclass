import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  var account;
  int tab = 2;
  String errorText = '';
  List classes = [];
  final classCodeController = TextEditingController();
  String? classCodeError;
  String googleText =
      (FirebaseAuth.instance.currentUser?.displayName ??
          'Continue with Google');

  final classNameController = TextEditingController();
  final classGradeController = TextEditingController();

  Future<void> _handleSignIn() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    setState(() {
      _isLoading = true;
    });
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    final response = await get(
      Uri.parse("http://192.168.1.106:8080/auth/login"),
      headers: {"Authorization": "Bearer $idToken"},
    );
    print(response);

    if (response.statusCode == 404) {
      setState(() {
        googleText =
            (FirebaseAuth.instance.currentUser!.displayName ??
                "Signed in with Google");
        _isLoading = false;
        errorText = "";
      });
    } else if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('loggedIn', true);
      Navigator.pushReplacementNamed(context, '/');
    } else {
      setState(() {
        errorText =
            "Could not sign in with Google. Try again later or contact support.";
        _isLoading = false;
      });
    }
  }

  Future<void> _handleSignUp() async {
    if (FirebaseAuth.instance.currentUser == null) {
      setState(() {
        errorText = "Please, sign in with Google first!";
      });
      return;
    }
    if (tab == 2) return;

    if (classNameController.text.trim().isEmpty && tab == 0 ||
        classGradeController.text.trim().isEmpty && tab == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a class/course name and grade")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    final response = await post(
      Uri.parse(
        "http://192.168.1.106:8080/auth/signup?role=${tab == 0 ? 'teacher' : 'student'}",
      ),
      body: {
        "className": classNameController.text.trim(),
        "classGrade": classGradeController.text.trim(),
      },
      headers: {"Authorization": "Bearer $idToken"},
    );
    print(response.statusCode);

    if (response.statusCode == 201) {
      // final prefs = await SharedPreferences.getInstance();
      // await prefs.setBool('loggedIn', true);
      // Navigator.pushReplacementNamed(context, '/teacher');
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _addClass() async {
    final code = classCodeController.text.trim();
    if (code.isEmpty) {
      setState(() {
        classCodeError = 'Enter a class code';
      });
      return;
    }

    if (code.length != 6) {
      setState(() {
        classCodeError = 'A class code must be 6 characters long';
      });
      return;
    }

    if (FirebaseAuth.instance.currentUser == null) {
      setState(() {
        classCodeError = 'Sign in with Google first';
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    final response = await get(
      Uri.parse('http://192.168.1.106:8080/auth/getClass?code=$code'),
      headers: {"Authorization": "Bearer $idToken"},
    );
    if (response.statusCode == 404) {
      setState(() {
        classCodeError =
            "This class wasn't found. Re-check the code and try again.";
        _isLoading = false;
      });
    } else if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      classes.add({
        "name": data["name"],
        "teacher": data['teachers'].join(', ')
      });
      setState(() {
        _isLoading = false;
        classCodeError = null;
      });
    } else {
      setState(() {
        classCodeError = "There seems to be an error. Try again later.";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabs = [
      Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 12.0,
          children: [
            Text(
              "Create your first class",
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
            TextField(
              controller: classNameController,
              decoration: InputDecoration(
                labelText: "Class/course name",
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: classGradeController,
              decoration: InputDecoration(
                labelText: "Grade name",
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
                border: OutlineInputBorder(),
                helperText:
                    "Enter the grade with the corresponding letters, eg. 11A or DP2",
                helperMaxLines: 2,
                helperStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ),
            ),
          ],
        ),
      ),
      Column(
        spacing: 16.0,
        children: [
          Row(
            spacing: 12.0,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextField(
                  controller: classCodeController,
                  decoration: InputDecoration(
                    labelText: "Class code",
                    helperText: "Enter the class code as shown by your teacher",
                    helperMaxLines: 2,
                    filled: true,
                    errorText: classCodeError,
                    errorMaxLines: 2,
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: _addClass,
                label: Text("Add class"),
                icon: Icon(Icons.add),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              spacing: 4.0,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "My classes",
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                ),
                ...classes.map(
                  (lesson) => Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.vertical(
                        bottom:
                            classes[classes.length - 1] == lesson
                                ? Radius.circular(12.0)
                                : Radius.circular(4.0),
                        top:
                            classes[0] == lesson
                                ? Radius.circular(12.0)
                                : Radius.circular(4.0),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      spacing: 8.0,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            lesson["name"],
                            style: Theme.of(
                              context,
                            ).textTheme.labelMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          lesson["teacher"],
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
                            color:
                                Theme.of(
                                  context,
                                ).colorScheme.secondaryContainer,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete_outline),
                          onPressed: () {
                            setState(() {
                              classes.remove(lesson);
                            });
                          },
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ],
                    ),
                  ),
                ),
                if (classes.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Center(
                      child: Text(
                        "Add a class by entering the class code above!",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color:
                              Theme.of(
                                context,
                              ).colorScheme.onSecondaryContainer,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      Container(),
    ];

    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                spacing: 36.0,
                children: [
                  SizedBox(height: 100),
                  Text(
                    "Welcome!",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  SizedBox(height: 2),
                  Column(
                    children: [
                      FilledButton.tonalIcon(
                        label: Text(googleText),
                        icon: Image.asset(
                          "assets/google-logo.png",
                          height: 24.0,
                        ),
                        onPressed: _handleSignIn,
                        style: FilledButton.styleFrom(
                          backgroundColor:
                              Theme.of(
                                context,
                              ).colorScheme.surfaceContainerHigh,
                          foregroundColor:
                              Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        errorText,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            tab = 0;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border:
                                tab == 0
                                    ? Border.all(
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.primaryContainer,
                                    )
                                    : Border.all(
                                      color:
                                          Theme.of(context).colorScheme.outline,
                                    ),
                            color:
                                tab == 0
                                    ? Theme.of(
                                      context,
                                    ).colorScheme.primaryContainer
                                    : null,
                          ),
                          width:
                              (MediaQuery.of(context).size.width - 16 * 3) / 2,
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Column(
                            spacing: 10.0,
                            children: [
                              Icon(
                                Icons.person_outline,
                              ), // TODO: change to person_book
                              Text(
                                "Teacher",
                                style: Theme.of(
                                  context,
                                ).textTheme.titleSmall?.copyWith(
                                  color:
                                      Theme.of(
                                        context,
                                      ).colorScheme.onPrimaryContainer,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            tab = 1;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border:
                                tab == 1
                                    ? Border.all(
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.primaryContainer,
                                    )
                                    : Border.all(
                                      color:
                                          Theme.of(context).colorScheme.outline,
                                    ),
                            color:
                                tab == 1
                                    ? Theme.of(
                                      context,
                                    ).colorScheme.primaryContainer
                                    : null,
                          ),
                          width:
                              (MediaQuery.of(context).size.width - 16 * 3) / 2,
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Column(
                            spacing: 10.0,
                            children: [
                              Icon(Icons.school_outlined),
                              Text(
                                "Student",
                                style: Theme.of(
                                  context,
                                ).textTheme.titleSmall?.copyWith(
                                  color:
                                      Theme.of(
                                        context,
                                      ).colorScheme.onPrimaryContainer,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  tabs[tab],

                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      spacing: 10.0,
                      children: [
                        Icon(
                          Icons.lightbulb_outlined,
                          color:
                              Theme.of(context).colorScheme.onTertiaryContainer,
                        ),
                        Expanded(
                          child: Text(
                            "Hey!\nThis app is still under development, so expect some bugs. Let me know about anything wrong at github.com/erngusmik",
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(
                              color:
                                  Theme.of(
                                    context,
                                  ).colorScheme.onTertiaryContainer,
                            ),
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FilledButton(
                        onPressed: _handleSignUp,
                        style: FilledButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 24.0,
                          ),
                        ),
                        child: Text("Get started"),
                      ),
                    ],
                  ),
                  SizedBox(width: 1),
                ],
              ),
            ),
          ),
        ),

        // LOADING OVERLAY
        if (_isLoading)
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
