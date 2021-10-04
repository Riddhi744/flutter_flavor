import 'dart:async';

import 'package:get/get.dart';
import 'package:riddhi_sample/data/database_helper.dart';
import 'package:riddhi_sample/di.dart';
import 'package:riddhi_sample/domain/logout.dart';
import 'package:riddhi_sample/domain/userInfo.dart';
import 'package:riddhi_sample/model/job.dart';
import 'package:riddhi_sample/ui/add_job/add_job_screen.dart';
import 'package:riddhi_sample/utils/utils.dart';
import 'package:sqflite/sqflite.dart';

class HomeViewModel {
  LogoutUsecase _logoutUsecase = AppManager.instance().logoutUsecase();
  UserInfoUsecase _userInfoUsecase = AppManager.instance().userInfoUsecase();
  DatabaseHelper helper = DatabaseHelper();
  List<Job> arrJobs;
  int count = 0;

  StreamController<List<Job>> listStreamController = StreamController();

  void logout(Function then) {
    _logoutUsecase.logout(then);
  }

  void showUserInfo(Function info) {
    _userInfoUsecase.loadUserInfo(info);
  }

  getFirstLetter(String title) {
    return title.substring(0, 2);
  }

  void _delete(Job job) async {
    int result = await helper.deleteJob(job.id);
    if (result != 0) {
      _showSnackBar('Todo Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(String message) {
    AppUtils.showToast(message);
  }

  navigateToDetail(Job job, String title) async {
    bool result = await Get.to(AddJobScreen());

    if (result == true) {
      updateListView();
    }
  }

  updateListView() async {
    print("fetch data=====");
    final Future<Database> dbFuture = helper.initializeDatabase();
    await dbFuture.then((database) {
      Future<List<Job>> todoListFuture = helper.getJobList();
      todoListFuture.then((todoList) {
        print(todoList);
        this.arrJobs = todoList;
        this.count = todoList.length;
        listStreamController.add(todoList);
      });
    });
  }
}
