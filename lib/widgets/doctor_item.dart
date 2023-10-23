import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:book_my_slot/model/doctor.dart';
import 'package:book_my_slot/widgets/doctor_item_trait.dart';

class DoctorItem extends StatelessWidget {
  const DoctorItem({
    Key? key,
    required this.doctor,
    required this.onSelectDoctor,
  }) : super(key: key);

  final Doctor doctor;
  final void Function() onSelectDoctor;
  @override
  Widget build(
    BuildContext context,
  ) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16)
        ),
      ),
      color: Color.fromARGB(223, 253, 251, 239),
      elevation: 2,
      child: InkWell(
        onTap: onSelectDoctor,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: doctor.present ? Colors.green : Colors.red,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
              width: 100,
              height: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    height: 80,
                    width: 80,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: doctor.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${doctor.firstname} ${doctor.lastname}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  DoctorItemTrait(
                      icon: Icons.description_rounded,
                      label: doctor.speciality
                          .toString()
                          .split('.')[1]
                          .toUpperCase()),
                  DoctorItemTrait(icon: Icons.phone_android_rounded, label: doctor.phone.toString()),
                  DoctorItemTrait(icon: Icons.email_rounded, label: doctor.email),
                  const DoctorItemTrait(icon: Icons.time_to_leave_rounded, label: '11:00 AM - 2:00 PM'),
                  DoctorItemTrait(
                      icon: Icons.currency_rupee_outlined,
                      label: doctor.fees.toString())
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
