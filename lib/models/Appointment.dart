import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'Location.dart';

class Appointment {
  final String subject;
  final String date;
  final String time;
  final Location location;

  Appointment(this.subject, this.date, this.time, this.location);
}