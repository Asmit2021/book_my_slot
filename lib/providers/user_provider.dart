import 'package:book_my_slot/model/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserNotifier extends StateNotifier<User> {
  UserNotifier():super(User(
    name: '',
    email: '',
    phone: '',
    location: '',
    gender: '',
    role: '',
    password: '',
    token: '',
  ));
  User _user = User(
    name: '',
    email: '',
    phone: '',
    location: '',
    gender: '',
    role: '',
    password: '',
    token: '',
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    state = _user;
  }

  void setUserFromModel(User user) {
    _user = user;
    state = _user;
  }
}

final userProvider = StateNotifierProvider<UserNotifier, User>((ref) => UserNotifier());
