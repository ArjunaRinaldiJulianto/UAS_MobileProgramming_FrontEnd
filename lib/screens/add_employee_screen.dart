import 'package:flutter/material.dart';
import '../models/employee.dart';
import '../services/employee_service.dart';

class AddEmployeeScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();

  Future<void> addEmployee(BuildContext context) async {
    try {
      Employee newEmployee = Employee(
        id: 0, // Temporary placeholder ID
        name: nameController.text,
        email: emailController.text,
        phoneNumber: phoneNumberController.text,
        address: addressController.text,
        department: departmentController.text,
        position: positionController.text,
        salary: salaryController.text,
      );

      // Simulate adding employee to a service
      // Employee addedEmployee = await EmployeeService.addEmployee(newEmployee);
      await EmployeeService.addEmployee(newEmployee);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Employee added successfully'),
        backgroundColor: Colors.green,
      ));

      // Navigate back to previous screen
      Navigator.pop(context);
    } catch (e) {
      // Show error message if adding employee fails
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to add employee'),
        backgroundColor: Colors.red,
      ));
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employee', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildTextField(nameController, 'Name'),
              SizedBox(height: 12.0),
              _buildTextField(emailController, 'Email'),
              SizedBox(height: 12.0),
              _buildTextField(phoneNumberController, 'Phone Number'),
              SizedBox(height: 12.0),
              _buildTextField(addressController, 'Address'),
              SizedBox(height: 12.0),
              _buildTextField(positionController, 'Position'),
              SizedBox(height: 12.0),
              _buildTextField(departmentController, 'Department'),
              SizedBox(height: 12.0),
              _buildTextField(salaryController, 'Salary'),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () => addEmployee(context),
                child: Text('Add Employee',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    )),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
    );
  }
}
