// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProjectCatalog {
  static final List<Project> projects = [
    Project(
        id: 1,
        title: 'Task Management',
        description:
            'Icreativez task management software for the nawabshah branch'),
    Project(
        id: 2,
        title: 'Attendance Management App',
        description:
            'Icreativez task management software for the nawabshah branch'),
    Project(
        id: 3,
        title: 'Video Editing of Icreativex',
        description:
            'Icreativez task management software for the nawabshah branch')
  ];
}

class Project {
  int? id;
  String? title;
  String? description;

  Project({
    this.id,
    this.title,
    this.description,
  });


  Project copyWith({
    int? id,
    String? title,
    String? description,
  }) {
    return Project(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Project.fromJson(String source) => Project.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Project(id: $id, title: $title, description: $description)';

  @override
  bool operator ==(covariant Project other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.description == description;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ description.hashCode;
}
