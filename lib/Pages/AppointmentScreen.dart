import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mis_lab3/auth.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mis_lab3/notifications.dart';
import 'package:mis_lab3/models/Appointment.dart';
import 'package:mis_lab3/Appointment/AppointmentCard.dart';
import 'package:mis_lab3/Appointment/AddAppointmentDialog.dart';


class AppointmentScreen extends StatefulWidget {
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  late final NotificationService notificationService;

  List<Appointment> appointments = [];
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;


  @override
  void initState() {
    notificationService = NotificationService();
    notificationService.initialize();
    super.initState();
  }

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _userId() {
    return Text(user?.email ?? 'User email');
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: signOut,
      child: const Text('Sign out'),
    );
  }

  void addAppointment(Appointment newAppointment) {
    setState(() {
      appointments.add(newAppointment);
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.notifications_active),
              onPressed: () async {
                await notificationService.showNotification(
                  id: 0,
                  title: 'Notifications',
                  body: 'Check your exams',
                  appointments: appointments,
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AddAppointmentDialog(onAddAppointment: addAppointment);
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: _userId(),
                ),
                _signOutButton(),
              ],
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40.0),
            child: SizedBox(),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: 16.0),
                  _selectedDay != null
                      ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Exams on ${DateFormat('yyyy-MM-dd').format(_selectedDay!)}:',
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      Column(
                        children: appointments
                            .where((appointment) =>
                        appointment.date == DateFormat('yyyy-MM-dd').format(_selectedDay!))
                            .map((appointment) => ListTile(
                          title: Text(appointment.subject),
                          subtitle: Text('${appointment.date} ${appointment.time}'),
                        ))
                            .toList(),
                      ),
                    ],
                  )
                      : SizedBox(),
                  SizedBox(height: 16.0),
                ],
              ),
            ),
            SliverGrid(
              delegate: SliverChildBuilderDelegate(
                    (context, index) => AppointmentCard(appointments[index]),
                childCount: appointments.length,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
            ),
            SliverToBoxAdapter(
              child: TableCalendar(
                calendarFormat: _calendarFormat,
                focusedDay: _focusedDay,
                firstDay: DateTime.now().subtract(Duration(days: 365)),
                lastDay: DateTime.now().add(Duration(days: 365)),
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.indigo,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
