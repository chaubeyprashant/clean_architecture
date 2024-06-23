// lib/presentation/widgets/gpu_usage_widget.dart
import 'package:flutter/material.dart';

import '../../../domain/entities/system_resource.dart';

class GPUUsageWidget extends StatelessWidget {
  final List<GPUUsage> gpuUsage;

  const GPUUsageWidget({required this.gpuUsage, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: gpuUsage.length,
        itemBuilder: (context, index) {
          final gpu = gpuUsage[index];
          return ListTile(
            title: Text('GPU ${gpu.id}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${gpu.name}'),
                Text('Load: ${gpu.load}%'),
                Text('Memory Utilization: ${gpu.memoryUtil}%'),
              ],
            ),
          );
        },
      ),
    );
  }
}
