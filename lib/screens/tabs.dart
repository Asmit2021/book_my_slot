import 'package:book_my_slot/model/appointment.dart';
import 'package:book_my_slot/screens/profile_screen.dart';
import 'package:book_my_slot/widgets/appointment_detail.dart';
import 'package:book_my_slot/widgets/appointment_grid_item.dart';
import 'package:book_my_slot/widgets/main_drawer.dart';
import 'package:book_my_slot/widgets/new_appointments.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

var appointments = [
    const Appointment(
      id: '1',
      time: "12:30",
      department: Department.cardiologist,
      date: '16/09/2023',
      description: 'Sick from fever',
    ),
    const Appointment(
      id: '2',
      time: "09:00",
      department: Department.dentist,
      date: '17/09/2023',
      description: 'Sick from cough',
    ),
  ];

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TableScreenState();
  }
}

class _TableScreenState extends State<TabsScreen> {
  

  void _openAddAppointmentOverlay() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (context) => NewAppointment(onAddExpense: addAppointment));
  }

  void addAppointment(Appointment appointment) {
    setState(() {
      appointments.add(appointment);
    });
  }


  void onSelectAppointment(Appointment appointment) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => AppointmentDetail(appointment: appointment),
      ),
    );
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'profile') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const ProfileScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        //avilableCategories.map((category) => CategoryGridItem(category: category)).toList()

        for (final appointment in appointments)
          AppointmentGridItem(
              appointment: appointment,
              onSelectAppointment: () {
                onSelectAppointment(appointment);
              }),
      ],
    );
    var activePageTitle = 'Appointments';

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: Icon(
                Icons.exit_to_app,
                color: Theme.of(context).colorScheme.primary,
              ))
        ],
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddAppointmentOverlay,
        backgroundColor: const Color.fromRGBO(0, 167, 131, 1),
        child: const Icon(Icons.add),
      ),
    );
  }
}
