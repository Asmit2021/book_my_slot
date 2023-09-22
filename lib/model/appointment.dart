import 'package:flutter/material.dart';

enum Department {
  gastroenterologist,
  cardiologist,
  oncologist,
  neurologist,
  gynecologist,
  pediatrician,
  dentist,
  plasticSurgeon,
  endocrinologist,
  psychologist,
}

final departmentColor = {
  Department.gastroenterologist: Colors.purple,
  Department.cardiologist: Colors.red,
  Department.oncologist: Colors.orange,
  Department.neurologist: Colors.amber,
  Department.gynecologist: Colors.blue,
  Department.pediatrician: Colors.green,
  Department.dentist: Colors.lightBlue,
  Department.plasticSurgeon: Colors.lightGreen,
  Department.endocrinologist: Colors.pink,
  Department.psychologist: Colors.teal,
};

class Appointment {
  const Appointment({
    required this.id,
    required this.name,
    required this.description,
    required this.time,
    required this.department,
  });

  final String id;
  final String name;
  final String description;
  final String time;
  final Department department;
}
