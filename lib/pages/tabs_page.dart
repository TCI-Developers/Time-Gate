import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_gate/pages/attendance_page.dart';
import 'package:time_gate/pages/home_page.dart';
import 'package:time_gate/pages/profile_page.dart';
import 'package:time_gate/pages/todo_page.dart';
import 'package:time_gate/providers/tabbar_provider.dart';
import 'package:time_gate/widgets/custom_navigatorbar.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold( 
      
      body: Stack(
        children: [
          _HomeBody(), 
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomNavigatorbar(),
          ), 
        ],
      ),
    );
  }
}

class _HomeBody extends StatelessWidget {

  static final List<Widget> pages = [
    const HomePage(),
    AttendancePage(), 
    TodoPage(),        
    const ProfilePage(),
  ];

  const _HomeBody();

  @override
  Widget build(BuildContext context) {

    final currentIndex = Provider.of<TabbarProvider>(context).selectedMEnuOption;

    return IndexedStack(
      index: currentIndex, 
      children: pages,
    );
  }
}
