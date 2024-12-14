import 'package:flutter/material.dart';
import 'package:kiuki21_9_fenchenko/models/department.dart';

enum Gender {
  male,
  female
}

class Student {
  String? id;
  String firstName;
  String lastName;
  Department department;
  int grade;
  Gender gender;

   Student({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.department,
    required this.grade,
    required this.gender,
  }){
      if(this.id == null){
          this.id = DateTime.now().toString();
      }
  }

  @override
  String toString() {
    return 'Person(firstName: \$firstName, lastName: \$lastName, department: \$department, grade: \$grade, gender: \$gender)';
  }
}