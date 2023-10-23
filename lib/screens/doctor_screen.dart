import 'package:book_my_slot/model/doctor.dart';
import 'package:book_my_slot/utils/color.dart';
import 'package:book_my_slot/widgets/doctor_item.dart';
import 'package:flutter/material.dart';


class DoctorsScreen extends StatelessWidget {
  const DoctorsScreen({
    super.key,
    this.title,
    required this.doctors,

  });

  final String? title;
  final List<Doctor> doctors;


  // void _selectMeal(BuildContext context, Doctor meal) {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: ((ctx) => MealDetail(meal: meal,)),
  //     ),
  //   ); //Navigator.push(context, route)
  // }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Uh oh ... nothing here!',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Colors.white//Theme.of(context).colorScheme.background,
                  ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Try selecting a different category!',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.white//Theme.of(context).colorScheme.background,
                  ),
            )
          ],
        ),
      );

    if (doctors.isNotEmpty) {
      content = ListView.builder(
      itemCount: doctors.length,
      itemBuilder: (ctx, index) => DoctorItem(doctor: doctors[index], onSelectDoctor: (){}),
    );
    }


    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: MyColors.appBarColor,
        title: const Text('Doctors'),
      ),
      body: content,
    );
  }
}