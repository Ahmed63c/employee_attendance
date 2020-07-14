
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:employeeattendance/Models/BaseApiResponse.dart';
import 'package:employeeattendance/Models/SearchModel.dart';
import 'package:employeeattendance/Network/WebService.dart';
import 'package:flutter/cupertino.dart';

enum LoadingStatus {
  completed, searching, empty,error,
}


class AddEmployeeViewModel with ChangeNotifier{

  var webService=WebService().getInstanceOfDio();
  LoadingStatus loadingStatus=LoadingStatus.empty;
  BaseResponse baseResponse=new BaseResponse();
  String error="حدث خطأ ما تحقق منن الانترنت وحاول مره أخري";


  void doCreateUser(String token,String name,String code, String pass,String type ,String salary)  async{

    this.loadingStatus = LoadingStatus.searching;
    notifyListeners();

    try {
      final response = await webService.get("/api.php",queryParameters:
      {"action":"doCreateUser","token":token,"code":code,"password":pass,"type":type,"salary":salary,"name":name});

      if (response.statusCode == 200) {

        var parsedJson = json.decode(response.data);
        baseResponse=BaseResponse.fromJson(parsedJson);
        if(baseResponse.status=="01"){
          this.loadingStatus=LoadingStatus.completed;
          notifyListeners();
        }
        else{
          this.loadingStatus = LoadingStatus.error;
          error=baseResponse.message;
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

