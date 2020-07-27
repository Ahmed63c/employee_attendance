
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:employeeattendance/Models/BaseApiResponse.dart';
import 'package:employeeattendance/Models/TimeConfModel.dart';
import 'package:employeeattendance/Network/WebService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum LoadingStatus {
  completed, searching, empty,error,
}


class TimeConfViewModel with ChangeNotifier{

  var webService=WebService().getInstanceOfDio();


  LoadingStatus loadingStatus=LoadingStatus.empty;
  TimeConfModel timeConf=new TimeConfModel();
  BaseResponse _baseResponse=new BaseResponse();
   String startDay;
   String endDay;
   String startExp;
   String endExp;
   String error="حدث خطأ ما تحقق منن الانترنت وحاول مره أخري";
   String success=" ";


  void getConfigurationSetting(String token)  async{

    this.loadingStatus = LoadingStatus.searching;
    notifyListeners();

    try {
      final response = await webService.get("/api.php",queryParameters:
      {"action":"getConfigurationSetting","token":token});

      if (response.statusCode == 200) {

        var parsedJson = json.decode(response.data);
        timeConf=TimeConfModel.fromJson(parsedJson);
        if(timeConf.status=="01"){
          startDay=timeConf.time.day_start_time;
          endDay=timeConf.time.day_end_time;
          startExp=timeConf.time.thursday_start_time;
          endExp=timeConf.time.thursday_end_time;
          this.loadingStatus=LoadingStatus.completed;

        }
        else{
          this.loadingStatus = LoadingStatus.error;
          error=timeConf.message;
        }
      }
      else {
        this.loadingStatus = LoadingStatus.error;
        error="حدث خطأ ما تحقق منن الانترنت وحاول مره أخري";
      }

      notifyListeners();
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

  void doUpdateConfigurationSetting(String token,String startTime
      ,String endTime,String startTimeThursday,String endTimeThursday)  async{

    this.loadingStatus = LoadingStatus.searching;
    notifyListeners();

    try {
      final response = await webService.get("/api.php",queryParameters:
      {"action":"doUpdateConfigurationSetting","token":token,"dayStartTime":startTime,
      "dayEndTime":endTime,"ThursdayStartTime":startTimeThursday,"ThursdayEndTime":endTimeThursday});


      if (response.statusCode == 200) {
        var parsedJson = json.decode(response.data);
        _baseResponse=BaseResponse.fromJson(parsedJson);

        startDay=startTime;
        endDay=endTime;
        startExp=startTimeThursday;
        endExp=endTimeThursday;

        if(_baseResponse.status=="01"){
          success="تم تعديل البيانات بنجاح";
          this.loadingStatus=LoadingStatus.completed;
        }
        else{
          this.loadingStatus = LoadingStatus.error;
          error=_baseResponse.message;
        }
      }
      else {
        this.loadingStatus = LoadingStatus.error;
        error="حدث خطأ ما تحقق منن الانترنت وحاول مره أخري";
      }
      notifyListeners();
    } on Exception catch (e) {
      if(e is DioError){
        print(e.toString());
        this.loadingStatus = LoadingStatus.error;
        error="حدث خطأ ما تحقق منن الانترنت وحاول مره أخري";
        notifyListeners();
        // return ;
      }
      else{
        print(e.toString());
        this.loadingStatus = LoadingStatus.error;
        error="حدث خطأ ما تحقق منن الانترنت وحاول مره أخري";
        notifyListeners();
        //return ;
      }
    }

  }

}

