import 'package:flutter/material.dart';

class Department {
  final String id;
  final String name;
  final Color color;
  final IconData icon;
  int studentsEnrolled;

  Department({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
    required this.studentsEnrolled,
  });

  void addStudent(){
    this.studentsEnrolled++;
  }

   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color.value,
      'icon': icon.codePoint, 
      'iconFontFamily': icon.fontFamily,
      'studentsEnrolled': studentsEnrolled,
    };
  }

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'],
      name: json['name'],
      color: Color(json['color']), // Преобразуем int обратно в Color
      icon: IconData(json['icon'], fontFamily: json['iconFontFamily']),
      studentsEnrolled: json['studentsEnrolled'],
    );
  }
}