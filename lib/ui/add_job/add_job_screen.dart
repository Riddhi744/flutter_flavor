import 'package:intl/intl.dart';
import 'package:riddhi_sample/data/entities.dart';
import 'package:riddhi_sample/model/job.dart';
import 'package:riddhi_sample/ui/home/homescreen.dart';
import 'package:riddhi_sample/ui/register/registerviewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import '../base.dart';
import 'add_job_viewmodel.dart';

class AddJobScreen extends BasePage {
  AddJobScreen({String title: 'Register'}) : super(title);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

AddJobViewModel viewModel = AddJobViewModel();

enum JobOptions { NATIVE, HYBRID }

var selectedJobOption = JobOptions.NATIVE;

class _RegisterScreenState extends State<AddJobScreen> {
  var title = '';
  var desc = '';
  var experience = '';
  var date = '';
  var isMobile = false;

  Function showSuccessMessage({String message: 'Success'}) {
    Toast.show(message, context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  Function showErrorMessage(String message) {
    Toast.show(message, context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(widget.getTitle()),
        ),
        body: Container(
          child: Scaffold(
            body: Center(
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    titleInput((txt) {
                      title = txt;
                    }),
                    descInput((txt) {
                      desc = txt;
                    }),
                    passwordInput((txt) {
                      date = DateFormat.yMMMd().format(txt);
                    }),
                    typeInput((txt) {}),
                    jobOptions((JobOptions value) {
                      setState(() {
                        selectedJobOption = value;
                        isMobile = selectedJobOption == JobOptions.NATIVE;
                      });
                    }),
                    registerButton(() {
                      viewModel.addJob(
                          Job(
                            title,
                            desc,
                            date,
                          ), () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      }, (errMessage) {
                        showErrorMessage(errMessage);
                      });
                    }),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Column jobOptions(Function onChanged) {
    return Column(
      children: <Widget>[
        RadioListTile<JobOptions>(
          title: const Text('Register as a User'),
          value: JobOptions.NATIVE,
          groupValue: selectedJobOption,
          onChanged: onChanged,
        ),
        RadioListTile<JobOptions>(
          title: const Text('Register as a service viechle'),
          value: JobOptions.HYBRID,
          groupValue: selectedJobOption,
          onChanged: (JobOptions value) {
            setState(() {
              selectedJobOption = value;
            });
          },
        ),
      ],
    );
  }

  static final textStyle = TextStyle(
    fontFamily: 'Anton',
    fontSize: 20,
  );

  Widget titleInput(Function onChanged) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(hintText: 'Name'),
      keyboardType: TextInputType.text,
      style: textStyle,
    );
  }

  Widget descInput(Function onChanged) {
    return TextField(
        onChanged: onChanged,
        decoration: InputDecoration(hintText: 'Email'),
        keyboardType: TextInputType.emailAddress,
        style: textStyle);
  }

  Widget passwordInput(Function onChanged) {
    return InkResponse(
      onTap: () async {
        await selectDate();
      },
      child: Text("select date", style: textStyle),
    );
  }

  selectDate() async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: viewModel.selectedDate ?? DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != viewModel.selectedDate)
      setState(() {
        viewModel.selectedDate = picked;
        date = DateFormat.yMMMd().format(picked);
      });
  }

  Widget registerButton(Function pressed) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(30),
        child: FlatButton(
          onPressed: pressed,
          child: Text(
            'Register',
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.blue,
        ),
      ),
    );
  }

  typeInput(Null Function(int) param0) {
    return Container();
  }
}
