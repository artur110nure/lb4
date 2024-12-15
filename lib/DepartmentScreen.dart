import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kiuki21_9_fenchenko/models/departmentItem.dart';
import 'package:kiuki21_9_fenchenko/providers/studentsProvider.dart';
import 'package:kiuki21_9_fenchenko/widgets/loader.dart';

import 'models/department.dart';
import 'providers/departmentProvider.dart';

class DepartmentsScreen extends ConsumerStatefulWidget {
  @override
  _DepartmentsScreenState createState() => _DepartmentsScreenState();
}

class _DepartmentsScreenState extends ConsumerState<DepartmentsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(ref.read(studentsProvider).isEmpty){
        ref.read(studentsProvider.notifier).fetchStudents(ref.read(departmentsProvider));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final departments = ref.watch(departmentsProvider);
    final studentsNotifier = ref.watch(studentsProvider.notifier);
    return Scaffold(
      body:
          Padding(
              padding: const EdgeInsets.all(10),
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                children: departments
                    .map((dept) => DepartmentItem(
                          id: dept.id,
                          name: dept.name,
                          color: dept.color,
                          icon: dept.icon,
                          studentsEnrolled: dept.studentsEnrolled,
                        ))
                    .toList(),
              ),
            ),
    );
  }
}