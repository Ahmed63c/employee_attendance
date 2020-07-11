import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:employeeattendance/Models/User.dart';
import 'package:employeeattendance/Network/ApiClient.dart';
import 'package:employeeattendance/Network/WebService.dart';
import 'package:employeeattendance/Utils/LoadingStatus.dart';
import 'package:flutter/cupertino.dart';

enum LoadingStatus {
  completed, searching, empty,error
}

class LoginViewModel with ChangeNotifier{

  var webService=WebService().getInstanceOfDio();

  //at first is empty
  LoadingStatus loadingStatus=LoadingStatus.empty;
  notifyListeners();

  User user=User();

  Future<Response> doLogin(String code,String pass)  async{

    this.loadingStatus = LoadingStatus.searching;
    notifyListeners();
    try {
      final response = await webService.get("/api.php",queryParameters: {"action":"doLogin","code":code,"password":pass});

      if (response.statusCode == 200) {
        final result = response.data;
        final Map parsed = json.decode(result);
        User.fromJson(parsed);
        print(result);
        if(user.status==01){
          if(user.details==null){
            this.loadingStatus = LoadingStatus.empty;
            notifyListeners();

          }
          else{
            this.loadingStatus = LoadingStatus.completed;
            notifyListeners();
          }
        }
        else{
          this.loadingStatus = LoadingStatus.error;
          notifyListeners();

        }
      }
      else {
        this.loadingStatus = LoadingStatus.error;
        notifyListeners();
      }
    } on Exception catch (e) {
      if(e is DioError){
        this.loadingStatus = LoadingStatus.error;
        notifyListeners();
        // return ;
      }
      else{
        this.loadingStatus = LoadingStatus.error;
        notifyListeners();
        //return ;
      }
    }

  }



}