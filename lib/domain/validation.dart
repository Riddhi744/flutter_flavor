import 'package:riddhi_sample/data/entities.dart';
import 'package:riddhi_sample/data/repository.dart';
import 'package:riddhi_sample/model/job.dart';

class ValidationUseCase {
  Repository _repository;

  ValidationUseCase(Repository repository) {
    _repository = repository;
  }

  void validateRegisteration(User user, String repeatedPass, Function onSuccess, Function onError) {
    if (user.getEmail().isNotEmpty && user.getPassWord().isNotEmpty && repeatedPass.isNotEmpty) {
      if (_repository.contains(user.getEmail())) {
        onError('This mail is already Signed up');
      } else if (user.getPassWord() != repeatedPass) {
        onError('Password fileds should match');
      } else {
        onSuccess();
      }
    } else {
      onError('Please complete your info');
    }
  }

  void validateJob(Job job, Function onSuccess, Function onError) {
    if (job.title.isNotEmpty && job.description.isNotEmpty && job.date.isNotEmpty) {
      onSuccess();
    } else {
      onError('Please complete your info');
    }
  }
}
