
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kiuki21_9_fenchenko/models/student.dart';
import 'package:http/http.dart' as http;

final studentControllerProvider = Provider<StudentController>((ref) => StudentController());

class StudentController {
  final CollectionReference studentsCollection = FirebaseFirestore.instance.collection('students');

  Future<void> addStudent(Student student) async {
    try {
      await studentsCollection.doc(student.id).set(student.toJson());
      print("Student added successfully");
    } catch (e) {
      print("Error adding student: $e");
    }
  }

  Future<void> editStudent(Student student) async {
    final studentDoc = studentsCollection.doc(student.id);

    try {
      await studentDoc.update(student.toJson());
      print("Student updated successfully");
    } catch (e) {
      print("Error updating student: $e");
    }
  }

  Future<Student?> getStudent(String id) async {
    final studentDoc = studentsCollection.doc(id);

    try {
      final snapshot = await studentDoc.get();
      if (snapshot.exists) {
        return Student.fromJson(snapshot.data()! as  Map<String, dynamic>);
      }
    } catch (e) {
      print("Error fetching student: $e");
    }
    return null;
  }

  Future<List<Student>> getAllStudents() async {
    try {
      final snapshot = await studentsCollection.get();
      return snapshot.docs.map((doc) => Student.fromJson(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      print("Error fetching students: $e");
      return [];
    }
  }

  Future<void> deleteStudent(String id) async {
    final studentDoc = studentsCollection.doc(id);

    try {
      await studentDoc.delete();
      print("Student deleted successfully");
    } catch (e) {
      print("Error deleting student: $e");
    }
  }
}

