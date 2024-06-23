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
}

class SystemResource {
  final double cpuUsage;
  final List<GPUUsage> gpuUsage;

  SystemResource({
    required this.cpuUsage,
    required this.gpuUsage,
  });

  factory SystemResource.fromJson(Map<String, dynamic> json) {
    return SystemResource(
      cpuUsage: json['cpu_usage'],
      gpuUsage: (json['gpu_usage'] as List)
          .map((gpuJson) => GPUUsage.fromJson(gpuJson))
          .toList(),
    );
  }
}
