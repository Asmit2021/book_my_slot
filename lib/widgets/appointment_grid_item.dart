import 'package:book_my_slot/model/appointment.dart';
import 'package:flutter/material.dart';


class AppointmentGridItem extends StatelessWidget {
  const AppointmentGridItem({super.key,
  required this.appointment,
  required this.onSelectAppointment
  });

  final Appointment appointment;
  final void Function() onSelectAppointment;

  @override
  Widget build(BuildContext context) {
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
              departmentColor[appointment.department]!.withOpacity(0.55),
              departmentColor[appointment.department]!.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          appointment.name.toString(),
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
