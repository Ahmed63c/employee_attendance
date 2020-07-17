import 'dart:io';

import 'package:employeeattendance/Utils/AppProperties.dart';
import 'package:employeeattendance/Utils/Constant.dart';
import 'package:employeeattendance/Utils/SharedPrefrence.dart';
import 'package:employeeattendance/ViewModels/RegisterEmployeeViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
class RegisterEmployee extends StatefulWidget{
  @override
  _RegisterEmployeeState createState() => _RegisterEmployeeState();
}

class _RegisterEmployeeState extends State<RegisterEmployee> {

  String selectedText="حضور";
  TextEditingController codeController = TextEditingController();
  bool _validate = false;
  PermissionStatus _status;
  String lat;
  String lang;
  String location;
  RegisterEmployeeViewModel vm;



  @override
  void initState() {
    super.initState();
    StorageUtil.getInstance().then((storage){
      StorageUtil.putString(Constant.SHARED_USER_location,null);
      StorageUtil.putString(Constant.SHARED_USER_lat, null);
      StorageUtil.putString(Constant.SHARED_USER_lang,null);});
    runFirst();
  }


  @override
  Widget build(BuildContext context) {
    vm=Provider.of<RegisterEmployeeViewModel>(context);


    return Consumer<RegisterEmployeeViewModel>(builder:(context,model,child){
      WidgetsBinding.instance.addPostFrameCallback((_){
        // Add Your Code here.
        if(model.loadingStatus==LoadingStatus.completed){
          model.loadingStatus=LoadingStatus.empty;
        }
      });

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
              padding: EdgeInsets.only(left: 16,right: 16,top: 24),
              child: TextFormField(
                autofocus: false,
                obscureText:false,
                keyboardType: TextInputType.number,
                controller: codeController,
                decoration: InputDecoration(
                  hintText: "كود العامل",
                  errorText: _validate ? 'لا يمكن ان يكون الحقل فارغا' : null,

                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0,horizontal: 64),
              child: Center(
                child: DropdownButton<String>(
                  hint: Text(selectedText),
                  items: <String>['حضور', 'انصراف'].map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      this.selectedText=value;
                    });
                  },
                ),
              ),
            ),
            Visibility(
              visible:model.loadingStatus==LoadingStatus.searching,
              child: Center(child: CupertinoActivityIndicator()),
            ),
            Visibility(
              visible: model.loadingStatus==LoadingStatus.error,
              child:Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child:Center(
                    child: Text(model.error,
                      style:
                      TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: "Cairo",color: Colors.red),),
                  )),
            ),
            Visibility(
              visible: model.loadingStatus==LoadingStatus.completed,
              child:Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: Text("تم تسجيل العامل بنجاح",
                      style:
                      TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: "Cairo",color: Colors.green),),
                  )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 32.0,horizontal: 48),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                onPressed: () {
                  setState(() {
                    codeController.text.isEmpty ? _validate = true : _validate = false;
                  });

                  if(!_validate){
                    if(selectedText=="حضور"){
                      getImage("attending", codeController.text);
                    }
                    else{
                      getImage("leaving", codeController.text);
                    }
                  }

                },
                padding: EdgeInsets.only(left: 32,right: 32,top: 12,bottom: 12),
                color:Colors.green,
                child: Text("سجل عامل", style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      );
    });


  }

  void runFirst()async {
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

  _getLocation(String type,String code,String imagePath,String fileName) async {
    final postion = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(
        postion.latitude, postion.longitude,
        localeIdentifier: "ar");
    lat=postion.longitude.toString();
    lang=postion.longitude.toString();
    location=" ${placemark[0].subThoroughfare}"  "${placemark[0].thoroughfare}"
        "  ""${placemark[0].locality}"  "${placemark[0].administrativeArea}";
    print(postion);
    print(lat+"fromfunc");
    print(lang+"fromfunc");


    StorageUtil.getInstance().then((storage){
      String token=StorageUtil.getString(Constant.SHARED_USER_TOKEN);
      print("logggggggggggggggggggggggg");
      print(token);
      print(type);
      print(location);
      print(lat);
      print(lang);
      print(imagePath);
      print(fileName);
      if(lat==null||lang==null||location==null){
        vm.error="لم نستطيع تحديد موقعك من فضلك افتح خاصيه وتحديد الموقع اولا";
        vm.loadingStatus==LoadingStatus.error;
        vm.notifyListeners();
      }
      else{

        Provider.of<RegisterEmployeeViewModel>(context, listen: false).
        doCreateUserLog(token, type,location,lat,lang,imagePath,fileName,code);

      }}
    );
  }


  void getImage(String type,String code) async {
    var image = await ImagePicker.platform.pickImage(source: ImageSource.camera);
    final File file = File(image.path);
    String imagePath=image.path;
    String fileName=image.path.split('/').last;
    _getLocation(type,code,imagePath,fileName);

  }

}