import 'package:employeeattendance/Utils/AppLocalization.dart';
import 'package:employeeattendance/Utils/AppProperties.dart';
import 'package:employeeattendance/View/AdminHome.dart';
import 'package:employeeattendance/View/Settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'SearchView.dart';

class AdminView extends  StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return  AdminViewState();
  }

}

class AdminViewState extends State<AdminView> {
  int  index=0;
  final List<Widget> _children = [
    AdminHome(null),
    Settings()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[index],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppProperties.navylogo,
        unselectedItemColor: Colors.grey,
        unselectedFontSize: 10,
        selectedFontSize: 10,
        currentIndex:index ,
        onTap: onTap,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
//                color: controller.index == 0 ? selectedColor : unselectedColor,
            ),
            title: Text(
              "الرئيسية",
            ),
          ),
          BottomNavigationBarItem(
              icon: new Icon(
                Icons.person_outline,
//                    color:  controller.index == 3 ? selectedColor : unselectedColor
              ),
              title: new Text(
                " الاعدادات",
//style: TextStyle(color: Colors.black45),
              ))
        ],
      ),
    );
  }


  void onTap(int value) {
    setState(() {
      index = value;
    });
  }

}



//      Container(
//        margin: EdgeInsets.only(left: 16, right: 16, top: 16),
//        decoration: BoxDecoration(
//            borderRadius: BorderRadius.circular(8),
//            border: Border.all(color: AppProperties.greylogo, width: 0.7)),
//        child: TextField(
//          readOnly: true,
//          decoration: InputDecoration(
//            border: InputBorder.none,
//            focusedBorder: InputBorder.none,
//            enabledBorder: InputBorder.none,
//            errorBorder: InputBorder.none,
//            disabledBorder: InputBorder.none,
//            contentPadding: EdgeInsets.only(top: 8.0),
//            fillColor: Colors.white,
//            hintText: AppLocalizations.of(context).translate("search"),
//            hintStyle: TextStyle(fontFamily: 'Cairo', fontSize: 14.0,color: AppProperties.navylogo),
//            prefixIcon: Icon(Icons.search, color: AppProperties.navylogo),
//          ),
//          onTap: () => Navigator.of(context)
//              .push(MaterialPageRoute(builder: (_) => SearchPage())),
//        ),
//      ),


