import 'package:mis_lab3/Pages/AppointmentScreen.dart';
import 'package:mis_lab3/Pages/login.dart';
import 'auth.dart';
import 'package:flutter/material.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot)
      {
        if(snapshot.hasData)
          {
            return AppointmentScreen();
          }
        else
          {
            return LoginScreen();
          }
      },
    );
  }
}