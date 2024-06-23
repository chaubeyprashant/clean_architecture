// lib/domain/entities/system_resources.dart
class GPUUsage {
  final int id;
  final String name;
  final double load;
  final double memoryUtil;

  GPUUsage({
    required this.id,
    required this.name,
    required this.load,
    required this.memoryUtil,
  });

  factory GPUUsage.fromJson(Map<String, dynamic> json) {
    return GPUUsage(
      id: json['id'],
      name: json['name'],
      load: json['load'],
      memoryUtil: json['memoryUtil'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'load': load,
      'memoryUtil': memoryUtil,
    };
  }
}


class SystemResource {
  final double cpuUsage;
  final List<GPUUsage> gpuUsage;
  final List<double> cpuUsageData; // To store historical CPU usage data

  SystemResource({required this.cpuUsage, required this.gpuUsage, required this.cpuUsageData});

  factory SystemResource.fromJson(Map<String, dynamic> json) {
    var gpuList = json['gpu_usage'] as List? ?? [];
    List<GPUUsage> gpuUsageList = gpuList.map((i) => GPUUsage.fromJson(i)).toList();
    return SystemResource(
      cpuUsage: json['cpu_usage'],
      gpuUsage: gpuUsageList,
      cpuUsageData: [], // Initialize with empty list
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cpu_usage': cpuUsage,
      'gpu_usage': gpuUsage.map((gpu) => gpu.toJson()).toList(),
    };
  }

  SystemResource copyWith({double? cpuUsage, List<GPUUsage>? gpuUsage, List<double>? cpuUsageData}) {
    return SystemResource(
      cpuUsage: cpuUsage ?? this.cpuUsage,
      gpuUsage: gpuUsage ?? this.gpuUsage,
      cpuUsageData: cpuUsageData ?? this.cpuUsageData,
    );
  }
}
