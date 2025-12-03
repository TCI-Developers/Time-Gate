import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_gate/providers/tabbar_provider.dart';
import 'package:time_gate/themes/app_theme.dart';

class CustomNavigatorbar extends StatelessWidget {
  const CustomNavigatorbar({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<TabbarProvider>(context);
    final currentIndex = uiProvider.selectedMEnuOption;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: AppTheme.secondary,
        borderRadius: BorderRadius.circular(40),
        
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _CustomNavButton(
            icon: Icons.home_filled,
            label: 'home',
            index: 0,
            selectedIndex: currentIndex,
            onTap: () => uiProvider.selectedMEnuOption = 0,
          ),
          _CustomNavButton(
            icon: Icons.assignment_add,
            label: 'Asistencia',
            index: 1,
            selectedIndex: currentIndex,
            onTap: () => uiProvider.selectedMEnuOption = 1,
          ),
          _CustomNavButton(
            icon: CupertinoIcons.list_bullet,
            label: 'Tarea',
            index: 2,
            selectedIndex: currentIndex,
            onTap: ()=>{},
          ),
          _CustomNavButton(
            icon: Icons.account_circle_outlined,
            label: 'Perfil',
            index: 3,
            selectedIndex: currentIndex,
            onTap: () => uiProvider.selectedMEnuOption = 3,
          ),
        ],
      ),
    );
  }
}

class _CustomNavButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final int selectedIndex;
  final VoidCallback onTap;

  const _CustomNavButton({
    required this.icon,
    required this.label,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = index == selectedIndex;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? AppTheme.white : AppTheme.primary,
            size: 28,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? AppTheme.white : AppTheme.primary,
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
