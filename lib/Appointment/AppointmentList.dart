import 'package:flutter/material.dart';
import 'package:mis_lab3/models/Appointment.dart';
import 'package:mis_lab3/Appointment/AppointmentCard.dart';


class AppointmentList extends StatelessWidget {
  final List<Appointment> appointments;

  const AppointmentList({Key? key, required this.appointments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return AppointmentCard(appointments[index]);
        },
        itemCount: appointments.length,
      ),
    );
  }
}