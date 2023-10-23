import 'package:book_my_slot/model/appointment.dart';

class Doctor {
  const Doctor({
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.speciality,
    required this.phone,
    required this.present,
    required this.inline,
    required this.fees,
    required this.imageUrl,
  });

  final String email;
  final String firstname;
  final String lastname;
  final Department speciality;
  final String phone;
  final bool present;
  final int inline;
  final double fees;
  final String imageUrl;
}
