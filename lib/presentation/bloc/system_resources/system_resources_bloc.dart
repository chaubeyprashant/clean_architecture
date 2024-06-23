// lib/presentation/bloc/system_resources/system_resources_bloc.dart
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:calsoft/domain/usecases/get_system_resources.dart';
import 'package:calsoft/presentation/bloc/system_resources/system_resources_event.dart';
import 'package:calsoft/presentation/bloc/system_resources/system_resources_state.dart';

class SystemResourcesBloc extends Bloc<SystemResourcesEvent, SystemResourcesState> {
  final GetSystemResources getSystemResources;
  Timer? _timer;

  SystemResourcesBloc({required this.getSystemResources}) : super(SystemResourcesInitial()) {
    on<FetchSystemResources>(_onFetchSystemResources);
    _startPeriodicFetch();
  }

  void _startPeriodicFetch() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      add(FetchSystemResources());
    });
  }

  void _onFetchSystemResources(FetchSystemResources event, Emitter<SystemResourcesState> emit) async {
    emit(SystemResourcesLoading());
    try {
      final systemResource = await getSystemResources.call();
      emit(SystemResourcesLoaded(systemResource: systemResource));
    } catch (error) {
      emit(SystemResourcesError(message: error.toString()));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
