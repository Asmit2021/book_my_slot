import 'package:book_my_slot/model/appointment.dart';
import 'package:book_my_slot/screens/tabs.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();

class NewAppointment extends StatefulWidget {
  const NewAppointment({super.key, required this.onAddExpense});

  final void Function(Appointment appointment) onAddExpense;

  @override
  State<StatefulWidget> createState() {
    return _NewAppointment();
  }
}

class _NewAppointment extends State<NewAppointment> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final time = TimeOfDay.fromDateTime(DateTime.now()).toString();
  DateTime? _selectedDate;
  final formatter = DateFormat.yMd();
  Department _selectedDepartment = Department.psychologist;
  var count = 2;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final lastDate = DateTime(now.year, now.month, now.day + 6);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: lastDate,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    if (_nameController.text.trim().isEmpty ||
        _descriptionController.text.trim().isEmpty ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
            'Please make sure a valid name, description , date and department was entered.',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );
      return;
    }
    count++;
    final formTime = time.substring(10, time.length - 1);
    final Appointment newAppointment = Appointment(
      id: (appointments.length+1).toString(),
      name: _nameController.text,
      description: _descriptionController.text,
      time: formTime,
      date: DateFormat('dd-MM-yyyy').format(_selectedDate!),
      department: Department.psychologist,
    );

    widget.onAddExpense(newAppointment);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    

    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxHeight;

      return SizedBox(
        height: width,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  controller: _nameController,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('Name'),
                  ),
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    label: Text('Description'),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'No date selected'
                          : DateFormat('dd-MM-yyyy').format(_selectedDate!),
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(
                        Icons.calendar_month,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                DropdownButton(
                  value: _selectedDepartment,
                  items: Department.values
                      .map(
                        (department) => DropdownMenuItem(
                          value: department,
                          child: Text(
                            department.name.toUpperCase(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedDepartment = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(fontSize: 20),
                        )),
                    ElevatedButton(
                      onPressed: _submitExpenseData,
                      child: const Text(
                        'Save Appointment',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
