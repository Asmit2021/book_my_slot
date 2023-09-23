import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//final _firebase = FirebaseAuth.instance;

class ProfileScreen extends StatefulWidget {
  static const routeName = '/login-screen';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var _enteredEmail = 'asmitraj@gmail.com';
  var _enteredName = 'Asmit Raj';
  var _imageUrl = "https://webstockreview.net/images/profile-icon-png.png";
  TextEditingController nameController =
      TextEditingController(text: "Asmit Raj");
  TextEditingController textController =
      TextEditingController(text: "asmitraj@gmail.com");
  final _form = GlobalKey<FormState>();

  @override
  void initState() {
    getData();
    super.initState();
  }

  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid ||
        nameController.text.trim().isEmpty ||
        textController.text.trim().isEmpty) {
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

    final authenticatedUser = FirebaseAuth.instance.currentUser!;

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(authenticatedUser.uid)
          .set({
        'name': _enteredName,
        'email': _enteredEmail,
        'image_url': _imageUrl,
      });
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        // ...
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Authentication failed.'),
        ),
      );
    }
  }

  void getData() async {
    final authenticatedUser = FirebaseAuth.instance.currentUser!;
    var userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(authenticatedUser.uid)
        .get();

    setState(() {
      _enteredName = userData['name'];
      nameController.text = _enteredName;
      _enteredEmail = userData['email'];
      textController.text = _enteredEmail;
      _imageUrl = userData['image_url'];
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                          color: Colors.white,
                        ),
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
                child: Image.network(_imageUrl),
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
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: nameController,
                            style: const TextStyle(
                                color: Colors.white,
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
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: textController,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
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
                          ElevatedButton(
                            onPressed: _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                            ),
                            child: const Text('Update'),
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
