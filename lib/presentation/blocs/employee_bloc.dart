import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rti_sohel/data/models/employee.dart';

import '../../data/repositories/employee_repository.dart';
import 'employee_event.dart';
import 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final EmployeeRepository repository;

  EmployeeBloc({required this.repository}) : super(EmployeeInitial()) {}

  @override
  Stream<EmployeeState> mapEventToState(EmployeeEvent event) async* {
    if (event is LoadEmployees) {
      yield* _mapLoadEmployeesToState();
    } else if (event is AddEmployee) {
      yield* _mapAddEmployeeToState(event.employee);
    } else if (event is UpdateEmployee) {
      yield* _mapUpdateEmployeeToState(event.employee);
    } else if (event is ArchiveEmployee) {
      yield* _mapArchiveEmployeeToState(event.employeeId, event.isArchived);
    }
  }

  Stream<EmployeeState> _mapLoadEmployeesToState() async* {
    try {
      try {
        final employees = await repository.getAllEmployees();
        yield EmployeesLoaded(employees);
      } catch (e) {
        yield EmployeeError("Error loading employees");
      }
    } catch (e) {
      yield EmployeeError('Error loading employees');
    }
  }

  Stream<EmployeeState> _mapAddEmployeeToState(Employee employee) async* {
    await repository.addEmployee(employee);
    final employees = await repository.getAllEmployees();
    try {
      yield EmployeesLoaded(employees);
    } catch (e) {
      print(e);
      yield EmployeeError('Error adding employee');
    }
  }

  Stream<EmployeeState> _mapUpdateEmployeeToState(Employee employee) async* {
    try {
      await repository.updateEmployee(employee);
      final employees = await repository.getAllEmployees();
      yield EmployeesLoaded(employees);
    } catch (e) {
      yield EmployeeError('Error updating employee');
    }
  }

  Stream<EmployeeState> _mapArchiveEmployeeToState(
      int employeeId, int isArchived) async* {
    try {
      await repository.archiveEmployee(employeeId, isArchived);
      final employees = await repository.getAllEmployees();
      yield EmployeesLoaded(employees);
    } catch (e) {
      yield EmployeeError('Error archive employee');
    }
  }
}
