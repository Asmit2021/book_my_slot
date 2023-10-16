import 'dart:convert';

import 'package:book_my_slot/screens/tabs.dart';
import 'package:book_my_slot/utils/constants.dart';
import 'package:book_my_slot/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:book_my_slot/model/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/user_provider.dart';

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      User user = User(
        name: name,
        email: email,
        phone: phone,
        location: '',
        gender: 'Male',
        role: 'user',
        password: password,
        token: '',
      );

      http.Response response = await http.post(
        Uri.parse(
            '${Constants.uri}/api/signup'), //change this to your local ip address
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: user.toJson(),
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: response,
        context: context,
        onSucess: () {
          showSnackBar(
              context, 'Account created! Login with the same credentials!');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required WidgetRef ref,
    required String email,
    required String password,
  }) async {
    try {
      final userHere = ref.watch(userProvider.notifier);
      final navigator = Navigator.of(context);

      http.Response res = await http.post(
        Uri.parse(
            '${Constants.uri}/api/signin'), //change this to your local ip address
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );
      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSucess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          userHere.setUser(res.body);
          final user = ref.watch(userProvider);
          await prefs.setString(Constants.token, user.token);
          await prefs.setString('email', user.email);
          navigator.pushAndRemoveUntil(
              MaterialPageRoute(builder: (contect) => const TabsScreen()),
              (route) => false);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getUserData({
    required BuildContext context,
    required WidgetRef ref,
    }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(Constants.token);
      if (token == null) {
        prefs.setString(Constants.token, '');
      }

      var tokenRes = await http.post(Uri.parse('${Constants.uri}/tokenIsValid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            Constants.token: token!,
            
          });

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http
            .get(Uri.parse('${Constants.uri}/'), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          Constants.token: token,
        });

        ref.watch(userProvider.notifier).setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getUser({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    try {
      final userHere = ref.watch(userProvider.notifier);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? email = prefs.getString('email');


      http.Response res = await http.post(
        Uri.parse(
            '${Constants.uri}/user'), //change this to your local ip address
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'email': email}),
      );
      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSucess: () {
          userHere.setUser(res.body);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
