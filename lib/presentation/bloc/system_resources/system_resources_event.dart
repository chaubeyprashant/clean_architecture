// lib/presentation/bloc/system_resources/system_resources_event.dart
import 'package:equatable/equatable.dart';

abstract class SystemResourcesEvent extends Equatable {
  const SystemResourcesEvent();

  @override
  List<Object> get props => [];
}

class FetchSystemResources extends SystemResourcesEvent {}
