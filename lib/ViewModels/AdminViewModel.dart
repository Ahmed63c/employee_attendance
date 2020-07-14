import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:employeeattendance/Models/Report.dart';
import 'package:employeeattendance/Network/WebService.dart';
import 'package:flutter/cupertino.dart';

enum LoadingStatus {
  completed, searching, empty,error
}

class AdminViewModel with ChangeNotifier{

  var error="لا يوجد بيانات تحقق من الاتصال بالانترنت وحاول مرة اخري";
  Report report=new Report();

  var webService=WebService().getInstanceOfDio();
  LoadingStatus loadingStatus=LoadingStatus.searching;


  void getDailyReport (String date,String token) async{

    this.loadingStatus = LoadingStatus.searching;
    notifyListeners();

    try {

      final response = await webService.get("/api.php",
          queryParameters: {"action":"getDailyReport","token":token,"date":date});

      if (response.statusCode == 200) {

        var parsedJson = json.decode(response.data);
         report = Report.fromJson(parsedJson);

        print(report.status);

        if(report.status=="01"){
          this.loadingStatus=LoadingStatus.completed;
          notifyListeners();
        }
        else{
          this.loadingStatus = LoadingStatus.error;
          error=report.message;
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