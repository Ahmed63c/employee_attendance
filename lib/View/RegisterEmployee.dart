import 'package:employeeattendance/Utils/AppProperties.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterEmployee extends StatefulWidget{
  @override
  _RegisterEmployeeState createState() => _RegisterEmployeeState();
}

class _RegisterEmployeeState extends State<RegisterEmployee> {
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
          'سجل عامل',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 4,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 16,right: 16,top: 64),
            child: TextFormField(
              autofocus: false,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "كود العامل",
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
          ),
           DropdownButton<String>(
            items: <String>['حضور', 'انصراف'].map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: new Text(value),
              );
            }).toList(),
            onChanged: (_) {},
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 32.0,horizontal: 32),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              onPressed: () {
//            Navigator.push(
//              context,
//              MaterialPageRoute(builder: (context) => EmployeeView()),
//            );
              },
              padding: EdgeInsets.only(left: 32,right: 32,top: 12,bottom: 12),
              color:Colors.green,
              child: Text("سجل عامل", style: TextStyle(color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}