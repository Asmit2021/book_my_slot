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
    var department =
        appointment.department.toString().split('.')[1].toUpperCase();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      //backgroundColor: Colors.black,
      body: SizedBox(
        height: double.infinity,
        child: Card(
          color: const Color.fromARGB(247, 106, 227, 235),
          margin: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  appointment.date,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: const Color.fromARGB(255, 241, 232, 115),
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Divider(
                  color: Color.fromARGB(255, 241, 232, 115),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      margin: const EdgeInsets.only(
                        top: 20,
                        bottom: 20,
                        left: 20,
                        right: 20,
                      ),
                      height: 50,
                      width: 50,
                      child: Center(
                        child: Text(
                          appointment.id,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        // color: Colors.lightBlue,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      margin: const EdgeInsets.only(
                        top: 20,
                        bottom: 20,
                        left: 20,
                        right: 20,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            appointment.time,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Card(
                  color: Colors.white,
                  margin: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              department,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(color: Colors.black),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                        Text(
                          'Dr Sanjay Gagoi',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.black,),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Description:- ',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                  color: Colors.black,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.black),
                        ),
                        Text(
                          appointment.description,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
