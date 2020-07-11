
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'Utils/AppLocalization.dart';
import 'View/LoginView.dart';

void main() {
  runApp(MyApp());
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
