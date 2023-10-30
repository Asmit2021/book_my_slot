import 'dart:convert';
import 'dart:developer';

import 'package:book_my_slot/model/appointment.dart';
import 'package:book_my_slot/model/user.dart';
import 'package:book_my_slot/providers/appointment_provider.dart';
import 'package:book_my_slot/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';

class AppointmentService {
  Future<void> getAppointments(
      {required User user,
      required WidgetRef ref,
      required BuildContext context}) async {
    http.Response res =
        await http.post(Uri.parse('${Constants.uri}/api/getAppointment'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: user.toJson());

    // ignore: use_build_context_synchronously
    httpErrorHandle(
        response: res,
        context: context,
        onSucess: () {
          Map<String, dynamic> jsonDataMap = json.decode(res.body);
          List<Appointment> appointments = [];
          for (var element in jsonDataMap['app']) {
            appointments.add(Appointment.fromMap(element));
          }
          //log(appointments[0].patientName);
          ref.watch(appointmentProvider.notifier).setAppointment(appointments);
        });
  }

  Future<void> setAppointment({
    required BuildContext context,
    required String description,
    required String date,
    required String speciality,
    required String email,
    required WidgetRef ref,
  }) async {
    http.Response res = await http.post(
      Uri.parse('${Constants.uri}/api/setAppointment'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        {
          'email': email,
          'description': description,
          'date': date,
          'speciality': speciality
        },
      ),
    );

  }
}
