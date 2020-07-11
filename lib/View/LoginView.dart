import 'package:employeeattendance/Utils/AppLocalization.dart';
import 'package:employeeattendance/Utils/AppProperties.dart';
import 'package:employeeattendance/View/AdminView.dart';
import 'package:employeeattendance/View/EmployeeView.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
static String tag = 'login-page';
@override
_LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset("assets/images/logo.jpg"),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context).translate("code"),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context).translate("pass"),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => EmployeeView()),
          );
        },
        padding: EdgeInsets.all(12),
        color:AppProperties.navylogo,
        child: Text(AppLocalizations.of(context).translate("sign"), style: TextStyle(color: Colors.white)),
      ),
    );

    final changePassword = FlatButton(
      child: Text(
        AppLocalizations.of(context).translate("changePassword"),
        style: TextStyle(color: AppProperties.lightnavylogo,
            fontWeight: FontWeight.w700,fontSize: 16,decoration: TextDecoration.underline),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminView()),
        );
        
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            // Text('happy birthday login),
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            changePassword
          ],
        ),
      ),
    );
  }
}