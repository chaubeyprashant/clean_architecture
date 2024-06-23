// lib/main.dart
import 'package:calsoft/presentation/bloc/system_resources/system_resources_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:calsoft/presentation/screens/home_screen.dart';
import 'package:calsoft/presentation/bloc/system_resources/system_resources_bloc.dart';
import 'package:calsoft/domain/usecases/get_system_resources.dart';
import 'package:calsoft/domain/repositories/system_resource_repository.dart';

import 'data/repositories/system_resource_repository.dart';

void main() {
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SystemResourceRepository>(
          create: (context) => SystemResourceRepositoryImpl(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SystemResourcesBloc(
        getSystemResources: GetSystemResources(
          repository: context.read<SystemResourceRepository>(),
        ),
      )..add(FetchSystemResources()),
      child: MaterialApp(
        title: 'System Monitor',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
