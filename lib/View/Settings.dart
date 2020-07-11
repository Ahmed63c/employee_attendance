import 'package:employeeattendance/Utils/AppProperties.dart';
import 'package:employeeattendance/View/AddEmployee.dart';
import 'package:employeeattendance/View/DeleteEmployee.dart';
import 'package:employeeattendance/View/SearchView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;


class Settings extends StatelessWidget{

  var now=DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Text(
          'الاعدادات',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 4,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 8,
          ),
          ListTile(
            title: Text('اضف عامل',style: TextStyle(fontFamily: "Cairo",fontSize: 20,fontWeight: FontWeight.w500),),
            leading: Icon(Icons.add,color: Colors.green,),
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => AddEmployee())),
          ),
          SizedBox(
            height: 8,
          ),
          ListTile(
              title: Text('احذف عامل'),
              leading: Icon(Icons.delete,color: Colors.red,),
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => DeleteEmployee())),
          ),
          SizedBox(
            height: 8,
          ),
          ListTile(
              title: Text('ابحث عن كود عامل'),
              leading: Icon(Icons.search,color: AppProperties.lightnavylogo,),
              onTap: () => {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => SearchPage())),
              }

          ),

          SizedBox(
            height: 8,
          ),
          ListTile(
              title: Text('تقرير'),
              leading: Icon(Icons.report,color: Colors.blue,),
              onTap: () async {
                final List<DateTime> picked = await DateRagePicker.showDatePicker(
                    context: context,
//                    initialFirstDate: new DateTime.now(),
//                    initialLastDate: (new DateTime.now()).add(new Duration(days: 7)),
//                    firstDate: new DateTime(2015),
//                    lastDate: new DateTime(2025)
                    firstDate: DateTime(DateTime.now().year,DateTime.now().month,0),
                    initialFirstDate: DateTime.now(),
                    initialLastDate: (new DateTime.now()).add(new Duration(days: 7)),
                    lastDate: DateTime.now().add(new Duration(days: 30))
                );
                if (picked != null) {
                  print(picked[0].toString().split(" ")[0]);
                }
              }
          ),


        ],

      ),
    );
  }

}