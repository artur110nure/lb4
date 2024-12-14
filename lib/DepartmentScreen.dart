import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kiuki21_9_fenchenko/models/departmentItem.dart';
import 'package:kiuki21_9_fenchenko/providers/studentsProvider.dart';

import 'models/department.dart';
import 'providers/departmentProvider.dart';

class DepartmentsScreen extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final departments = ref.watch(departmentsProvider);
    final students = ref.watch(studentsProvider);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        children: departments.map((dept) => DepartmentItem(
          id: dept.id,
          name: dept.name,
          color: dept.color,
          icon: dept.icon,
          studentsEnrolled: dept.studentsEnrolled,
        )).toList(),
      ),
    );
  }
}
