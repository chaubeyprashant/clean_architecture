// lib/domain/usecases/get_system_resources.dart
import 'package:calsoft/domain/repositories/system_resource_repository.dart';

import '../entities/system_resource.dart';

class GetSystemResources {
  final SystemResourceRepository repository;

  GetSystemResources({required this.repository});

  Future<SystemResource> call() async {
    return await repository.getSystemResources();
  }
}
