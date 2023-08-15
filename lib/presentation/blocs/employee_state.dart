import '../../data/models/employee.dart';

abstract class EmployeeState {}

class EmployeeInitial extends EmployeeState {}

class EmployeesLoaded extends EmployeeState {
  final List<Employee> employees;

  EmployeesLoaded(this.employees);
}

class EmployeeAdded extends EmployeeState {}

class EmployeeUpdated extends EmployeeState {}

class EmployeeArchived extends EmployeeState {}

class EmployeeError extends EmployeeState {
  final String errorMessage;

  EmployeeError(this.errorMessage);
}
