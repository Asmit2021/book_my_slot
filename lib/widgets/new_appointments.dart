import 'package:book_my_slot/model/appointment.dart';
import 'package:book_my_slot/screens/tabs.dart';
import 'package:book_my_slot/utils/color.dart';
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
    if ( _descriptionController.text.trim().isEmpty ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input',
          
          ),
          content: const Text(
            'Please make sure a valid name, description , date and department was entered.',
            
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay',
              style: TextStyle(
            ),
              ),
            )
          ],
        ),
      );
      return;
    }
    final formTime = time.substring(10, time.length - 1);
    final Appointment newAppointment = Appointment(
      id: (appointments.length+1).toString(),
      description: _descriptionController.text,
      time: formTime,
      date: DateFormat('dd-MM-yyyy').format(_selectedDate!),
      department: _selectedDepartment,
    );

    widget.onAddExpense(newAppointment);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    

    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxHeight;

      return Container(
        decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    width: 3,
                    color: Colors.black,
                  ),
                ),
        height: width,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  style: const TextStyle(
                      fontWeight: FontWeight.bold),
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
                      style: const TextStyle(fontSize: 20,),
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
                  dropdownColor: const Color.fromARGB(255, 255, 145, 180),
                  items: Department.values
                      .map(
                        (department) => DropdownMenuItem(
                          value: department,
                          child: Text(
                            department.name.toUpperCase(),
                            
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
                          style: TextStyle(color: Color.fromARGB(255, 255, 145, 180),fontSize: 20,),
                        )),
                    ElevatedButton(
                      onPressed: _submitExpenseData,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white
                      ),
                      child: const Text(
                        'Save Appointment',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 145, 180),
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
