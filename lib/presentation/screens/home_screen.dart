// lib/presentation/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:calsoft/presentation/bloc/system_resources/system_resources_bloc.dart';
import 'package:calsoft/presentation/bloc/system_resources/system_resources_event.dart';
import 'package:calsoft/presentation/bloc/system_resources/system_resources_state.dart';
import 'component/cpu_usage_widget.dart';
import 'component/gpu_usage_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
      body: BlocBuilder<SystemResourcesBloc, SystemResourcesState>(
        builder: (context, state) {
          if (state is SystemResourcesInitial) {
            return const Center(child: Text('Press the button to fetch data'));
          } else if (state is SystemResourcesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SystemResourcesLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CPUUsageWidget(cpuUsage: state.systemResource.cpuUsage),
                const SizedBox(height: 20),
                const Text('GPU Usage:', style: TextStyle(fontSize: 20)),
                GPUUsageWidget(gpuUsage: state.systemResource.gpuUsage),
              ],
            );
          } else if (state is SystemResourcesError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
