import 'package:book_my_slot/model/appointment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class AppointmentGridItem extends StatelessWidget {
  const AppointmentGridItem({super.key,
  required this.appointment,
  required this.onSelectAppointment
  });

  final Appointment appointment;
  final void Function() onSelectAppointment;

  @override
  Widget build(BuildContext context) {
    var txt = appointment.slot.trim().isEmpty
        ? 'Waiting'
        : appointment.slot.split(',')[0];
    return InkWell(
      onTap: onSelectAppointment,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              appointment.status=='waiting'? Colors.red :departmentColor[appointment.speciality]!.withOpacity(0.55),
              appointment.status=='waiting'? Colors.red :departmentColor[appointment.speciality]!.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Text(
            txt,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
          ),
        ),
      ),
    );
  }
}
