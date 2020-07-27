import 'package:employeeattendance/Utils/AppLocalization.dart';
import 'package:employeeattendance/Utils/AppProperties.dart';
import 'package:employeeattendance/Utils/Constant.dart';
import 'package:employeeattendance/Utils/SharedPrefrence.dart';
import 'package:employeeattendance/View/EmployeeList.dart';
import 'package:employeeattendance/View/EmployeeListMonth.dart';
import 'package:employeeattendance/ViewModels/AdminViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class AdminHome extends StatefulWidget {
  String date = null;
  String type = null;

  AdminHome(this.date, this.type);

  @override
  _AdminHomeState createState() => _AdminHomeState(this.date, this.type);
}

class _AdminHomeState extends State<AdminHome> {
  String date = null;
  String type = null;
  AdminViewModel vm;

  _AdminHomeState(this.date, this.type);

  @override
  void initState() {
    super.initState();
    StorageUtil.getInstance().then((storage) {
      if (type == "day") {
        Provider.of<AdminViewModel>(context, listen: false).getDailyReport(
            date, StorageUtil.getString(Constant.SHARED_USER_TOKEN));
      } else {
        Provider.of<AdminViewModel>(context, listen: false).getMonthlyReport(
            date, StorageUtil.getString(Constant.SHARED_USER_TOKEN));
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    vm=Provider.of<AdminViewModel>(context);
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 24),
            child: Image.asset('assets/images/logo.jpg'),
            alignment: Alignment.center,
          ),
          Divider(
            height: 16,
            thickness: 1,
            endIndent: 16,
            indent: 16,
            color: Colors.blue,
          ),
          Visibility(
            visible: type=="month",
            child: Container(
              child: FlatButton(
                child: Text(
                  "عرض التقرير الشهري",
                  style: TextStyle(
                      color: AppProperties.lightnavylogo,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      decoration: TextDecoration.underline),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (contex)=>
                              EmployeeListMonth(vm.monthModel.month, "  تقرير شهري عن شهر $date")
                      ));


                },
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Consumer<AdminViewModel>(builder: (context, model, child) {
            return switchWidget(context, model);
          }),
        ],
      ),
    );
  }




  Widget switchWidget(BuildContext context, AdminViewModel model) {
    switch (model.loadingStatus) {
      case LoadingStatus.searching:
        return Visibility(
          visible: true,
          child: Stack(children: <Widget>[
            Container(
              color: Colors.transparent,),
            Align(
                alignment: Alignment.center,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[ CupertinoActivityIndicator(radius: 16,),Text("تحميل...")])),

          ])
        );
      case LoadingStatus.error:
        return Visibility(
          visible: true,
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
        );
      case LoadingStatus.completed:
        return Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CircularPercentIndicator(
                  radius: 120.0,
                  lineWidth: 13.0,
                  animation: true,
                  percent: type == "day"
                      ? ((int.parse(model.report.isNormalPercentage)) / 100)
                      : ((int.parse(model.monthModel.isNormalPercentage)) /
                          100),
                  center: Text(
                    type == "day"
                        ? model.report.isNormalPercentage + "%"
                        : model.monthModel.isNormalPercentage + "%",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  footer: InkWell(
                    child: Text(
                      type == "day"
                          ? " الحضور :  ${model.report.isNormalCount}"
                          : " الحضور :  ${model.monthModel.isNormalCount}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          fontFamily: "Cairo"),
                    ),
                    onTap: () {
                      type=="day"?Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (contex)=>
                                EmployeeList(model.attendance,"بيانات الحضور")
                      )):{};
                    },
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Colors.green,
                ),
                CircularPercentIndicator(
                  radius: 120.0,
                  lineWidth: 13.0,
                  animation: true,
                  percent: type == "day"
                      ? ((int.parse(model.report.isAbsentPercentage)) / 100)
                      : ((int.parse(model.monthModel.isAbsentPercentage)) /
                          100),
                  center: Text(
                    type == "day"
                        ? model.report.isAbsentPercentage + "%"
                        : model.monthModel.isAbsentPercentage + "%",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  footer: InkWell(
                    child: Text(
                      type == "day"
                          ? "الغياب : ${model.report.isAbsentCount}"
                          : "الغياب : ${model.monthModel.isAbsentCount}",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          fontFamily: "Cairo"),
                    ),
                    onTap: () {
                      type=="day"?Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (contex)=>
                                  EmployeeList(model.absent,"بيانات الغياب")
                          )):{};
                    },
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Colors.red,
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CircularPercentIndicator(
                  radius: 120.0,
                  lineWidth: 13.0,
                  animation: true,
                  percent: type == "day"
                      ? ((int.parse(model.report.isLatePercentage)) / 100)
                      : ((int.parse(model.monthModel.isLatePercentage)) / 100),
                  center: Text(
                    type == "day"
                        ? model.report.isLatePercentage + "%"
                        : model.monthModel.isLatePercentage + "%",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  footer: InkWell(
                    child: Text(
                      type == "day"
                          ? "التأخير: ${model.report.isLateCount}"
                          : "التأخير: ${model.monthModel.isLateCount}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          fontFamily: "Cairo"),
                    ),
                    onTap: () {

                      type=="day"?
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                               EmployeeList(model.late, "بيانات التأخير")),
                      ):{};
                    },
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Colors.yellow,
                ),
                CircularPercentIndicator(
                  radius: 120.0,
                  lineWidth: 13.0,
                  animation: true,
                  percent: type == "day"
                      ? ((int.parse(model.report.isEarlyLeftPercentage)) / 100)
                      : ((int.parse(model.monthModel.isEarlyLeftPercentage)) /
                          100),
                  center: Text(
                    type == "day"
                        ? model.report.isEarlyLeftPercentage + "%"
                        : model.monthModel.isEarlyLeftPercentage + "%",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  footer: InkWell(
                    child: Text(
                      type == "day"
                          ? " الانصراف مبكرا : ${model.report.isEarlyLeftCount}"
                          : " الانصراف مبكرا : ${model.monthModel.isEarlyLeftCount}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          fontFamily: "Cairo"),
                    ),
                    onTap: () {
                      type=="day"?
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EmployeeList(
                                model.early, "بيانات الانصراف مبكرا")),
                      ):{};
                    },
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: AppProperties.lightnavylogo,
                ),
              ],
            )
          ],
        );
      case LoadingStatus.empty:
        return Visibility(
          visible: true,
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
        );
    }
  }
}
