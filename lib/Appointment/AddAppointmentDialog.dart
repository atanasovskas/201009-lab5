import 'package:flutter/material.dart';
import 'package:mis_lab3/models/Appointment.dart';
import 'package:mis_lab3/models/Location.dart';
class AddAppointmentDialog extends StatefulWidget {
  final Function(Appointment) onAddAppointment;

  const AddAppointmentDialog({Key? key, required this.onAddAppointment}) : super(key: key);

  @override
  _AddAppointmentDialogState createState() => _AddAppointmentDialogState();
}

class _AddAppointmentDialogState extends State<AddAppointmentDialog> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  late Location selectedLocation;

  @override
  void initState() {
    super.initState();
    selectedLocation = getLocationForValue('FINKI');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Appointment'),
      content: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: timeController,
            decoration: const InputDecoration(labelText: 'Time'),
          ),
          TextField(
            controller: dateController,
            decoration: const InputDecoration(labelText: 'Date'),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text('Select Location: '),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: 'FINKI',
                  items: <String>['TMF', 'FEIT', 'FINKI']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  })
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedLocation = getLocationForValue(newValue!);
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final String name = nameController.text;
            final String time = timeController.text;
            final String date = dateController.text;

            if (name.isNotEmpty && time.isNotEmpty && date.isNotEmpty) {
              final Appointment newAppointment = Appointment(name, date, time, selectedLocation);

              widget.onAddAppointment(newAppointment);

              Navigator.of(context).pop();
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }

  Location getLocationForValue(String value) {
    switch (value) {
      case 'TMF':
        return Location(latitude: 42.004886882591045, longitude: 21.409809947779898, location: "TMF");
      case 'FEIT':
        return Location(latitude: 42.005054482832904, longitude: 21.40831232249575, location: "FEIT");
      default:
        return Location(latitude: 42.00408571228016, longitude: 21.409793139953756, location: "FINKI");
    }
  }
}