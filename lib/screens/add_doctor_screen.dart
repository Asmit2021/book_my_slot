import 'dart:io';
import 'dart:math';

import 'package:book_my_slot/model/appointment.dart';
import 'package:book_my_slot/widgets/user_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:book_my_slot/model/doctor.dart';
import 'package:book_my_slot/services/auth_services.dart';
import 'package:book_my_slot/utils/color.dart';

class AddDoctorScreen extends StatefulWidget {
  const AddDoctorScreen({
    Key? key,
    required this.editing,
    this.doctor,
  }) : super(key: key);

  final bool editing;
  final Doctor? doctor;
  @override
  State<AddDoctorScreen> createState() => _AddDoctorScreenState();
}

class _AddDoctorScreenState extends State<AddDoctorScreen> {
  var _enteredEmail = '';
  var _enteredFirstName = '';
  var _enteredLastName = '';
  var _enteredPhone = '';
  var _enteredFees = '';
  var _selectedDepartment = Department.psychologist;
  File? _selectedImage;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController feesController = TextEditingController();
  final AuthService authService = AuthService();
  final _form = GlobalKey<FormState>();
  bool _isImage = true;

  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid ||
        lastNameController.text.trim().isEmpty ||
        firstNameController.text.trim().isEmpty ||
        feesController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text(
            'Invalid input',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          content: const Text(
            'Please make sure a valid name and email was entered.',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text(
                'Okay',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      );
      return;
    }

    _form.currentState!.save();
  }

  void getData() {
    if (widget.doctor == null) {
      return;
    }
    setState(() {
      _enteredFirstName = widget.doctor!.firstname;
      _enteredLastName = widget.doctor!.lastname;
      firstNameController.text = _enteredFirstName;
      lastNameController.text = _enteredLastName;
      _enteredEmail = widget.doctor!.email;
      emailController.text = _enteredEmail;
      _enteredPhone = widget.doctor!.phone;
      phoneController.text = _enteredPhone;
      _enteredFees = widget.doctor!.fees.toString();
      feesController.text = _enteredFees;
      _selectedDepartment = widget.doctor!.speciality;
    });
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    feesController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.editing) {
      getData();
    }

    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: MyColors.appBarColor,
        title: Text(widget.editing ? 'Edit Doctor' : 'Add Doctor'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (_isImage && widget.editing)
                InkWell(
                  onTap: () {
                    setState(() {
                      _isImage = false;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    margin: const EdgeInsets.only(
                      top: 20,
                      bottom: 20,
                      left: 20,
                      right: 20,
                    ),
                    height: 150,
                    width: 150,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.network(widget.doctor!.imageUrl, fit: BoxFit.cover,),
                  ),
                ),
              if(!_isImage || !widget.editing)  
              UserImagePicker(
                onPickImage: (pickedImage) {
                  _selectedImage = pickedImage;
                },
              ),
              Form(
                key: _form,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: firstNameController,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              labelText: 'First Name',
                            ),
                            keyboardType: TextInputType.name,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.words,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter a valid first name.';
                              }

                              return null;
                            },
                            onSaved: (value) {
                              _enteredFirstName = value!;
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: lastNameController,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              labelText: 'Last Name',
                            ),
                            keyboardType: TextInputType.name,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.words,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter a valid last name.';
                              }

                              return null;
                            },
                            onSaved: (value) {
                              _enteredLastName = value!;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        DropdownButton(
                          value: _selectedDepartment,
                          dropdownColor:
                              const Color.fromARGB(255, 255, 145, 180),
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
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: feesController,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              labelText: 'Fees',
                            ),
                            keyboardType: TextInputType.number,
                            autocorrect: false,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter a valid fees.';
                              }

                              return null;
                            },
                            onSaved: (value) {
                              _enteredFees = value!;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: emailController,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            !value.contains('@')) {
                          return 'Please enter a valid email address.';
                        }

                        return null;
                      },
                      onSaved: (value) {
                        _enteredEmail = value!;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: phoneController,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
                        labelText: 'Phone',
                      ),
                      keyboardType: TextInputType.number,
                      autocorrect: false,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a valid phone number.';
                        }

                        return null;
                      },
                      onSaved: (value) {
                        _enteredPhone = value!;
                      },
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                      ),
                      child: Text(widget.editing ? 'Update' : 'Submit'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
