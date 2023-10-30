import 'dart:developer';

import 'package:book_my_slot/auth/login_screen.dart';
import 'package:book_my_slot/model/appointment.dart';
import 'package:book_my_slot/model/doctor.dart';
import 'package:book_my_slot/providers/appointment_provider.dart';
import 'package:book_my_slot/screens/add_doctor_screen.dart';
import 'package:book_my_slot/screens/doctor_screen.dart';
import 'package:book_my_slot/screens/profile_screen.dart';
import 'package:book_my_slot/services/appointment_service.dart';
import 'package:book_my_slot/utils/color.dart';
import 'package:book_my_slot/widgets/appointment_detail.dart';
import 'package:book_my_slot/widgets/appointment_grid_item.dart';
import 'package:book_my_slot/widgets/main_drawer.dart';
import 'package:book_my_slot/widgets/new_appointments.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/user_provider.dart';
import '../utils/constants.dart';

var doctors = [
  const Doctor(
    email: 'asmit2002@gmail.com',
    firstname: 'Asmit',
    lastname: 'Raj',
    speciality: Department.dentist,
    phone: '7258910888',
    present: true,
    inline: 0,
    fees: 700,
    imageUrl:
        'https://th.bing.com/th/id/OIP.6RcJ1Aw8BsyUTt4jjbYeMAAAAA?w=169&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
  ),
  const Doctor(
    email: 'tashu.namn@gmail.com',
    firstname: 'Naman',
    lastname: 'Mathur',
    speciality: Department.psychologist,
    phone: '9852677294',
    present: false,
    inline: 0,
    fees: 500,
    imageUrl:
        'https://th.bing.com/th/id/OIP.VE86YCGNvuR-se5r9JevCwHCHC?w=160&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
  ),
  const Doctor(
    email: 'harsh@gmail.com',
    firstname: 'Harsh',
    lastname: 'Sonkar',
    speciality: Department.psychologist,
    phone: '9852677294',
    present: false,
    inline: 0,
    fees: 500,
    imageUrl:
        'https://th.bing.com/th/id/OIP.jccpKWDR2AhPu-E1BjtEwAHaEK?w=313&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
  ),
  const Doctor(
    email: 'sagar@gmail.com',
    firstname: 'Sagar',
    lastname: 'Guney',
    speciality: Department.dentist,
    phone: '7258910888',
    present: true,
    inline: 0,
    fees: 700,
    imageUrl:
        'https://safartibbi.com/wp-content/uploads/2023/02/dr.vipul_.jpg',
  ),
  const Doctor(
    email: 'sumit@gmail.com',
    firstname: 'Sumit',
    lastname: 'Sarkar',
    speciality: Department.psychologist,
    phone: '9852677294',
    present: false,
    inline: 0,
    fees: 500,
    imageUrl:
        'https://th.bing.com/th/id/OIP.tV6YG37pRoKTcV5-KC8XYwHaKo?w=123&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
  ),
  const Doctor(
    email: 'emmmet@gmail.com',
    firstname: 'Dr.',
    lastname: 'Emmet',
    speciality: Department.dentist,
    phone: '7258910888',
    present: true,
    inline: 0,
    fees: 700,
    imageUrl:
        'https://th.bing.com/th/id/OIP.6RcJ1Aw8BsyUTt4jjbYeMAAAAA?w=169&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
  ),
];

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TableScreenState();
  }
}

class _TableScreenState extends ConsumerState<TabsScreen> {
  final AppointmentService appointmentService = AppointmentService();
  List<Appointment> appointments = [];

  void _openAddAppointmentOverlay() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (context) => NewAppointment(onAddExpense: addAppointment));
  }


  void addAppointment() {
    setState(() {});
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
    } else if (identifier == 'doctors') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => DoctorsScreen(doctors: doctors),
        ),
      );
    } else if (identifier == 'addDoctor') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => const AddDoctorScreen(editing: false),
      ));
    }
  }

  void logout() async {
    var navigator = Navigator.of(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Constants.token, '');
    navigator.pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => const LoginScreen(),
      ),
    );
  }

  void fetchAppointment(
    WidgetRef ref,
    BuildContext context,
  ) async {
    final user = ref.read(userProvider);
    await appointmentService.getAppointments(
        user: user, ref: ref, context: context);
    var temp = appointments.length;
    appointments = ref.watch(appointmentProvider);
    log( appointments.length.toString());
    if (temp < appointments.length) {
      setState(() {
        temp = appointments.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchAppointment(ref, context);
    final user = ref.read(userProvider);

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
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: MyColors.appBarColor,
        title: Text(activePageTitle),
        actions: [
          IconButton(
              onPressed: logout,
              icon: Icon(
                Icons.exit_to_app,
                color: Theme.of(context).colorScheme.primary,
              ))
        ],
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Center(
            child: Image.asset(
              'assets/images/Navicon1.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
        activePage,
      ]),
      floatingActionButton: user.role == 'user'
          ? FloatingActionButton(
              onPressed: _openAddAppointmentOverlay,
              backgroundColor: MyColors.appBarColor,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
