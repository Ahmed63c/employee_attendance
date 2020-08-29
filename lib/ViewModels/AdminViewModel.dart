import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:employeeattendance/Models/EmployeeDetail.dart';
import 'package:employeeattendance/Models/MonthModel.dart';
import 'package:employeeattendance/Models/Report.dart';
import 'package:employeeattendance/Network/WebService.dart';
import 'package:flutter/cupertino.dart';

enum LoadingStatus {
  completed, searching, empty,error
}

class AdminViewModel with ChangeNotifier{

  var error="لا يوجد بيانات تحقق من الاتصال بالانترنت وحاول مرة اخري";
  Report report=new Report();
  List<Detail> attendance;
  List<Detail> absent;
  List<Detail> late;
  List<Detail> early;


  MonthModel monthModel=new MonthModel();
  String adsentDates;
  String earlyDates;
  String lateDates;


  var webService=WebService().getInstanceOfDio();
  LoadingStatus loadingStatus=LoadingStatus.searching;


  void getDailyReport (String date,String token) async{

    attendance=new List();
    absent=new List();
     late=new List();
     early=new List();

    this.loadingStatus = LoadingStatus.searching;
    notifyListeners();

    try {

      final response = await webService.get("/api.php",
          queryParameters: {"action":"getDailyReport","token":token,"date":date});

      if (response.statusCode == 200) {

        var parsedJson = json.decode(response.data);
        report = Report.fromJson(parsedJson);
        if(report.status=="01"){
          for(Detail item  in report.details){
            switch (item.type){
              case "is_normal":
                this.attendance.add(item);
                break;
              case "is_late":
                this.late.add(item);
                break;
              case "is_early_left":
                this.early.add(item);
                break;
              case "is_absent":
                this.absent.add(item);
                break;
            }
          }

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

  void getMonthlyReport (String month,String token) async{
    this.loadingStatus = LoadingStatus.searching;
    notifyListeners();

    try {

      final response = await webService.get("/api.php",
          queryParameters: {"action":"getMonthlyReport","token":token,"month":month});

      if (response.statusCode == 200) {

        var parsedJson = json.decode(response.data);
        monthModel = MonthModel.fromJson(parsedJson);

        if(monthModel.status=="01"){
          this.loadingStatus=LoadingStatus.completed;
          notifyListeners();
        }
        else{
          this.loadingStatus = LoadingStatus.error;
          error="لاتوجد بيانات عن هذا الشهر";
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