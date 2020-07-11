import 'package:employeeattendance/Utils/AppProperties.dart';
import 'package:employeeattendance/View/EmployeeData.dart';
import 'package:employeeattendance/Widget/ImageDialoge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmployeeList extends StatelessWidget{

  List<Employee> employees = [
    Employee(
      "محمد احمد ابراهيمم",
      'assets/images/profile.png',
      '8:00:00',
      '17:00:00',
    ),
    Employee(
      "أحمد عبد الستار علي",
      'assets/images/profile.png',
      '8:00:00',
      '17:00:00',
    ),
    Employee(
      "حسن احمد توفيق",
      'assets/images/profile.png',
      '8:00"00',
      '17:00"00',
    ),
    Employee(
      "محمد احمد ابراهيم",
      'assets/images/profile.png',
      '8:00:00',
      '17:00:00',
    ),
    Employee(
      "ابراهيم احمد عبد الله",
      'assets/images/profile.png',
      '8:00:00',
      '17:00:00',
    ),
    Employee(
      "محمد احمد عزت",
      'assets/images/profile.png',
      '8:00:00',
      '17:00:00',
    ),
    Employee(
      "محمد احمد ابراهيم",
      'assets/images/profile.png',
      '8:00:00',
      '17:00:00',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          title: Text(
            'العمال',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 4,
        ),

      body: Column(
        children: <Widget>[
          SizedBox(height: 16,),
          Flexible(
              child: ListView.separated(
                  itemCount: employees.length,
                  shrinkWrap: true,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                        height: 24,
                        indent: 16,
                        endIndent: 16,
                        color: AppProperties.lightnavylogo,
                        thickness: 0.5,
                      ),
                  itemBuilder: (_, index) =>
                   listViewItem(context,index)
              )
          ),

        ],
      )
    );

  }

  Widget listViewItem(BuildContext context,int index) {
   return
     Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 16),
        child:
        Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 8,right: 8,top: 8),
                      child: Text("اسم العامل :",style:
                      TextStyle(fontWeight: FontWeight.w600,fontSize: 16,fontFamily: "Cairo"),),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 4,right: 4,top: 8),
                        child: Text(employees[index].name,overflow: TextOverflow.ellipsis,
                          style:
                        TextStyle(fontWeight: FontWeight.w700,fontSize: 18,fontFamily: "Cairo"),),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 8,right: 8,top: 8),
                      child: Text("كود العامل :",style:
                      TextStyle(fontWeight: FontWeight.w600,fontSize: 16,fontFamily: "Cairo"),),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 4,right: 4,top: 8),
                        child: Text("1001",overflow: TextOverflow.ellipsis,
                          style:
                          TextStyle(fontWeight: FontWeight.w700,fontSize: 18,fontFamily: "Cairo"),),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 8,right: 8,top: 8),
                      child: Text("المرتب:",style:
                      TextStyle(fontWeight: FontWeight.w600,fontSize: 16,fontFamily: "Cairo"),),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 4,right: 4,top: 8),
                        child: Text("2000",overflow: TextOverflow.ellipsis,
                          style:
                          TextStyle(fontWeight: FontWeight.w700,fontSize: 18,fontFamily: "Cairo"),),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 8,right: 8,top: 8),
                      child: Text("الساعات الإضافيه:",style:
                      TextStyle(fontWeight: FontWeight.w600,fontSize: 16,fontFamily: "Cairo"),),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 4,right: 4,top: 8),
                        child: Text("16",overflow: TextOverflow.ellipsis,
                          style:
                          TextStyle(fontWeight: FontWeight.w700,fontSize: 18,fontFamily: "Cairo"),),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      child: GestureDetector(
                        onTap: () async {
                          await showDialog(
                              context: context,
                              builder: (_) => ImageDialog(employees[index].image)
                          );
                        },
                      ),
                      maxRadius: 32,
                      backgroundImage: AssetImage(employees[index].image),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(left: 16,right: 16,top: 4),
                                  child: Text("دخول ",style:
                                  TextStyle(fontWeight: FontWeight.w700,fontSize: 16,fontFamily: "Cairo",color: Colors.green),)),
                              Container(
                                  margin: EdgeInsets.only(left: 8,right: 8,top: 4),
                                  child: Text(employees[index].checkin,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,fontFamily: "Cairo"),)),
                            ],
                          ),
                      Container(
                                margin: EdgeInsets.only(left: 16,right: 16,top: 4),
                                child:
                                Text("العاصمه الاداريه الجديده بالحي التامن بجوا مسجد الفتاح العليم  ",
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                TextStyle(fontWeight: FontWeight.w500,fontSize: 16,fontFamily: "Cairo",color: AppProperties.navylogo),)),
                      ],),
                    )
                  ],
                ),
                SizedBox(height: 4,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      child: GestureDetector(
                        onTap: () async {
                          await showDialog(
                              context: context,
                              builder: (_) => ImageDialog(employees[index].image)
                          );
                        },
                      ),
                      maxRadius: 32,
                      backgroundImage: AssetImage(employees[index].image),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(left: 16,right: 16,top: 4),
                                  child: Text("مغادرة ",style:
                                  TextStyle(fontWeight: FontWeight.w700,fontSize: 16,fontFamily: "Cairo",color: Colors.red),)),
                              Container(
                                  margin: EdgeInsets.only(left: 8,right: 8,top: 4),
                                  child: Text(employees[index].checkout,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,fontFamily: "Cairo"),)),
                            ],
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 16,right: 16,top: 4),
                              child:
                              Text("العاصمه الاداريه الجديده بالحي التامن بجوا مسجد الفتاح العليم  ",
                                overflow: TextOverflow.ellipsis,
                                style:
                                TextStyle(fontWeight: FontWeight.w500,fontSize: 16,fontFamily: "Cairo",color: AppProperties.navylogo),)),
                        ],),
                    )
                  ],
                ),
              ],

        )


    );

}

}




//CircleAvatar(
//maxRadius: 32,
//backgroundImage: AssetImage(employees[index].image),
//),