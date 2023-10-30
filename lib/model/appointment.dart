import 'dart:convert';

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
  genral,
}

Map<String,Department> setDep={
  'Gastroenterologist':Department.gastroenterologist,
  'Cardiologist':Department.cardiologist,
  'Oncologist':Department.oncologist,
  'Neurologist':Department.neurologist,
  'Gynecologist':Department.gynecologist,
  'Pediatrician':Department.pediatrician,
  'Dentist':Department.dentist,
  'PlasticSurgeon':Department.plasticSurgeon,
  'Endocrinologist':Department.endocrinologist,
  'Psychologist':Department.psychologist,
  'Genral':Department.genral,
};

final departmentColor = {
  Department.gastroenterologist: Colors.purple,
  Department.cardiologist: const Color.fromARGB(255, 81, 39, 39),
  Department.oncologist: Colors.orange,
  Department.neurologist: Colors.amber,
  Department.gynecologist: Colors.blue,
  Department.pediatrician: Colors.green,
  Department.dentist: Colors.lightBlue,
  Department.plasticSurgeon: Colors.lightGreen,
  Department.endocrinologist: Colors.pink,
  Department.psychologist: Colors.teal,
  Department.genral: Colors.grey,
};

class Appointment {
  const Appointment({
    required this.patientId,
    required this.patientName,
    required this.doctorId,
    required this.doctorName,
    required this.speciality,
    required this.concern,
    required this.slot,
    required this.phone,
    required this.status,
    required this.createdAt,
  });

  final String patientId;
  final String patientName;
  final String doctorId;
  final String doctorName;
  final Department speciality;
  final String concern;
  final String slot;
  final String phone;
  final String status;
  final DateTime createdAt;

  Map<String, dynamic> toMap() {
    return {
      'patientId': patientId,
      'patientName': patientName,
      'doctorId': doctorId,
      'doctorName': doctorName,
      'speciality': speciality.toString().split('.')[1],
      'concern': concern,
      'slot': slot,
      'phone': phone,
      'status': status,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      patientId: map['patientId'] ?? '',
      patientName: map['patientName'] ?? '',
      doctorId: map['doctorId'] ?? '',
      doctorName: map['doctorName'] ?? '',
      speciality: setDep[map['speciality'].toString()] ?? Department.genral,
      concern: map['concern'] ?? '',
      slot: map['slot'] ?? '',
      phone: map['phone'] ?? '',
      status: map['status'] ?? '',
      createdAt: DateTime.parse(map['createdAt'] ?? '') ,
    );
  }

  String toJson() => json.encode(toMap());

  factory Appointment.fromJson(String source) => Appointment.fromMap(json.decode(source));
}
