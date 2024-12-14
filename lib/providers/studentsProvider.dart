import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/student.dart';
import 'departmentProvider.dart';

final studentsProvider =
    StateNotifierProvider<StudentsNotifier, List<Student>>((ref) {
      final departments = ref.read(departmentsProvider);
      List<Student> init = [
    Student(firstName: 'John', lastName: 'Smith', department: departments[0], gender: Gender.male, grade: 75),
    Student(firstName: 'Ana', lastName: 'De Armas', department: departments[1], gender: Gender.female, grade: 80),
    Student(firstName: 'Will', lastName: 'Smith', department: departments[3], gender: Gender.male, grade: 95),
    Student(firstName: 'Jack', lastName: 'Rassel', department: departments[2], gender: Gender.male, grade: 60),
    Student(firstName: 'Megan', lastName: 'Fox', department: departments[0], gender: Gender.female, grade: 80),
  ];

  init.forEach((s){
    departments.forEach((d){
      if(s.department.id == d.id){
        d.addStudent();
      }
    });
  });

  return StudentsNotifier(ref,init);
});

class StudentsNotifier extends StateNotifier<List<Student>> {
 final Ref ref;

  StudentsNotifier(this.ref, super.state);

 void addStudent(Student newStudent) {
    state = [...state, newStudent];
    ref.read(departmentsProvider.notifier).updateStudentCount(newStudent.department.id, 1);
  }

  void editStudent(Student student, int index) {
    final newState = [...state];
    newState[index] = Student(
      
      firstName: student.firstName,
      lastName: student.lastName,
      department: student.department,
      gender: student.gender,
      grade: student.grade,
    );
    state = newState;
  }

  void insertStudent(Student student, int index) {
    final newState = [...state];
    newState.insert(index, student);
    state = newState;
    ref.read(departmentsProvider.notifier).updateStudentCount(student.department.id, 1);
  }

  void removeStudent(Student student) {
    if(state.contains(student)){
      state = state.where((m) => m.id != student.id).toList();
      ref.read(departmentsProvider.notifier).updateStudentCount(student.department.id, -1);
    }
  }
}