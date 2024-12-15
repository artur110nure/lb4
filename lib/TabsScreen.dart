
import 'package:flutter/material.dart';
import 'package:kiuki21_9_fenchenko/widgets/loader.dart';

import 'DepartmentScreen.dart';
import 'StudentScreen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedTabIndex = 0;

  final List<Map<String, Object>> _pages = [
    {
      'page': DepartmentsScreen(),
      'title': 'Departments',
    },
    {
      'page': StudentsScreen(),
      'title': 'Students',
    },
  ];

  void _selectTab(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(_pages[_selectedTabIndex]['title'] as String),
    ),
    body: Stack(
      children: [
        _pages[_selectedTabIndex]['page'] as Widget,
        GlobalLoadingIndicator()
      ],
    ),
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: _selectedTabIndex,
      onTap: _selectTab,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Departments',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'Students',
        ),
      ],
    ),
  );
}
}