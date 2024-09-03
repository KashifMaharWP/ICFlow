import 'package:taskflow_application/Classes/project.dart';

class ProjectMemberCatalog {
  static final List<ProjectAssignment> projectmembers = [
    ProjectAssignment(project_id: 1, memberName: 'Usman', role: 'Team Leader'),
    ProjectAssignment(project_id: 2, memberName: 'Ahsan', role: 'Team Member'),
    ProjectAssignment(project_id: 2, memberName: 'Kashif', role: 'Team Member'),
    ProjectAssignment(
        project_id: 2, memberName: 'Mudasir', role: 'Team Leader'),
    ProjectAssignment(
        project_id: 3, memberName: 'Mudasir', role: 'Team Member'),
  ];

  static List<ProjectAssignment> getProjectMembersById(int? projectId) {
    return projectmembers
        .where((member) => member.project_id == projectId)
        .toList();
  }
}

class ProjectAssignment {
  final int? project_id;
  final String? memberName;
  final String? role;

  ProjectAssignment({this.project_id, this.memberName, this.role});
}
