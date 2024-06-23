// lib/domain/repositories/system_resource_repository.dart

import '../entities/system_resource.dart';

abstract class SystemResourceRepository {
  Future<SystemResource> getSystemResources();
}
