import 'package:book_my_slot/model/appointment.dart';
import 'package:flutter/material.dart';


class AppointmentDetail extends StatelessWidget {
  const AppointmentDetail({
    super.key,
    required this.appointment,
  });

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(appointment.name),
      ),
      backgroundColor: Colors.black,
      body: SizedBox(
        height: double.infinity,
        child: Card(
          color: Colors.white,
          margin: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Id:- ${appointment.id} ',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  'Department:- ${appointment.department}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 6,
                ),
                  Text(
                    'Time Alloted:- ${appointment.time}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  appointment.description,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
