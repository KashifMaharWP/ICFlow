import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:taskflow_application/Classes/project.dart';
import 'package:taskflow_application/Classes/project_member_model.dart';

class ViewProjectTeam extends StatefulWidget {
  final Project? project;
  const ViewProjectTeam({super.key, required this.project});

  @override
  State<ViewProjectTeam> createState() => _ViewProjectTeamState();
}

class _ViewProjectTeamState extends State<ViewProjectTeam> {
  late List<ProjectAssignment> listMembers = [];
  int cc = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listMembers =
        ProjectMemberCatalog.getProjectMembersById(widget.project!.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
          padding: const EdgeInsets.all(20),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12),
          physics: const BouncingScrollPhysics(),
          children: listMembers.map((member) => myBox(member)).toList()),
    );
  }

  Widget myBox(ProjectAssignment member) {
    setState(() {
      cc % 2 == 0 ? cc += 1 : cc += 1;
    });
    return Container(
      decoration: BoxDecoration(
          // color:
          //     member.project_id! % 2 == 0 ? Colors.orange : Colors.red.shade500,
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
              tileMode: TileMode.decal,
              colors: cc % 2 == 0
                  ? [Colors.red, Colors.red.shade700]
                  : [Colors.lightGreen, Colors.green]),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade500.withOpacity(.8),
                blurRadius: 10,
                spreadRadius: 1,
                offset: const Offset(4, 4))
          ]),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.project!.title.toString(),
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${member.memberName}",
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.amber),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                member.role.toString(),
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
