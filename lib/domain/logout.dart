import 'package:riddhi_sample/data/repository.dart';

class LogoutUsecase {
  Repository _repository;
  LogoutUsecase(Repository repository) {
    _repository = repository;
  }

  void logout(Function then) {
    _repository.logout();
    then();
  }
}
