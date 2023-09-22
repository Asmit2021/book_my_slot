import 'package:book_my_slot/model/appointment.dart';

class Doctor {
  const Doctor({
    required this.id,
    required this.name,
    required this.department,
    required this.imageUrl,
  });

  final String id;
  final String name;
  final Department department;
  final String imageUrl;
}
