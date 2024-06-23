// lib/presentation/bloc/system_resources/system_resources_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:calsoft/domain/usecases/get_system_resources.dart';
import 'package:calsoft/presentation/bloc/system_resources/system_resources_event.dart';
import 'package:calsoft/presentation/bloc/system_resources/system_resources_state.dart';
import 'dart:async';

class SystemResourcesBloc extends Bloc<SystemResourcesEvent, SystemResourcesState> {
  final GetSystemResources getSystemResources;
  List<double> cpuUsageHistory = []; // List to store historical CPU usage data
  Timer? _timer;

  SystemResourcesBloc({required this.getSystemResources}) : super(SystemResourcesInitial()) {
    on<FetchSystemResources>((event, emit) async {
      try {
        final systemResource = await getSystemResources();
        cpuUsageHistory.add(systemResource.cpuUsage); // Add current CPU usage to history
        emit(SystemResourcesLoaded(systemResource: systemResource.copyWith(cpuUsageData: cpuUsageHistory)));
      } catch (e) {
        emit(SystemResourcesError(message: e.toString()));
      }
    });

    _startFetching();
  }

  void _startFetching() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      add(FetchSystemResources());
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
