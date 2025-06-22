import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool _isLoading = true;
  String name = '';
  String link = '';

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      name = prefs.getString('name')!;
      link = prefs.getString('picture')!;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Column(
                spacing: 24.0,
                children: [
                  CircleAvatar(backgroundImage: NetworkImage(link)),
                  Text(name, style: Theme.of(context).textTheme.titleLarge),
                  FilledButton.icon(
                    label: Text('Log out'),
                    icon: Icon(Icons.logout),
                    style: FilledButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.error,
                      foregroundColor: Theme.of(context).colorScheme.onError,
                    ),
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('loggedIn', false);
                      await FirebaseAuth.instance.signOut();
                      final googleSignIn = GoogleSignIn();
                      await googleSignIn.signOut();
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                  ),
                ],
              ),
            ),
            if (_isLoading)
              Positioned.fill(
                child: AbsorbPointer(
                  absorbing: true,
                  child: Stack(
                    children: [
                      const ModalBarrier(
                        dismissible: false,
                        color: Colors.black54,
                      ),
                      const Center(child: CircularProgressIndicator()),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
