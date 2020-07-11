import 'dart:async';
import 'dart:io';

import 'package:employeeattendance/Utils/AppLocalization.dart';
import 'package:employeeattendance/Utils/AppProperties.dart';
import 'package:employeeattendance/Utils/LocationHelper.dart';
import 'package:employeeattendance/View/CheckInEmployee.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;

import 'SearchView.dart';

class EmployeeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EmployeeViewState();
  }

}

class EmployeeViewState extends State<EmployeeView>{
  PermissionStatus _status;



  @override
  void initState() {
    super.initState();
    print("hi");
    runFirst();
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
                 // _getLocation();
                  getImage();

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
    print(" hi after position");
    print(placemark[0].subThoroughfare);
    print(placemark[0].thoroughfare);
    print(placemark[0].locality);
    print(placemark[0].administrativeArea);


 }

  runFirst() async {
    await Permission.locationWhenInUse.status.then(_updateStatus);
    await _requestPerms();
    if (_status == PermissionStatus.granted) {
//      Navigator.push(
//          context, MaterialPageRoute(builder: (context) => NextPage()));
    bool gpsEnabled=_gpsService() as bool;
    if (gpsEnabled)
    print("granted");
    } else if (_status == PermissionStatus.denied) {
//      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      print("permission denied");


    }
  }

  void _updateStatus(PermissionStatus value) {
    setState(() {
      _status = value;
    });
  }

  void _requestPerms() async {
    Map<Permission, PermissionStatus> statuses = await
    [
      Permission.locationWhenInUse,
    ].request();


    if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
      _updateStatus(PermissionStatus.granted);
      //openAppSettings();
    }
  }

  Future _gpsService() async {
    if (!(await Geolocator().isLocationServiceEnabled())) {
      _checkGps();
      return null;
    } else
      return true;
  }

  /*Show dialog if GPS not enabled and open settings location*/
  Future _checkGps() async {
    if (!(await Geolocator().isLocationServiceEnabled())) {
      if (Theme.of(context).platform == TargetPlatform.android) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Can't get gurrent location"),
                content:const Text('Please make sure you enable GPS and try again'),
                actions: <Widget>[
                  FlatButton(child: Text('Ok'),
                      onPressed: () {
//                        final AndroidIntent intent = AndroidIntent(
//                            action: 'android.settings.LOCATION_SOURCE_SETTINGS');
//                        intent.launch();
                        Navigator.of(context, rootNavigator: true).pop();
                        _gpsService();
                      })],
              );
            });
      }
    }
  }

  void getImage() async{
    PickedFile image=await ImagePicker.platform.pickImage(source: ImageSource.camera);
    final File file = File(image.path);
    print('Original path: ${image.path}');
    String dir = path.dirname(image.path);
    String newPath = path.join(dir, 'name.jpg');
    print('NewPath: ${newPath}');
    file.renameSync(newPath);
  }
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



