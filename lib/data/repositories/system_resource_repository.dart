// lib/data/repositories/system_resource_repository_impl.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:calsoft/domain/repositories/system_resource_repository.dart';

import '../../domain/entities/system_resource.dart';

class SystemResourceRepositoryImpl implements SystemResourceRepository {
  final String apiUrl = 'http://localhost:5001/system_resources';

  @override
  Future<SystemResource> getSystemResources() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return SystemResource.fromJson(data);
    } else {
      throw Exception('Failed to load system resources');
    }
  }
}
