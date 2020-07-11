import 'package:employeeattendance/Utils/AppProperties.dart';
import 'package:employeeattendance/View/EmployeeList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AdminHome extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {

      return Column(
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
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CircularPercentIndicator(
                radius: 120.0,
                lineWidth: 13.0,
                animation: true,
                percent: 0.9,
                center:  Text(
                  "90.0%",
                  style:
                  new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                footer:  InkWell(
                  child: Text(
                    "عدد الحضور ١٠٢",
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0,fontFamily: "Cairo"),
                  ),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EmployeeList()),
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
                percent: 0.3,
                center:  Text(
                  "30.0%",
                  style:
                  new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                footer:  InkWell(
                  child: Text(
                    "الغياب ٣٥",
                    style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0,fontFamily: "Cairo"),
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
                percent: 0.1,
                center:  Text(
                  "10.0%",
                  style:
                  new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                footer:  InkWell(
                  child: Text(
                    "التأخير ٧",
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0,fontFamily: "Cairo"),
                  ),
                  onTap: (){
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
                percent: 0.01,
                center:  Text(
                  "1.0%",
                  style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                footer:  InkWell(
                  child: Text(
                    " الانصراف مبكرا ٤",
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0,fontFamily: "Cairo"),
                  ),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: AppProperties.lightnavylogo,
              ),
            ],
          )



        ],
      );

  }

}