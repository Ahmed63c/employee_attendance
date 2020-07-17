import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:employeeattendance/Models/BaseApiResponse.dart';
import 'package:employeeattendance/Models/SearchModel.dart';
import 'package:employeeattendance/Network/WebService.dart';
import 'package:flutter/cupertino.dart';

enum LoadingStatus {
  completed, searching, empty,error
}

class EmployeeViewModel with ChangeNotifier{

  var webService=WebService().getInstanceOfDio();
  LoadingStatus loadingStatus=LoadingStatus.empty;
  String error="حدث خطأ ما تحقق منن الانترنت وحاول مره أخري";
  BaseResponse base=new BaseResponse();
  List<SearchResults> searchResults;


  void doCreateUserLog(String token,String type,String
  location,String lat ,String lang,String imagePath,String fileName,String code) async{
    this.loadingStatus = LoadingStatus.searching;
    notifyListeners();

    FormData formData= FormData.fromMap({
      "action":"doCreateUserLog",
      "token": token,
      "type": type,
      "location": location,
      "latitude": lat,
      "longitude": lang,
      "image": await MultipartFile.fromFile(imagePath,filename: fileName),
      "user_code":code
    });

    try {

      webService.options.contentType="multipart/form-data";
      final response = await webService.post("/api.php",data: formData);

      if (response.statusCode == 200) {

        var parsedJson = json.decode(response.data);
        base=BaseResponse.fromJson(parsedJson);


        if(base.status=="01"){
          this.loadingStatus=LoadingStatus.completed;
          notifyListeners();
        }
        else{
          this.loadingStatus = LoadingStatus.error;
          error=base.message;
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