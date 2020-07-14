import 'package:employeeattendance/Utils/AppProperties.dart';
import 'package:employeeattendance/Utils/Constant.dart';
import 'package:employeeattendance/Utils/SharedPrefrence.dart';
import 'package:employeeattendance/View/EmployeeList.dart';
import 'package:employeeattendance/ViewModels/AdminViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class AdminHome extends StatefulWidget {
  String date=null;

  AdminHome(this.date);

  @override
  _AdminHomeState createState() => _AdminHomeState(this.date);
}

class _AdminHomeState extends State<AdminHome> {
    String date=null;
  _AdminHomeState(this.date);
  @override
  void initState() {
    super.initState();
    StorageUtil.getInstance().then((storage){
      Provider.of<AdminViewModel>(context, listen: false).getDailyReport(date,StorageUtil.getString(Constant.SHARED_USER_TOKEN));

    });
  }
  @override
  Widget build(BuildContext context) {

      return Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 32),
              child: Image.asset('assets/images/logo.jpg'),
              alignment: Alignment.center,
            ),
            Divider(
              height: 32,
              thickness: 1,
              endIndent: 16,
              indent: 16,
              color: AppProperties.navylogo,
            ),
            SizedBox(
              height: 16,
            ),
            Consumer<AdminViewModel>(builder: (context, model,child){
                 return switchWidget(context,model);
               }),
          ],
        ),
      );

  }

  Widget switchWidget(BuildContext context, AdminViewModel model) {
    switch (model.loadingStatus) {
      case LoadingStatus.searching:
        return  Visibility(
          visible: true,
          child: Center(child: CupertinoActivityIndicator()),
        );
      case LoadingStatus.error:
        return Visibility(
          visible: true,
          child:Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Text(model.error,
                style:
                TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: "Cairo",color: Colors.red),)),
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
                    percent: (int.parse(model.report.isNormalPercentage))/100,
                    center: Text(
                      model.report.isNormalPercentage+"%",
                      style:
                      new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    footer: InkWell(
                      child: Text(
                        " الحضور :  ${model.report.isNormalCount}",
                        style:
                        TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            fontFamily: "Cairo"),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EmployeeList(model.report.details)),
                        );
                      },
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: Colors.green,
                  ),
                  CircularPercentIndicator(
                    radius: 120.0,
                    lineWidth: 13.0,
                    animation: true,
                    percent: (int.parse(model.report.isAbsentPercentage))/100,
                    center: Text(
                      model.report.isAbsentPercentage+"%",
                      style:
                      new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    footer: InkWell(
                      child: Text(
                        "الغياب : ${model.report.isAbsentCount}",
                        style:
                        new TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            fontFamily: "Cairo"),
                      ),
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
                    percent: (int.parse(model.report.isLatePercentage))/100,
                    center: Text(
                      model.report.isLatePercentage+"%",
                      style:
                      new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    footer: InkWell(
                      child: Text(
                        "التأخير: ${model.report.isLateCount}",
                        style:
                        TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            fontFamily: "Cairo"),
                      ),
                      onTap: () {
                        print("tapped");
                      },
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: Colors.yellow,
                  ),
                  CircularPercentIndicator(
                    radius: 120.0,
                    lineWidth: 13.0,
                    animation: true,
                    percent: (int.parse(model.report.isEarlyLeftPercentage))/100,
                    center: Text(
                      model.report.isEarlyLeftPercentage+"%",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    footer: InkWell(
                      child: Text(
                        " الانصراف مبكرا : ${model.report.isEarlyLeftCount}",
                        style:
                        TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            fontFamily: "Cairo"),
                      ),
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
          child:Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Text(model.error,
                style:
                TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: "Cairo",color: Colors.red),)),
        );
    }
  }
}
