// En un archivo llamado session_utils.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_gate/providers/attendance_provider.dart';
import 'package:time_gate/providers/home_provider.dart';
import 'package:time_gate/providers/profile_provider.dart';

void clearAllProviders(BuildContext context) {
  context.read<HomeProvider>().clear();
  context.read<AttendanceProvider>().clear();
  context.read<ProfileProvider>().clear();
}