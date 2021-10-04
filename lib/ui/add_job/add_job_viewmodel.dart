import 'package:riddhi_sample/data/database_helper.dart';
import 'package:riddhi_sample/di.dart';
import 'package:riddhi_sample/domain/addjob.dart';
import 'package:riddhi_sample/domain/validation.dart';
import 'package:riddhi_sample/model/job.dart';

class AddJobViewModel {
  AddJobUsecase _addJobUsecase = AppManager.instance().addJobUsecase();
  ValidationUseCase _validationUseCase = AppManager.instance().validationUseCase();

  Job job;
  DateTime selectedDate = DateTime.now();
  DatabaseHelper helper = DatabaseHelper();

  void addJob(Job job, Function onSucces, Function onError) {
    _validationUseCase.validateJob(job, () async {
      int result = await helper.insertJob(job);

      if (result != 0) {
        print("saved");
        onSucces();
      } else {
        print("err");
        onError("Something went wrong");
      }
    }, (message) {
      onError(message);
    });
  }
}
