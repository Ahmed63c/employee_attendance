import 'package:employeeattendance/Utils/AppProperties.dart';
import 'package:employeeattendance/View/AddEmployee.dart';
import 'package:employeeattendance/View/AdminHome.dart';
import 'package:employeeattendance/View/ChangePasswordView.dart';
import 'package:employeeattendance/View/DeleteEmployee.dart';
import 'package:employeeattendance/View/LoginView.dart';
import 'package:employeeattendance/View/SearchView.dart';
import 'package:employeeattendance/View/TimeConfigurationView.dart';
import 'package:employeeattendance/View/UpdateEmployee.dart';
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
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('اضف عامل',style: TextStyle(fontFamily: "Cairo",fontSize: 20,fontWeight: FontWeight.w500),),
            leading: Icon(Icons.add,color: Colors.green,),
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => AddEmployee())),
          ),
          ListTile(
              title: Text('احذف عامل'),
              leading: Icon(Icons.delete,color: Colors.red,),
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => DeleteEmployee())),
          ),
          ListTile(
              title: Text('تعديل بيانات عامل'),
              leading: Icon(Icons.edit,color: AppProperties.greylogo,),
              onTap: () => {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => UpdateEmployee())),
              }

          ),
          ListTile(
              title: Text('ابحث عن كود عامل'),
              leading: Icon(Icons.search,color: AppProperties.lightnavylogo,),
              onTap: () => {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => SearchPage())),
              }

          ),
          ListTile(
              title: Text('تعديل مواعيد العمل'),
              leading: Icon(Icons.edit_attributes,color: AppProperties.lightnavylogo,),
              onTap: () => {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => TimeConfiguration())),
              }

          ),
          ListTile(
              title: Text('تقرير يومي'),
              leading: Icon(Icons.report,color: Colors.blue,),
              onTap: ()  {
                _selectDate(context);
              }
          ),
          ListTile(
              title: Text('تغيير كلمة المرور'),
              leading: Icon(Icons.security,color: Colors.red,),
              onTap: () => {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => ChangePassword())),
              }),
          ListTile(
              title: Text('تسحيل الخروج'),
              leading: Icon(Icons.input,color: Colors.red,),
              onTap: () => {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => Login())),
              }),
        ],

      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
          {
            print(picked);
            print(picked.toString().split(" ")[0]);
            String date=picked.toString().split(" ")[0];
            Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => AdminHome(date)));


          }
  }
}