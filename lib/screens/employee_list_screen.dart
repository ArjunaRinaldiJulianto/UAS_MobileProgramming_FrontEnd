import 'package:flutter/material.dart';
import '../models/employee.dart';
import '../services/employee_service.dart';
import 'employee_detail_screen.dart';
import 'add_employee_screen.dart';
import 'welcome_screen.dart';

class EmployeeListScreen extends StatefulWidget {
  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  List<Employee> employees = [];

  @override
  void initState() {
    super.initState();
    // Fetch employees when the screen initializes
    fetchEmployees();
  }

  Future<void> fetchEmployees() async {
    try {
      // Simulate fetching employees from a service
      List<Employee> fetchedEmployees = await EmployeeService.getEmployees();
      setState(() {
        employees = fetchedEmployees;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee List', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        automaticallyImplyLeading: false, // Hide back button
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Logout successful'),
                  backgroundColor: Colors.green,
                ),
              );
            },
          )
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: RefreshIndicator(
        onRefresh: fetchEmployees, // Pull-to-refresh functionality
        child: ListView.builder(
          itemCount: employees.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: ListTile(
                  leading: Icon(Icons.person_outline_outlined,
                      color: Colors.blueAccent),
                  title: Text(
                    employees[index].name,
                    style: TextStyle(fontSize: 18),
                  ),
                  subtitle: Text(
                    employees[index].email,
                    style: TextStyle(fontSize: 16),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.arrow_forward, color: Colors.blueAccent),
                    onPressed: () {
                      // Navigate to EmployeeDetailScreen on tap
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EmployeeDetailScreen(employee: employees[index]),
                        ),
                      ).then((_) =>
                          fetchEmployees()); // Refresh list after returning from detail screen
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to AddEmployeeScreen when FloatingActionButton is pressed
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEmployeeScreen(),
            ),
          ).then((_) =>
              fetchEmployees()); // Refresh list after returning from add employee screen
        },
        child: Icon(Icons.person_add_outlined, color: Colors.white),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
