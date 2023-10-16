import 'dart:io';

import 'package:book_my_slot/providers/user_provider.dart';
import 'package:book_my_slot/services/auth_services.dart';
import 'package:book_my_slot/utils/color.dart';
import 'package:book_my_slot/utils/utils.dart';
import 'package:book_my_slot/widgets/user_image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _firebase = FirebaseAuth.instance;

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = '/login-screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final phoneController = TextEditingController();
  final _form = GlobalKey<FormState>();
  File? _selectedImage;
  final AuthService authService = AuthService();

  var _isAuthenticating = false;
  var _isLogin = true;
  var _enteredEmail = '';
  var _enteredPassword = '';
  var _enteredName = '';
  var _enteredPhone = '';

  void _submit() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      // show error message ...
      return;
    }
    _form.currentState!.save();

    try {
      // setState(() {
      //   _isAuthenticating = true;
      // });
      if (_isLogin) {
        // final userCredentials = await _firebase.signInWithEmailAndPassword(
        //     email: _enteredEmail, password: _enteredPassword);
        authService.signInUser(
            context: context,
            ref: ref,
            email: _enteredEmail,
            password: _enteredPassword,);
      } else {
        authService.signUpUser(
          context: context,
          name: _enteredName,
          email: _enteredEmail,
          password: _enteredPassword,
          phone: _enteredPhone,
        );

        // final userCredentials = await _firebase.createUserWithEmailAndPassword(
        //     email: _enteredEmail, password: _enteredPassword);

        // final storageRef = FirebaseStorage.instance
        //     .ref()
        //     .child('user_images')
        //     .child('${_enteredEmail}.jpg');

        // await storageRef.putFile(_selectedImage!);
        //final imageUrl = await storageRef.getDownloadURL();

        // ignore: use_build_context_synchronously
        // await FirebaseFirestore.instance
        //     .collection('users')
        //     .doc(userCredentials.user!.uid)
        //     .set({
        //   'name': _enteredName,
        //   'email': _enteredEmail,
        //   'image_url': imageUrl,
        // });
      }
    } catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    }
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 135, 206, 235),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor:MyColors.appBarColor,
        title: const Text('Login/SignUp',),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // const Text(
              //   'You will need to Login or SignUp yourself.',
              //   style: TextStyle(
              //       fontSize: 17,
              //       fontWeight: FontWeight.bold),
              // ),
              const SizedBox(
                height: 15,
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 135, 206, 235),
                    shape: BoxShape.rectangle,

                    ),
                margin: const EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                height: 150,
                
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/images/Navicon1.png',
                  fit: BoxFit.fill,
                  
                  ),
                ),
                // Image.network(
                //     "https://www.milesweb.com/img-assets/client-logo/aiims.png"),
              ),
              const SizedBox(
                height: 15,
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _form,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!_isLogin)
                            UserImagePicker(
                              onPickImage: (pickedImage) {
                                _selectedImage = pickedImage;
                              },
                            ),
                          if (!_isLogin)
                            TextFormField(
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              decoration: const InputDecoration(
                                labelText: 'Name',
                              ),
                              keyboardType: TextInputType.name,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.words,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter a valid name.';
                                }

                                return null;
                              },
                              onSaved: (value) {
                                _enteredName = value!;
                              },
                            ),
                          TextFormField(
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                                labelText: 'Email Address'),
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
                          if (!_isLogin)
                            TextFormField(
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              decoration: const InputDecoration(
                                labelText: 'Phone Number',
                              ),
                              keyboardType: TextInputType.number,
                              autocorrect: false,
                              validator: (value) {
                                if (value == null || value.trim().length < 10) {
                                  return 'Please enter a valid phone number.';
                                }

                                return null;
                              },
                              onSaved: (value) {
                                _enteredPhone = value!;
                              },
                            ),
                          const SizedBox(height: 12),
                          TextFormField(
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            decoration:
                                const InputDecoration(labelText: 'Password'),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Password must be at least 6 characters long.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredPassword = value!;
                            },
                          ),
                          const SizedBox(height: 12),
                          if (_isAuthenticating)
                            const CircularProgressIndicator(),
                          if (!_isAuthenticating)
                            ElevatedButton(
                              onPressed: _submit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                              ),
                              child: Text(_isLogin ? 'Login' : 'Signup'),
                            ),
                          if (!_isAuthenticating)
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              },
                              child: Text(_isLogin
                                  ? 'Create an account'
                                  : 'I already have an account'),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
