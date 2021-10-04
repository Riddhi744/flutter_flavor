import 'package:riddhi_sample/data/entities.dart';
import 'package:riddhi_sample/di.dart';
import 'package:riddhi_sample/domain/signup.dart';
import 'package:riddhi_sample/domain/validation.dart';

class RegisterViewModel {
  SignupUsecase _signupUsecase = AppManager.instance().signupUsecase();
  ValidationUseCase _validationUseCase = AppManager.instance().validationUseCase();

  void signup(User user, String repeatedPass, Function onSucces, Function onError) {
    _validationUseCase.validateRegisteration(user, repeatedPass, () {
      _signupUsecase.signup(user, () {
        onSucces();
      }, (message) {
        onError(message);
      });
    }, (message) {
      onError(message);
    });
  }
}
