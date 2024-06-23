// lib/presentation/widgets/cpu_usage_widget.dart
import 'package:flutter/material.dart';

class CPUUsageWidget extends StatelessWidget {
  final double cpuUsage;

  const CPUUsageWidget({required this.cpuUsage, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('CPU Usage: $cpuUsage%', style: const TextStyle(fontSize: 20));
  }
}
