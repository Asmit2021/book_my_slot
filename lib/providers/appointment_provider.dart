import 'package:book_my_slot/model/appointment.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppointmentNotifier extends StateNotifier<List<Appointment>> {
  AppointmentNotifier() : super([]);

  void setAppointment(List<Appointment> app) {
    state = app;
  }

  void addAppointment(String user) {
    state = [...state, Appointment.fromJson(user)];
  }

  void addUserFromModel(Appointment user) {
    state = [...state, user];
  }
}

final appointmentProvider =
    StateNotifierProvider<AppointmentNotifier, List<Appointment>>(
        (ref) => AppointmentNotifier());
