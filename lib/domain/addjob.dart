import 'package:riddhi_sample/data/entities.dart';
import 'package:riddhi_sample/data/repository.dart';
import 'package:riddhi_sample/domain/validation.dart';
import 'package:riddhi_sample/model/job.dart';

class AddJobUsecase {
  Repository _repository;

  AddJobUsecase(Repository repository) {
    _repository = repository;
  }

  void addjob(Job job, Function onSuccess, Function onError) {
    _repository.addJob(job, onSuccess, onError);
  }
}
