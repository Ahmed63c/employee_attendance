import 'dart:async';
import 'dart:io';
import 'package:employeeattendance/Utils/AppProperties.dart';
import 'package:employeeattendance/Utils/Constant.dart';
import 'package:employeeattendance/Utils/SharedPrefrence.dart';
import 'package:employeeattendance/View/RegisterEmployee.dart';
import 'package:employeeattendance/ViewModels/EmployeeViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

import 'SearchView.dart';

class EmployeeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EmployeeViewState();
  }
}

class EmployeeViewState extends State<EmployeeView> {
  PermissionStatus _status;
  static String name="";
  var vm;

  @override
  void initState() {
    super.initState();
   StorageUtil.getInstance().then((storage){
     StorageUtil.putString(Constant.SHARED_USER_location,null);
     StorageUtil.putString(Constant.SHARED_USER_lat, null);
     StorageUtil.putString(Constant.SHARED_USER_lang,null);
      name="مرحبا "+StorageUtil.getString(Constant.SHARED_USER_NAME);});
    runFirst();
  }

  @override
  Widget build(BuildContext context) {
    BuildContext dialogContext;

    return Consumer<EmployeeViewModel>(

      builder: (context, model, child) => Stack(
        children: [
          // Use SomeExpensiveWidget here, without rebuilding every time.
          child,
          Visibility(
            visible:model.loadingStatus==LoadingStatus.searching,
            child: Positioned(
                bottom: MediaQuery.of(context).size.height/ MediaQuery.of(context).size.height+20,
                left: 20,
                right: 20,
                child: CupertinoActivityIndicator()),
          ),
          Visibility(
            visible: model.loadingStatus==LoadingStatus.error,
            child:Positioned(
              bottom: MediaQuery.of(context).size.height/ MediaQuery.of(context).size.height+20,
                left: 20,
                right: 20,
                child: Material(
                  child: Text(model.error, style: TextStyle(fontSize: 16,fontWeight:
                  FontWeight.w500,fontFamily: "Cairo",color: Colors.red),),
                )),
          ),
          Visibility(
            visible: model.loadingStatus==LoadingStatus.completed,
            child: Positioned(
              bottom: MediaQuery.of(context).size.height/ MediaQuery.of(context).size.height+20,
              left: 20,
              right: 20,
              child: Text("تم التسجيل بنجاح",
                    style:
                    TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: "Cairo",color: Colors.green),),
                )
          ),

        ],
      ),
      // Build the expensive widget here.
      child: Scaffold(
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
          title: Text(name,
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
              margin: EdgeInsets.only(left: 8, right: 8, top: 16),
              height: 140,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(10)),
              child: GestureDetector(
                onTap: () {
                  // open camera and location
                  _getLocation();
                  getImage("attending",null);
                },
                child: Column(
                  children: <Widget>[
                    Center(
                        child: Container(
                          width: 60,
                          height: 100,
                          child: ImageIcon(
                            AssetImage(
                              "assets/images/login.png",
                            ),
                            color: Colors.white,
                          ),
                        )),
                    Container(
                      child: Padding(
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
              margin: EdgeInsets.only(left: 8, right: 8, top: 16),
              height: 140,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(8)),
              child: GestureDetector(
                onTap: () {
                  _getLocation();
                  getImage("leaving",null);
                },
                child: Column(
                  children: <Widget>[
                    Center(
                        child: Container(
                          width: 60,
                          height: 100,
                          child: ImageIcon(
                            AssetImage(
                              "assets/images/logout.png",
                            ),
                            color: Colors.white,
                          ),
                        )),
                    Container(
                      child: Padding(
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
              margin: EdgeInsets.only(left: 8, right: 8, top: 16),
              height: 140,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: AppProperties.lightnavyregister,
                  borderRadius: BorderRadius.circular(8)),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => RegisterEmployee()));
                },
                child: Column(
                  children: <Widget>[
                    Center(
                        child: Container(
                          width: 60,
                          height: 100,
                          child: ImageIcon(
                            AssetImage(
                              "assets/images/registerr.png",
                            ),
                            color: Colors.white,
                          ),
                        )),
                    Container(
                      child: Padding(
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
          ],
        ),
      ),
    );
  }


  runFirst() async {
    await Permission.locationWhenInUse.status.then(_updateStatus);
    await _requestPerms();
    if (_status == PermissionStatus.granted) {
      bool gpsEnabled = await _gpsService();
      if (gpsEnabled) print("granted");
    } else if (_status == PermissionStatus.denied) {
      print("permission denied");
    }
  }

  void _updateStatus(PermissionStatus value) {
    setState(() {
      _status = value;
    });
  }

  void _requestPerms() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.locationWhenInUse,
    ].request();

    if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
      _updateStatus(PermissionStatus.granted);
//      final AndroidIntent intent = AndroidIntent(
//          action: 'android.settings.LOCATION_SOURCE_SETTINGS');
//        intent.launch();
    }
  }

  Future _gpsService() async {
    if (!(await Geolocator().isLocationServiceEnabled())) {
      _checkGps();
      return null;
    } else
      return true;
  }

  Future _checkGps() async {
    if (!(await Geolocator().isLocationServiceEnabled())) {
      if (Theme.of(context).platform == TargetPlatform.android) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("تحديد الموقع"),
                content: const Text(
                    'من فضلك افتح خاصية تحديد موقعك علي الهاتف ثم اضغط موافق'),
                actions: <Widget>[
                  FlatButton(
                      child: Text('موافق'),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                        _gpsService();
                      })
                ],
              );
            });
      }
    }
  }

  _getLocation() async {
    final postion = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(
        postion.latitude, postion.longitude,
        localeIdentifier: "ar");
   String lat=postion.longitude.toString();
   String lang=postion.longitude.toString();
   String location="${placemark[0].subThoroughfare}" "${placemark[0].thoroughfare}"
       " ""${placemark[0].locality}" "${placemark[0].administrativeArea}";
    print(postion);
    print(lat+"fromfunc");
    print(lang+"fromfunc");
    StorageUtil.getInstance().then((storage){
      StorageUtil.putString(Constant.SHARED_USER_location,location);
      StorageUtil.putString(Constant.SHARED_USER_lat, lat);
      StorageUtil.putString(Constant.SHARED_USER_lang,lang);
    });

  }


  void getImage(String type,String code) async {
    var image = await ImagePicker.platform.pickImage(source: ImageSource.camera);
   final File file = File(image.path);
   String imagePath=image.path;
   String fileName=image.path.split('/').last;

   StorageUtil.getInstance().then((storage){
     String token=StorageUtil.getString(Constant.SHARED_USER_TOKEN);
     String location=StorageUtil.getString(Constant.SHARED_USER_location);
     String lat=StorageUtil.getString(Constant.SHARED_USER_lat);
     String lang=StorageUtil.getString(Constant.SHARED_USER_lang);
     print("logggggggggggggggggggggggg");
     print(token);
     print(type);
     print(location);
     print(lat);
     print(lang);
     print(imagePath);
     print(fileName);

     Provider.of<EmployeeViewModel>(context, listen: false).
      doCreateUserLog(token, type,location,lat,lang,imagePath,fileName,code);

    });
  }


}
