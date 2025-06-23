import 'package:flutter/material.dart';

class NoticePage extends StatelessWidget {
  const NoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            ),
            elevation: 0.0,
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.search_off)),
            ],
            centerTitle: true,
            title: Text('test'),
            titleTextStyle: Theme.of(context).textTheme.displaySmall,

            backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(children: [
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
