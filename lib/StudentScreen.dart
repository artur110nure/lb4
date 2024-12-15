import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kiuki21_9_fenchenko/models/department.dart';
import 'package:kiuki21_9_fenchenko/models/student.dart';
import 'package:kiuki21_9_fenchenko/providers/departmentProvider.dart';
import 'package:kiuki21_9_fenchenko/providers/studentsProvider.dart';

import 'widgets/new_student.dart';

class StudentsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final students = ref.watch(studentsProvider);
    final studentsNotifier = ref.watch(studentsProvider.notifier);

    void _showAddStudentModal() async {
      final newStudent = await showModalBottomSheet<Student>(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return NewStudent();
        },
      );

      if (newStudent != null) {
        ref.read(studentsProvider.notifier).addStudent(Student(
              firstName: newStudent.firstName,
              lastName: newStudent.lastName,
              department: newStudent.department,
              grade: newStudent.grade,
              gender: newStudent.gender,
            ));
      }
    }

    void _removeStudent(Student student) {
      ref.read(studentsProvider.notifier).removeStudent(student);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return Dismissible(
                  key: Key(student.firstName + student.lastName),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                      final studentToDelete = students[index];
                      final notifier = ref.read(studentsProvider.notifier);
                      notifier.removeStudentLocal(studentToDelete);
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(seconds: 3),
                          content: const Text('Student deleted'),
                          action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {
                                notifier.insertStudentLocal(studentToDelete, index);
                              }),
                        ),
                      ).closed.then((value) {
                        if (value != SnackBarClosedReason.action) {
                          notifier.removeStudent(studentToDelete);
                        }
                      });
                    },

                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    elevation: 4,
                    color: _getBackgroundColor(student.gender),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      title: Text(
                        '${student.firstName} ${student.lastName}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(student.department.icon, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            '${student.grade}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddStudentModal,
        child: const Icon(Icons.add),
      ),
    );
  }

  Color _getBackgroundColor(Gender gender) {
    switch (gender) {
      case Gender.male:
        return Colors.blue.shade100;
      case Gender.female:
        return Colors.pink.shade100;
    }
  }
}