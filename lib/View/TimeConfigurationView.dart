import 'package:employeeattendance/Models/Time.dart';
import 'package:employeeattendance/Utils/AppProperties.dart';
import 'package:employeeattendance/Utils/Constant.dart';
import 'package:employeeattendance/Utils/SharedPrefrence.dart';
import 'package:employeeattendance/ViewModels/TimeConfViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TimeConfiguration extends StatefulWidget {
  @override
  _Time createState() => _Time();
}

class _Time extends State<TimeConfiguration> {
  var formKey = GlobalKey<FormState>();
  TextEditingController startDayController = TextEditingController();
  TextEditingController endDayController = TextEditingController();
  TextEditingController startEXPController = TextEditingController();
  TextEditingController endEXPController = TextEditingController();

  @override
  void initState() {
    super.initState();
    StorageUtil.getInstance().then((storage) {
      String token = StorageUtil.getString(Constant.SHARED_USER_TOKEN);
      Provider.of<TimeConfViewModel>(context, listen: false)
          .getConfigurationSetting(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TimeConfViewModel>(builder: (context, model, child) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // empty state.
        if (model.loadingStatus == LoadingStatus.completed) {
          startDayController.text = model.startDay;
          endDayController.text = model.endDay;
          startEXPController.text = model.startExp;
          endEXPController.text = model.endExp;
          //then clear value
          model.loadingStatus = LoadingStatus.empty;
        }
      });
      return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            title: Text(
              ' تعديل مواعيد العمل',
              style: TextStyle(color: Colors.black),
            ),
            elevation: 4,
          ),
          body: Stack(
            children: <Widget>[
              ListView(
                children: <Widget>[
                  SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: TextFormField(
                      controller: startDayController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "بداية يوم عادي",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        icon: IconButton(
                          icon: Icon(Icons.alarm_add),
                          onPressed: () {
                            selectTime(context, startDayController, model);
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: TextFormField(
                      controller: endDayController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "نهاية يوم عادي",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        icon: IconButton(
                          icon: Icon(Icons.alarm_add),
                          onPressed: () {
                            selectTime(context, endDayController, model);
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: TextFormField(
                      readOnly: true,
                      controller: startEXPController,
                      decoration: InputDecoration(
                        labelText: " بداية يوم الخميس",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        icon: IconButton(
                          icon: Icon(Icons.alarm_add),
                          onPressed: () {
                            selectTime(context, startEXPController, model);
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: TextFormField(
                      controller: endEXPController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "  نهاية يوم الخميس",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        icon: IconButton(
                          icon: Icon(Icons.alarm_add),
                          onPressed: () {
                            selectTime(context, endEXPController, model);
                          },
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: model.loadingStatus == LoadingStatus.error,
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          model.error,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Cairo",
                              color: Colors.red),
                        )),
                  ),
                  Visibility(
                    visible: model.loadingStatus == LoadingStatus.completed,
                    child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        child: Center(
                          child: Text(
                            model.success,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Cairo",
                                color: Colors.green),
                          ),
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 50.0),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        onPressed: () {
                          print("button clicked");
                          StorageUtil.getInstance().then((storage) {
                            String token = StorageUtil.getString(
                                Constant.SHARED_USER_TOKEN);
                            Provider.of<TimeConfViewModel>(context,
                                    listen: false)
                                .doUpdateConfigurationSetting(
                                    token,
                                    startDayController.text,
                                    endDayController.text,
                                    startEXPController.text,
                                    endEXPController.text);
                          });
                        },
                        padding: EdgeInsets.only(
                            left: 32, right: 32, top: 12, bottom: 12),
                        color: AppProperties.navylogo,
                        child: Text(" تأكيد",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  )
                ],
              ),
              Visibility(
                  visible: LoadingStatus.searching == model.loadingStatus,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        color: Colors.black12,
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CupertinoActivityIndicator(
                                  radius: 16,
                                ),
                                Text("تحميل...")
                              ])),
                    ],
                  ))
            ],
          ));
    });
  }

  Future<Null> selectTime(buildContext, TextEditingController controller,
      TimeConfViewModel model) async {
      TimeOfDay now = TimeOfDay.now();
    TimeOfDay p = await showTimePicker(
        context: buildContext, initialTime: TimeOfDay(hour: 24, minute: 00));
    if (p != null && p != null) {
      print(p.hour < 10 ? "0${p.hour.toString()}" : p.hour.toString());
      print(p.minute < 10 ? "0${p.minute}" : p.minute.toString());
      String hour = p.hour < 10 ? "0${p.hour.toString()}" : p.hour.toString();
      String minutes = p.minute < 10 ? "0${p.minute}" : p.minute.toString();
      String time = "$hour" + ":" + "$minutes" + ":" + "00";
      controller.text = time;
      model.notifyListeners();
    }
  }
}
