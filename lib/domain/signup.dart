import 'package:riddhi_sample/data/entities.dart';
import 'package:riddhi_sample/data/repository.dart';
import 'package:riddhi_sample/domain/validation.dart';

class SignupUsecase {
  Repository _repository;

  SignupUsecase(Repository repository) {
    _repository = repository;
  }

  void signup(User user, Function onSuccess, Function onError) {
    _repository.signUpUser(user, onSuccess, onError);
  }
}
