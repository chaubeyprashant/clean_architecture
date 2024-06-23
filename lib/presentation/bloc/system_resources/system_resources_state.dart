// lib/presentation/bloc/system_resources/system_resources_state.dart
import 'package:equatable/equatable.dart';

import '../../../domain/entities/system_resource.dart';

abstract class SystemResourcesState extends Equatable {
  const SystemResourcesState();

  @override
  List<Object> get props => [];
}

class SystemResourcesInitial extends SystemResourcesState {}

class SystemResourcesLoading extends SystemResourcesState {}

class SystemResourcesLoaded extends SystemResourcesState {
  final SystemResource systemResource;

  const SystemResourcesLoaded({required this.systemResource});

  @override
  List<Object> get props => [systemResource];
}

class SystemResourcesError extends SystemResourcesState {
  final String message;

  const SystemResourcesError({required this.message});

  @override
  List<Object> get props => [message];
}
