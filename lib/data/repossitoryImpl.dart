import 'dart:collection';
import 'dart:developer';

import 'package:riddhi_sample/data/entities.dart';
import 'package:riddhi_sample/data/repository.dart';
import 'dart:io';

import 'package:riddhi_sample/model/job.dart';

class BancherRepository implements Repository {
  //in Memory DB,
  HashMap<String, User> _users = HashMap();
  User loggedinUser;

  @override
  bool contains(String email) {
    return _users[email] != null;
  }

  @override
  void signUpUser(User user, Function onSuccess, Function onError) {
    try {
      _users[user.getEmail().toLowerCase()] = user;
      loggedinUser = user;
      onSuccess(); //mocking success
    } catch (e) {
      //mocking error
      onError('Something went wrong!');
    }
  }

  @override
  bool isLoggedIn() {
    return loggedinUser != null;
  }

  @override
  bool isAuthorizeduser(String email, String pass) {
    return _users[email] != null && _users[email.toLowerCase()].getPassWord() == pass;
  }

  @override
  void logout() {
    loggedinUser = null;
  }

  @override
  loggedInUser() {
    return loggedinUser;
  }

  @override
  void login(String email, String pass, Function onsuccess, Function onError) {
    try {
      loggedinUser = _users[email];
      onsuccess();
    } catch (e) {
      onError('Something went wrong!');
    }
  }

  @override
  void addJob(Job job, Function onSuccess, Function onError) {
    try {
      onSuccess(); //mocking success
    } catch (e) {
      //mocking error
      onError('Something went wrong!');
    }
  }
}
