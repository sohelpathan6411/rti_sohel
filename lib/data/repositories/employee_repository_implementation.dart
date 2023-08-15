import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/employee.dart';
import 'employee_repository.dart';

class EmployeeRepositoryImplementation implements EmployeeRepository {
  static const String _employeeListKey = 'employees_store';

  @override
  Future<List<Employee>> getAllEmployees() async {
    final prefs = await SharedPreferences.getInstance();
    final employeeListJson = prefs.getString(_employeeListKey);

    if (employeeListJson != null) {
      final List<dynamic> jsonList = jsonDecode(employeeListJson);
      final List<Employee> employees =
          jsonList.map((e) => Employee.fromJson(e)).toList();
      return employees;
    }

    return [];
  }

  @override
  Future<Employee?> getEmployeeById(int id) async {
    final employees = await getAllEmployees();
    return employees.firstWhere((employee) => employee.id == id);
  }

  @override
  Future<void> addEmployee(Employee employee) async {
    final prefs = await SharedPreferences.getInstance();
    final employees = await getAllEmployees();

    employees.add(employee);
    final updatedEmployeeList =
        jsonEncode(employees.map((e) => e.toJson()).toList());
    prefs.setString(_employeeListKey, updatedEmployeeList);
  }

  @override
  Future<void> updateEmployee(Employee employee) async {
    final prefs = await SharedPreferences.getInstance();
    final employees = await getAllEmployees();

    final index = employees.indexWhere((e) => e.id == employee.id);
    if (index >= 0) {
      employees[index] = employee;
      final updatedEmployeeList =
          jsonEncode(employees.map((e) => e.toJson()).toList());

      prefs.setString(_employeeListKey, updatedEmployeeList);
    }
  }

  @override
  Future<void> archiveEmployee(int id, int isArchived) async {
    final prefs = await SharedPreferences.getInstance();
    final employees = await getAllEmployees();

    final index = employees.indexWhere((e) => e.id == id);
    if (index >= 0) {
      employees[index].isArchived = isArchived;
      final updatedEmployeeList =
          jsonEncode(employees.map((e) => e.toJson()).toList());

      prefs.setString(_employeeListKey, updatedEmployeeList);
    }
  }
}
