import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screens/all_tasks.dart';
import 'package:todo_app/screens/home_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({required this.onScreen, super.key});

  final String onScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text("MENU"),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          const SizedBox(height: 10),
          BuildTitleWidget(
            onScreen: onScreen,
            icon: Icons.home,
            name: "Home",
            onTap: () {
              if (onScreen == 'home') {
                Navigator.of(context).pop();
              } else {
                Navigator.of(context).pushReplacement(
                  CupertinoPageRoute(
                    builder: (_) => const Home(),
                  ),
                );
              }
            },
          ),
          const SizedBox(height: 10),
          BuildTitleWidget(
            onScreen: onScreen,
            icon: Icons.task_alt_rounded,
            name: "All tasks",
            onTap: () {
              if (onScreen == 'all-tasks') {
                Navigator.of(context).pop();
              } else {
                Navigator.of(context).pushReplacement(
                  CupertinoPageRoute(
                    builder: (_) => const AllTasks(),
                  ),
                );
              }
            },
          ),
          
        ],
      ),
    );
  }
}

class BuildTitleWidget extends StatelessWidget {
  const BuildTitleWidget({
    super.key,
    required this.onScreen,
    required this.icon,
    required this.name,
    required this.onTap,
  });

  final String onScreen;
  final IconData icon;
  final String name;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(name),
        onTap: onTap,
      ),
    );
  }
}
