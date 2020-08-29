import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:employeeattendance/Models/User.dart';
import 'package:employeeattendance/Network/ApiClient.dart';
import 'package:employeeattendance/Network/WebService.dart';
import 'package:employeeattendance/Utils/Constant.dart';
import 'package:employeeattendance/Utils/SharedPrefrence.dart';
import 'package:flutter/cupertino.dart';

enum LoadingStatus {
  completed, searching, empty,error
}

class LoginViewModel with ChangeNotifier{

  var webService=WebService().getInstanceOfDio();

  //at first is empty
  LoadingStatus loadingStatus=LoadingStatus.empty;
  String error="";
  String user_type="";
  User user;
  void doLogin(String code,String pass)  async{

    this.loadingStatus = LoadingStatus.searching;
    notifyListeners();

    try {
      final response = await webService.get("/api.php",queryParameters: {"action":"doLogin","code":code,"password":pass});

      print(response.statusCode);
      if (response.statusCode == 200) {

        var parsedJson = json.decode(response.data);
        user = User.fromJson(parsedJson);
        if(user.status=="01"){
          if(user.appVersion==Constant.APP_VERSION){
            this.user_type=user.details.type;
            StorageUtil.getInstance().then((storage){
              StorageUtil.putString(Constant.SHARED_USER_NAME, user.details.name);
              StorageUtil.putString(Constant.SHARED_USER_TYPE, user.details.type);
              StorageUtil.putString(Constant.SHARED_USER_TOKEN, user.details.token);
            });

            this.loadingStatus=LoadingStatus.completed;
            notifyListeners();
          }
          else{
            this.loadingStatus = LoadingStatus.error;
            error="تم تحديث نسخه التطبيق من فضلك حمل النسخة الجديدة";
            notifyListeners();

          }

        }
        else{
          this.loadingStatus = LoadingStatus.error;
          error=user.message;
          notifyListeners();

        }
      }
      else {
        this.loadingStatus = LoadingStatus.error;
        error="حدث خطأ ما تحقق منن الانترنت وحاول مره أخري";
        notifyListeners();
     }
    } on Exception catch (e) {
      if(e is DioError){
        this.loadingStatus = LoadingStatus.error;
        error="حدث خطأ ما تحقق منن الانترنت وحاول مره أخري";
        notifyListeners();
        // return ;
      }
      else{
        this.loadingStatus = LoadingStatus.error;
        error="حدث خطأ ما تحقق منن الانترنت وحاول مره أخري";
        notifyListeners();
        //return ;
      }
    }

  }



}