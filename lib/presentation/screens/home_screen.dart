import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:calsoft/presentation/bloc/system_resources/system_resources_bloc.dart';
import 'package:calsoft/presentation/bloc/system_resources/system_resources_event.dart';
import 'package:calsoft/presentation/bloc/system_resources/system_resources_state.dart';
import 'package:calsoft/presentation/screens/component/cpu_usage_widget.dart';
import 'package:calsoft/presentation/screens/component/gpu_usage_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('System Monitor'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<SystemResourcesBloc>().add(FetchSystemResources());
            },
          ),
        ],
      ),
      body: BlocListener<SystemResourcesBloc, SystemResourcesState>(
        listener: (context, state) {
          if (state is SystemResourcesError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<SystemResourcesBloc, SystemResourcesState>(
          builder: (context, state) {
            if (state is SystemResourcesInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SystemResourcesLoaded) {
              List<double> gpuUsageData = state.systemResource.gpuUsage.map((gpu) => gpu.load).toList();

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    CPUUsageWidget(cpuUsageData: state.systemResource.cpuUsageData),
                    const SizedBox(height: 20),
                    // const Text('GPU Usage:', style: TextStyle(fontSize: 20)),
                    GPUUsageWidget(gpuUsageData: gpuUsageData),
                  ],
                ),
              );
            } else if (state is SystemResourcesError) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
