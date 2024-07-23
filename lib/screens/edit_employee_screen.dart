import 'package:flutter/material.dart';
import '../models/employee.dart';
import '../services/employee_service.dart';

class EditEmployeeScreen extends StatefulWidget {
  final Employee employee;

  EditEmployeeScreen({required this.employee});

  @override
  _EditEmployeeScreenState createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneNumberController;
  late TextEditingController addressController;
  late TextEditingController positionController;
  late TextEditingController departmentController;
  late TextEditingController salaryController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with current employee data
    nameController = TextEditingController(text: widget.employee.name);
    emailController = TextEditingController(text: widget.employee.email);
    phoneNumberController =
        TextEditingController(text: widget.employee.phoneNumber);
    addressController = TextEditingController(text: widget.employee.address);
    positionController = TextEditingController(text: widget.employee.position);
    departmentController =
        TextEditingController(text: widget.employee.department);
    salaryController = TextEditingController(text: widget.employee.salary);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Edit Employee', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blueAccent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
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
                onPressed: () => updateEmployee(context),
                child: Text('Update Employee',
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

  Future<void> updateEmployee(BuildContext context) async {
    try {
      // Create an updated Employee object
      Employee updatedEmployee = Employee(
        id: widget.employee.id,
        name: nameController.text,
        email: emailController.text,
        phoneNumber: phoneNumberController.text,
        address: addressController.text,
        position: positionController.text,
        department: departmentController.text,
        salary: salaryController.text,
      );

      // Call the service to update the employee
      Employee returnedEmployee =
          await EmployeeService.updateEmployee(updatedEmployee);

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Employee updated successfully'),
        backgroundColor: Colors.green,
      ));

      // Return updated employee to previous screen
      Navigator.pop(context, returnedEmployee);
    } catch (e) {
      // Show an error message if update fails
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to update employee'),
        backgroundColor: Colors.red,
      ));
      print('Error: $e');
    }
  }

  @override
  void dispose() {
    // Dispose controllers to free up resources
    nameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    positionController.dispose();
    departmentController.dispose();
    salaryController.dispose();
    super.dispose();
  }
}
