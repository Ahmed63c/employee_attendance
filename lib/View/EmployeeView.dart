import 'package:employeeattendance/Utils/AppLocalization.dart';
import 'package:employeeattendance/Utils/AppProperties.dart';
import 'package:employeeattendance/Utils/LocationHelper.dart';
import 'package:employeeattendance/View/CheckInEmployee.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:geolocator/geolocator.dart';

import 'SearchView.dart';

class EmployeeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EmployeeViewState();
  }

}

class EmployeeViewState extends State<EmployeeView>{


  @override
  void initState() {
    super.initState();
    print("hi");



  }
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              color: Colors.black,
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => SearchPage()));
              },
            ),
          ],
          brightness: Brightness.light,
          backgroundColor: Colors.white70,
          title: Text(
            'مرحبا محمد ',
            style: TextStyle(
                color: Colors.black,
                fontFamily: "Cairo",
                fontWeight: FontWeight.w500),
          ),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(5),
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 8,right: 8,top: 16),
              height: 140,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10)),
              child: GestureDetector(
                onTap: () {
                 // open camera and location
                  _getLocation();
                },
                child: Column(
                  children: <Widget>[
                    Center(
                        child: Container(
                          width: 60,
                          height: 100,
                          child: ImageIcon(
                            AssetImage("assets/images/login.png",),
                            color: Colors.white,
                          ),
                        )
                    ),
                    Container(
                      child:
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          "تسجيل الحضور",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Cairo",
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 8,right: 8,top: 16),
              height: 140,
              width: MediaQuery.of(context).size.width,

              decoration: BoxDecoration(
                  color: Colors.redAccent, borderRadius: BorderRadius.circular(8)),
              child: GestureDetector(
                onTap: () {
//            setState(() {
//            });
//              Navigator.of(context)
//                  .push(MaterialPageRoute(builder: (_) => ProductPage()));
//              print("tapped");
                },
                child:
                Column(
                  children: <Widget>[
                    Center(
                        child: Container(
                          width: 60,
                          height: 100,
                          child: ImageIcon(
                            AssetImage("assets/images/logout.png",),
                            color: Colors.white,
                          ),
                        )
                    ),
                    Container(
                      child:
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          "تسجيل الانصراف",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Cairo",
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 8,right: 8,top: 16),
              height: 140,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: AppProperties.lightnavyregister, borderRadius: BorderRadius.circular(8)),
              child: GestureDetector(
                onTap: () {
//            setState(() {
//            });
//              Navigator.of(context)
//                  .push(MaterialPageRoute(builder: (_) => ProductPage()));
//              print("tapped");
                },
                child:
                Column(
                  children: <Widget>[
                    Center(
                        child: Container(
                          width: 60,
                          height: 100,
                          child: ImageIcon(
                            AssetImage("assets/images/registerr.png",),
                            color: Colors.white,
                          ),
                        )
                    ),
                    Container(
                      child:
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          "تسجيل عامل اخر",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Cairo",
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
//            userLocation == null
//                ? CircularProgressIndicator()
//                : Text("Location:" +
//                userLocation.latitude.toString() +
//                " " +
//                userLocation.longitude.toString()),
          ],
        ),
      );
  }


 _getLocation() async  {
    final postion = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(postion.latitude, postion.longitude,localeIdentifier: "ar");
    print(postion);
    print(placemark[0].subThoroughfare);
    print(placemark[0].thoroughfare);
    print(placemark[0].locality);
    print(placemark[0].administrativeArea);


 }

//  _getCurrentLocation() {
//    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
//
//    geolocator
//        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
//        .then((Position position) {
//      setState(() {
//        _currentPosition = position;
//      });
//    }).catchError((e) {
//      print(e);
//    });
//  }
}

