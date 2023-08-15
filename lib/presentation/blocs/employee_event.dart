import '../../data/models/employee.dart';

abstract class EmployeeEvent {}

class LoadEmployees extends EmployeeEvent {}

class AddEmployee extends EmployeeEvent {
  final Employee employee;

  AddEmployee(this.employee);
}

class UpdateEmployee extends EmployeeEvent {
  final Employee employee;

  UpdateEmployee(this.employee);
}

class ArchiveEmployee extends EmployeeEvent {
  final int employeeId;
  final int isArchived;
  ArchiveEmployee(this.employeeId, this.isArchived);
}
