import 'package:flutter/material.dart';
import 'package:taskflow_application/Classes/Device_Info.dart';
import 'package:taskflow_application/Classes/project.dart';
import 'package:taskflow_application/Screens/Dashboards%20screens/view_team.dart';

class ProjectWidget extends StatelessWidget {
  final Project project;
  const ProjectWidget({super.key, required this.project});
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ViewProjectTeam(project: project)));
      },
      child: SizedBox(
        height: DeviceInfo.width / 3,
        child: Card(
          margin: const EdgeInsets.all(10),
          elevation: 5,
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor:
                  project.id! % 2 != 0 ? Colors.amber : Colors.green,
              child: Text(project.id.toString()),
            ),
            title: Text(project.title.toString()),
            subtitle: Text(project.description.toString()),
          ),
        ),
      ),
    );
  }
}
