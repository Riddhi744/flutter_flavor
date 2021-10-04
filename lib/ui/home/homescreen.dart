import 'package:riddhi_sample/data/entities.dart';
import 'package:riddhi_sample/model/job.dart';
import 'package:riddhi_sample/ui/base.dart';
import 'package:riddhi_sample/ui/home/homeViewModel.dart';
import 'package:riddhi_sample/ui/login/loginscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

var viewModel = HomeViewModel();
String username = '';

class _HomeScreenState extends State<HomeScreen> {
  String appBarTitle;
  Job todo;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    viewModel.showUserInfo((User info) => {username = info?.getName()});
    super.initState();
    viewModel.updateListView();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Home'),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              debugPrint('FAB clicked');
              await viewModel.navigateToDetail(Job('', '', ''), 'Add Job');
              print("adjsajfs");
              await viewModel.updateListView();
              Future.delayed(Duration(milliseconds: 500), () {
                setState(() {});
              });
            },
            tooltip: 'Add Job',
            child: Icon(Icons.add),
          ),
          body: Center(
            child: Container(
              child: getJobListView(),
              // child: ListView(
              //   // crossAxisAlignment: CrossAxisAlignment.center,
              //   // mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     FlatButton(
              //       onPressed: () {
              //         viewModel.logout(() {
              //           Navigator.pushReplacement(
              //             context,
              //             MaterialPageRoute(builder: (context) => LoginScreen()),
              //           );
              //         });
              //       },
              //       color: Colors.redAccent,
              //       child: Text('logout'),
              //     ),
              //     getJobListView()
              //   ],
              // ),
            ),
          )),
    );
  }

  getJobListView() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: viewModel.arrJobs?.length ?? 0,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.amber,
              child: Text(viewModel.getFirstLetter(viewModel.arrJobs[position].title),
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            title: Text(viewModel.arrJobs[position].title, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(viewModel.arrJobs[position].description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onTap: () {
                    // _delete(context, todoList[position]);
                  },
                ),
              ],
            ),
            onTap: () {
              debugPrint("ListTile Tapped");
              // navigateToDetail(this.todoList[position], 'Edit Job');
            },
          ),
        );
      },
    );
  }
}
