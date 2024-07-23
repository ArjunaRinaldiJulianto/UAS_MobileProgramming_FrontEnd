import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/employee.dart';

class EmployeeService {
  // static const String baseUrl = 'http://10.0.2.2:8000/api/employees';
  static const String baseUrl = 'http://192.168.43.107:8000/api/employees';

  static Future<List<Employee>> getEmployees() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['data'];
      List<Employee> employees = data.map((json) => Employee.fromJson(json)).toList();
      return employees;
    } else {
      throw Exception('Failed to load employees');
    }
  }

  static Future<Employee> addEmployee(Employee employee) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      body: {
        'name': employee.name,
        'email': employee.email,
        'phoneNumber': employee.phoneNumber,
        'address': employee.address,
        'position': employee.position,
        'department': employee.department,
        'salary': employee.salary,
      },
    );

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body)['data'];
      return Employee.fromJson(data);
    } else {
      throw Exception('Failed to add employee');
    }
  }

  static Future<Employee> updateEmployee(Employee employee) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${employee.id}'),
      body: {
        'name': employee.name,
        'email': employee.email,
        'phoneNumber': employee.phoneNumber,
        'address': employee.address,
        'position': employee.position,
        'department': employee.department,
        'salary': employee.salary,
      },
    );

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body)['data'];
      return Employee.fromJson(data);
    } else {
      throw Exception('Failed to update employee');
    }
  }

  static Future<void> deleteEmployee(int id) async {
    await http.delete(Uri.parse('$baseUrl/$id'));
    // final response = await http.delete(Uri.parse('$baseUrl/$id'));

    // if (response.statusCode != 204) {
    //   throw Exception('Failed to delete employee');
    // }
  }
}
