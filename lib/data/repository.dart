import 'package:riddhi_sample/data/entities.dart';
import 'package:riddhi_sample/model/job.dart';

class Repository {
  bool contains(String email) {}

  bool isLoggedIn() {}

  bool isAuthorizeduser(String email, String pass) {}

  void signUpUser(User user, Function onSuccess, Function onError) {}

  void logout() {}

  User loggedInUser() {}

  void login(String email, String pass, Function onSuccess, Function onError) {}

  void addJob(Job job, Function onSuccess, Function onError) {}
}
