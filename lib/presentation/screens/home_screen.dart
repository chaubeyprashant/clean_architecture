import 'package:calsoft/presentation/screens/component/cpu_usage_widget.dart';
import 'package:calsoft/presentation/screens/component/gpu_usage_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:calsoft/presentation/bloc/system_resources/system_resources_bloc.dart';
import 'package:calsoft/presentation/bloc/system_resources/system_resources_event.dart';
import 'package:calsoft/presentation/bloc/system_resources/system_resources_state.dart';
import 'package:calsoft/utils/app_strings.dart';
import 'package:calsoft/utils/app_sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.systemMonitorTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: AppStrings.refreshButtonTooltip,
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
              SnackBar(
                  content: Text(state.message,
                      style: Theme.of(context).textTheme.bodySmall)),
            );
          }
        },
        child: BlocBuilder<SystemResourcesBloc, SystemResourcesState>(
          builder: (context, state) {
            if (state is SystemResourcesInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SystemResourcesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SystemResourcesLoaded) {
              return Padding(
                padding: const EdgeInsets.all(AppSizes.padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(AppStrings.cpuUsageTitle,
                            style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(width: AppSizes.padding),
                        Text("${state.systemResource.cpuUsage}%",
                            style: Theme.of(context).textTheme.titleMedium),
                      ],
                    ),
                    const SizedBox(height: AppSizes.padding),
                    CPUUsageWidget(
                        cpuUsageData: state.systemResource.cpuUsageData),
                    const SizedBox(height: AppSizes.padding),
                    Row(
                      children: [
                        Text(AppStrings.gpuUsageTitle,
                            style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(width: AppSizes.padding),
                        Text(
                            state.systemResource.gpuUsage.isNotEmpty
                                ? "${state.systemResource.gpuUsage}%"
                                : "0%",
                            style: Theme.of(context).textTheme.titleMedium),
                      ],
                    ),
                    const SizedBox(height: AppSizes.padding),
                    GPUUsageWidget(
                        gpuUsageData: state.systemResource.gpuUsage
                            .map((gpu) => gpu.load)
                            .toList())
                  ],
                ),
              );
            } else if (state is SystemResourcesError) {
              return Center(
                  child: Text(state.message,
                      style: Theme.of(context).textTheme.bodySmall));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
