import 'package:flutter/material.dart';

class DoctorItemTrait extends StatelessWidget {
const DoctorItemTrait({
    super.key,
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 17,
        ),
        Text(
          label,
          style: const TextStyle(
          ),
        )
      ],
    );
  }
}