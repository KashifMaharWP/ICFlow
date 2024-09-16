import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskflow_application/Routes/myroutes.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: const SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 120, 8, 0),
          foregroundColor: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.addProjectPage);
          },
          child: const Icon(CupertinoIcons.plus_circle)),
    );
  }
}
