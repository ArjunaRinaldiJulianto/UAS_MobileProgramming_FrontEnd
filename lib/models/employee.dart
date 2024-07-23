class Employee {
  int id;
  String name;
  String email;
  String phoneNumber;
  String address;
  String position;
  String department;
  String salary;

  Employee({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.position,
    required this.department,
    required this.salary,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      position: json['position'],
      department: json['department'],
      salary: json['salary'],
    );
  }
}
