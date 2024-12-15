import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kiuki21_9_fenchenko/controller/studentController.dart';
import 'package:kiuki21_9_fenchenko/models/department.dart';

import '../models/student.dart';
import 'departmentProvider.dart';

final studentsProvider =
    StateNotifierProvider<StudentsNotifier, List<Student>>((ref) {
      final studentsController = ref.read(studentControllerProvider);
      

  return StudentsNotifier(ref, studentsController);
});

final isLoadingProvider = StateProvider<bool>((ref) => false);

class StudentsNotifier extends StateNotifier<List<Student>> {
 final Ref ref;
 final StudentController studentConrtoller;

   StudentsNotifier(this.ref, this.studentConrtoller, [List<Student>? initialStudents])
      : super(initialStudents ?? []);

  Future<void> fetchStudents(List<Department> departments) async {
    try {
      setLoading(true);
      state = await ref.read(studentControllerProvider).getAllStudents();
      state.forEach((s){
            ref.read(departmentsProvider.notifier).updateStudentCount(s.department.id, 1);
          });
    } catch (e) {
    } finally {
      setLoading(false);
      state = [...state];
    }
  }

  void setLoading(bool loading) {
    ref.read(isLoadingProvider.notifier).state = loading;
  }

 void addStudent(Student newStudent) async {
  setLoading(true);
  await Future.delayed(const Duration(milliseconds: 1500));
    await studentConrtoller.addStudent(newStudent);
  setLoading(false);
    state = [...state, newStudent];
    ref.read(departmentsProvider.notifier).updateStudentCount(newStudent.department.id, 1);
  }

  void editStudent(Student student, int index) async{
    setLoading(true);
     await studentConrtoller.editStudent(student);
  setLoading(false);
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

  void removeStudent(Student student) async{
    setLoading(true);
  await Future.delayed(const Duration(milliseconds: 1500));
    await studentConrtoller.deleteStudent(student.id!);
  setLoading(false);
    removeStudentLocal(student);
  }

  void removeStudentLocal(Student student){
    if(state.contains(student)){
        if(state.contains(student)){
        state = state.where((m) => m.id != student.id).toList();
        ref.read(departmentsProvider.notifier).updateStudentCount(student.department.id, -1);
      }
    }
  }

  void insertStudentLocal(Student studentToDelete, int index) {
    final newState = [...state];
    newState.insert(index, studentToDelete);
    state = newState;
    ref.read(departmentsProvider.notifier).updateStudentCount(studentToDelete.department.id, 1);
  }
}