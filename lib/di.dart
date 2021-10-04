import 'package:riddhi_sample/data/repository.dart';
import 'package:riddhi_sample/data/repossitoryImpl.dart';
import 'package:riddhi_sample/domain/addjob.dart';
import 'package:riddhi_sample/domain/login.dart';
import 'package:riddhi_sample/domain/logout.dart';
import 'package:riddhi_sample/domain/signup.dart';
import 'package:riddhi_sample/domain/userInfo.dart';
import 'package:riddhi_sample/domain/validation.dart';

class AppManager {
  static AppManager _instance;
  static Repository _repository = BancherRepository();

  AppManager._();

  static AppManager instance() {
    if (_instance == null) {
      _instance = AppManager._();
    }
    return _instance;
  }

  ValidationUseCase validationUseCase() {
    return ValidationUseCase(_repository);
  }

  SignupUsecase signupUsecase() {
    return SignupUsecase(_repository);
  }

  AddJobUsecase addJobUsecase() {
    return AddJobUsecase(_repository);
  }

  LoginUsecase loginUsecase() {
    return LoginUsecase(_repository);
  }

  LogoutUsecase logoutUsecase() {
    return LogoutUsecase(_repository);
  }

  bool isLoggedIn() {
    return _repository.isLoggedIn();
  }

  UserInfoUsecase userInfoUsecase() {
    return UserInfoUsecase(_repository);
  }
}
