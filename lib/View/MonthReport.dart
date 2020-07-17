//import 'package:flutter/material.dart';
//
//class MonthReport extends StatefulWidget{
//  @override
//  _MonthReportState createState() => _MonthReportState();
//}
//
//class _MonthReportState extends State<MonthReport> {
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(
//          iconTheme: IconThemeData(
//            color: Colors.black,
//          ),
//          actions: <Widget>[
//            IconButton(
//              icon: Icon(Icons.cloud_download),
//              color: Colors.black,
//              onPressed: () {
//               // download();
//              },
//            ),
//          ],
//          brightness: Brightness.light,
//          backgroundColor: Colors.white,
//          title: Text(
//            'العمال',
//            style: TextStyle(color: Colors.black),
//          ),
//          elevation: 4,
//        ),
//        body:Container(
//              width: MediaQuery.of(context).size.width,
//              margin: EdgeInsets.symmetric(horizontal: 16),
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                mainAxisSize: MainAxisSize.min,
//                children: <Widget>[
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    mainAxisSize: MainAxisSize.max,
//                    children: <Widget>[
//                      Container(
//                        margin: EdgeInsets.only(left: 8, right: 8, top: 8),
//                        child: Text(
//                          " تقرير عن شهر",
//                          style: TextStyle(
//                              fontWeight: FontWeight.w600,
//                              fontSize: 16,
//                              fontFamily: "Cairo"),
//                        ),
//                      ),
//                    ],
//                  ),
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    mainAxisSize: MainAxisSize.max,
//                    children: <Widget>[
//                      Container(
//                        margin: EdgeInsets.only(left: 8, right: 8, top: 8),
//                        child: Text(
//                          "اسم العامل :",
//                          style: TextStyle(
//                              fontWeight: FontWeight.w600,
//                              fontSize: 16,
//                              fontFamily: "Cairo"),
//                        ),
//                      ),
//                      Expanded(
//                        child: Container(
//                          margin: EdgeInsets.only(left: 4, right: 4, top: 8),
//                          child: Text(
//                            data[index].name,
//                            overflow: TextOverflow.ellipsis,
//                            style: TextStyle(
//                                fontWeight: FontWeight.w700,
//                                fontSize: 18,
//                                fontFamily: "Cairo"),
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
//                  SizedBox(
//                    height: 4,
//                  ),
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    mainAxisSize: MainAxisSize.max,
//                    children: <Widget>[
//                      Container(
//                        margin: EdgeInsets.only(left: 8, right: 8, top: 8),
//                        child: Text(
//                          "كود العامل :",
//                          style: TextStyle(
//                              fontWeight: FontWeight.w600,
//                              fontSize: 16,
//                              fontFamily: "Cairo"),
//                        ),
//                      ),
//                      Expanded(
//                        child: Container(
//                          margin: EdgeInsets.only(left: 4, right: 4, top: 8),
//                          child: Text(
//                            data[index].code,
//                            overflow: TextOverflow.ellipsis,
//                            style: TextStyle(
//                                fontWeight: FontWeight.w700,
//                                fontSize: 18,
//                                fontFamily: "Cairo"),
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
//                  SizedBox(
//                    height: 4,
//                  ),
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    mainAxisSize: MainAxisSize.max,
//                    children: <Widget>[
//                      Container(
//                        margin: EdgeInsets.only(left: 8, right: 8, top: 8),
//                        child: Text(
//                          "المرتب:",
//                          style: TextStyle(
//                              fontWeight: FontWeight.w600,
//                              fontSize: 16,
//                              fontFamily: "Cairo"),
//                        ),
//                      ),
//                      Expanded(
//                        child: Container(
//                          margin: EdgeInsets.only(left: 4, right: 4, top: 8),
//                          child: Text(
//                            data[index].salary,
//                            overflow: TextOverflow.ellipsis,
//                            style: TextStyle(
//                                fontWeight: FontWeight.w700,
//                                fontSize: 18,
//                                fontFamily: "Cairo"),
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
//                  SizedBox(
//                    height: 4,
//                  ),
//                  Visibility(
//                    visible: getVisibility(),
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      mainAxisSize: MainAxisSize.max,
//                      children: <Widget>[
//                        Container(
//                          margin: EdgeInsets.only(left: 8, right: 8, top: 8),
//                          child: Text(
//                            "الساعات الإضافيه:",
//                            style: TextStyle(
//                                fontWeight: FontWeight.w600,
//                                fontSize: 16,
//                                fontFamily: "Cairo"),
//                          ),
//                        ),
//                        Expanded(
//                          child: Container(
//                            margin: EdgeInsets.only(left: 4, right: 4, top: 8),
//                            child: Text(
//                              data[index].additionalHours == null
//                                  ? ""
//                                  : data[index].additionalHours,
//                              overflow: TextOverflow.ellipsis,
//                              style: TextStyle(
//                                  fontWeight: FontWeight.w700,
//                                  fontSize: 18,
//                                  fontFamily: "Cairo"),
//                            ),
//                          ),
//                        ),
//                      ],
//                    ),
//                  ),
//                  SizedBox(
//                    height: 4,
//                  ),
//                  Visibility(
//                    visible: getVisibility(),
//                    child: Row(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      mainAxisAlignment: MainAxisAlignment.start,
//                      children: <Widget>[
//                        CircleAvatar(
//                          child: GestureDetector(
//                            onTap: () async {
//                              await showDialog(
//                                  context: context,
//                                  builder: (_) =>
//                                      ImageDialog(data[index].attendingImg));
//                            },
//                          ),
//                          maxRadius: 32,
//                          backgroundImage: NetworkImage(data[index].attendingImg),
//                        ),
//                        Flexible(
//                          child: Column(
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            mainAxisAlignment: MainAxisAlignment.start,
//                            children: <Widget>[
//                              Row(
//                                mainAxisAlignment: MainAxisAlignment.start,
//                                children: <Widget>[
//                                  Container(
//                                      margin: EdgeInsets.only(
//                                          left: 16, right: 16, top: 4),
//                                      child: Text(
//                                        "دخول ",
//                                        style: TextStyle(
//                                            fontWeight: FontWeight.w700,
//                                            fontSize: 16,
//                                            fontFamily: "Cairo",
//                                            color: Colors.green),
//                                      )),
//                                  Container(
//                                      margin:
//                                      EdgeInsets.only(left: 8, right: 8, top: 4),
//                                      child: Text(
//                                        data[index].attendingTime,
//                                        style: TextStyle(
//                                            fontWeight: FontWeight.w500,
//                                            fontSize: 16,
//                                            fontFamily: "Cairo"),
//                                      )),
//                                ],
//                              ),
//                              Container(
//                                  margin:
//                                  EdgeInsets.only(left: 16, right: 16, top: 4),
//                                  child: Text(
//                                    data[index].attendingLocation,
//                                    overflow: TextOverflow.ellipsis,
//                                    style: TextStyle(
//                                        fontWeight: FontWeight.w500,
//                                        fontSize: 16,
//                                        fontFamily: "Cairo",
//                                        color: AppProperties.navylogo),
//                                  )),
//                            ],
//                          ),
//                        )
//                      ],
//                    ),
//                  ),
//                  SizedBox(
//                    height: 4,
//                  ),
//                  Visibility(
//                    visible: getVisibility(),
//                    child: Row(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      mainAxisAlignment: MainAxisAlignment.start,
//                      children: <Widget>[
//                        CircleAvatar(
//                          child: GestureDetector(
//                            onTap: () async {
//                              await showDialog(
//                                  context: context,
//                                  builder: (_) =>
//                                      ImageDialog(data[index].leavingImg));
//                            },
//                          ),
//                          maxRadius: 32,
//                          backgroundImage: NetworkImage(data[index].leavingImg == null
//                              ? ""
//                              : data[index].leavingImg),
//                        ),
//                        Flexible(
//                          child: Column(
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            mainAxisAlignment: MainAxisAlignment.start,
//                            children: <Widget>[
//                              Row(
//                                mainAxisAlignment: MainAxisAlignment.start,
//                                children: <Widget>[
//                                  Container(
//                                      margin: EdgeInsets.only(
//                                          left: 16, right: 16, top: 4),
//                                      child: Text(
//                                        "مغادرة ",
//                                        style: TextStyle(
//                                            fontWeight: FontWeight.w700,
//                                            fontSize: 16,
//                                            fontFamily: "Cairo",
//                                            color: Colors.red),
//                                      )),
//                                  Container(
//                                      margin:
//                                      EdgeInsets.only(left: 8, right: 8, top: 4),
//                                      child: Text(
//                                        data[index].leavingTime == null
//                                            ? ""
//                                            : data[index].leavingTime,
//                                        style: TextStyle(
//                                            fontWeight: FontWeight.w500,
//                                            fontSize: 16,
//                                            fontFamily: "Cairo"),
//                                      )),
//                                ],
//                              ),
//                              Container(
//                                  margin:
//                                  EdgeInsets.only(left: 16, right: 16, top: 4),
//                                  child: Text(
//                                    data[index].leavingLocation == null
//                                        ? ""
//                                        : data[index].leavingLocation,
//                                    overflow: TextOverflow.ellipsis,
//                                    style: TextStyle(
//                                        fontWeight: FontWeight.w500,
//                                        fontSize: 16,
//                                        fontFamily: "Cairo",
//                                        color: AppProperties.navylogo),
//                                  )),
//                            ],
//                          ),
//                        )
//                      ],
//                    ),
//                  ),
//                  SizedBox(
//                    height: 4,
//                  ),
//                ],
//              )
//          )
//    );
//  }
//
//  }
//}
