import 'package:flutter/material.dart';
import '../models/employee.dart';
import '../services/employee_service.dart';
import 'edit_employee_screen.dart';
import 'employee_list_screen.dart';

class EmployeeDetailScreen extends StatefulWidget {
  final Employee employee;

  EmployeeDetailScreen({required this.employee});

  @override
  _EmployeeDetailScreenState createState() => _EmployeeDetailScreenState();
}

class _EmployeeDetailScreenState extends State<EmployeeDetailScreen> {
  void navigateToEditScreen() async {
    final updatedEmployee = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditEmployeeScreen(employee: widget.employee)),
    );

    if (updatedEmployee != null) {
      setState(() {
        // Update the current employee object with the updated data
        widget.employee
          ..name = updatedEmployee.name
          ..email = updatedEmployee.email
          ..phoneNumber = updatedEmployee.phoneNumber
          ..address = updatedEmployee.address
          ..position = updatedEmployee.position
          ..department = updatedEmployee.department
          ..salary = updatedEmployee.salary;
      });
    }
  }

  Future<void> deleteEmployee(BuildContext context) async {
    try {
      await EmployeeService.deleteEmployee(widget.employee.id);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Employee deleted successfully'),
        backgroundColor: Colors.green,
      ));
      // Navigator.pop(context); // Return to previous screen after deletion
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return EmployeeListScreen();
      }));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to delete employee'),
        backgroundColor: Colors.red,
      ));
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Details', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit, color: Colors.white),
            onPressed: navigateToEditScreen,
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Delete Employee'),
                    content: Text(
                        'Are you sure you want to delete this employee?',
                        style: TextStyle(fontSize: 16)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.black12, width: 3.0),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Cancel',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Delete',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                        onPressed: () {
                          deleteEmployee(context);
                          // Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildDetailItem('Name', widget.employee.name),
            _buildDetailItem('Email', widget.employee.email),
            _buildDetailItem('Phone Number', widget.employee.phoneNumber),
            _buildDetailItem('Address', widget.employee.address),
            _buildDetailItem('Position', widget.employee.position),
            _buildDetailItem('Department', widget.employee.department),
            _buildDetailItem('Salary', widget.employee.salary),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 120.0,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
    );
  }
}
