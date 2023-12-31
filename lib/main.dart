import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repositories/employee_repository.dart';
import 'data/repositories/employee_repository_implementation.dart';
import 'data/utils/size_config.dart';
import 'presentation/blocs/employee_bloc.dart';
import 'presentation/blocs/employee_event.dart';
import 'presentation/screens/add_edit_screen.dart';
import 'presentation/screens/listing_screen.dart';

void main() {
  final EmployeeRepository employeeRepository =
      EmployeeRepositoryImplementation();
  final EmployeeBloc employeeBloc =
      EmployeeBloc(repository: employeeRepository);
  // Initialize the employee data
  employeeBloc.add(LoadEmployees());
  runApp(MultiBlocProvider(providers: [
    BlocProvider<EmployeeBloc>(
      create: (context) => employeeBloc,
    ),
  ], child: MyApp(employeeBloc: employeeBloc)));
}

class MyApp extends StatelessWidget {
  final EmployeeBloc employeeBloc;

  const MyApp({required this.employeeBloc});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
      title: 'RTI Sohel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider.value(
        value: employeeBloc,
        child: const EmployeeListingScreen(),
      ),
      routes: {
        '/addEdit': (context) => BlocProvider.value(
              value: employeeBloc,
              child: const AddEditScreen(),
            ),
      },
    );
  }
}
