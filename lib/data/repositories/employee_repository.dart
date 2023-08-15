// lib/data/repositories/employee_repository.dart

import '../models/employee.dart';

abstract class EmployeeRepository {
  Future<List<Employee>> getAllEmployees();
  Future<Employee?> getEmployeeById(int id);
  Future<void> addEmployee(Employee employee);
  Future<void> updateEmployee(Employee employee);
  Future<void> archiveEmployee(int id, int isArchived);
}
