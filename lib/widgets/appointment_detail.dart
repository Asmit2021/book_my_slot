import 'package:book_my_slot/model/appointment.dart';
import 'package:book_my_slot/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentDetail extends StatelessWidget {
  const AppointmentDetail({
    super.key,
    required this.appointment,
  });

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    var department =
        appointment.speciality.toString().split('.')[1].toUpperCase();
    var slot = appointment.slot.trim().isNotEmpty?(appointment.slot.split(',')[1]).split(':00 ')[0]:'XX:XX';
    var doctorName = appointment.doctorName.trim().isNotEmpty?appointment.doctorName:'To be assigned';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.appBarColor,
        title: const Text('Details'),
      ),
      backgroundColor: MyColors.backgroundColor,
      body: SizedBox(
        height: double.infinity,
        child: Card(
          color: Theme.of(context)
              .primaryColorLight, //const Color.fromARGB(247, 106, 227, 235),
          margin: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  DateFormat('dd-MM-yyyy')
                      .format(appointment.createdAt)
                      .toString(),
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors
                            .white, //const Color.fromARGB(255, 241, 232, 115),
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Divider(
                  color: Colors.white,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: appointment.status == 'waiting'
                            ? const Color.fromARGB(255, 245, 65, 56)
                            : const Color.fromARGB(
                                255, 141, 215, 250), //Colors.red,
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
                          appointment.status[0].toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
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
                            //change this
                            slot,
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
                  color: MyColors.drawerColor,
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
                                  .headlineSmall!
                                  .copyWith(color: Colors.black),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                        Text(
                          //change this
                          doctorName,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.black,
                              ),
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
                          appointment.concern,
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
