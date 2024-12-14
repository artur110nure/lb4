import 'package:flutter/material.dart';

class DepartmentItem extends StatelessWidget {
  final String id;
  final String name;
  final Color color;
  final IconData icon;
  final int studentsEnrolled;

  DepartmentItem({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
    required this.studentsEnrolled,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color.withOpacity(0.2),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Text(
                  name.toUpperCase(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Positioned(
                top: 30,
                left: 0,
                child: Text(
                  'Students enrolled: $studentsEnrolled',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Icon(
                  icon,
                  size: 40,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}