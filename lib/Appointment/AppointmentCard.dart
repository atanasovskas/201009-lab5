import 'package:flutter/material.dart';
import 'package:mis_lab3/models/Appointment.dart';
import 'package:url_launcher/url_launcher.dart';


class AppointmentCard extends StatelessWidget {
  final Appointment appointment;

  AppointmentCard(this.appointment);

  Future<void> _launchMaps(double latitude, double longitude) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not open maps';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(appointment.subject),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Time: ${appointment.date} ${appointment.time}'),
            Text('Location: ${appointment.location.location}'),
            TextButton(
              onPressed: () => _launchMaps(appointment.location.latitude, appointment.location.longitude),
              child: Text('Show in Maps'),
            ),
          ],
        ),
      ),
    );
  }
}
