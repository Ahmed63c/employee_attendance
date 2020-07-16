
import 'package:employeeattendance/View/ChangePasswordView.dart';
import 'package:employeeattendance/View/EmployeeView.dart';
import 'package:employeeattendance/View/RegisterEmployee.dart';
import 'package:employeeattendance/ViewModels/AddEmployeeViewModel.dart';
import 'package:employeeattendance/ViewModels/AdminViewModel.dart';
import 'package:employeeattendance/ViewModels/ChangePasswordViewModel.dart';
import 'package:employeeattendance/ViewModels/DeleteEmployeeViewModel.dart';
import 'package:employeeattendance/ViewModels/EmployeeViewModel.dart';
import 'package:employeeattendance/ViewModels/LoginViewModel.dart';
import 'package:employeeattendance/ViewModels/RegisterEmployeeViewModel.dart';
import 'package:employeeattendance/ViewModels/TimeConfViewModel.dart';
import 'package:employeeattendance/ViewModels/UpdateEmployeeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'Utils/AppLocalization.dart';
import 'View/LoginView.dart';
import 'ViewModels/SearchViewModel.dart';

void main() {
  runApp( MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) =>LoginViewModel(),),
      ChangeNotifierProvider(create: (_) =>AdminViewModel(),),
      ChangeNotifierProvider(create: (_) =>EmployeeViewModel(),),
      ChangeNotifierProvider(create: (_) =>SearchViewModel(),),
      ChangeNotifierProvider(create: (_) =>AddEmployeeViewModel(),),
      ChangeNotifierProvider(create: (_) =>DeleteEmployeeViewModel(),),
      ChangeNotifierProvider(create: (_) =>UpdateEmployeeViewModel(),),
      ChangeNotifierProvider(create: (_) =>ChangePasswordViewModel(),),
      ChangeNotifierProvider(create: (_) =>TimeConfViewModel(),),
      ChangeNotifierProvider(create: (_) =>RegisterEmployeeViewModel(),)


    ],
    child: MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: [
//        Locale('en', 'US'),
        Locale('ar', ''),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      title: "Shield",
      color: Colors.grey,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xfffefdfd),
        appBarTheme: AppBarTheme(elevation: 0, color: Color(0xfffefdfd)),
        textTheme: TextTheme(title: TextStyle(color: Colors.black)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Cairo',
      ),

      home: Login(),
    );
  }
}
