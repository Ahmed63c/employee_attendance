

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:employeeattendance/Models/SearchModel.dart';
import 'package:employeeattendance/Network/WebService.dart';
import 'package:flutter/cupertino.dart';

enum LoadingStatus {
  completed, searching, empty,error,
}


class SearchViewModel with ChangeNotifier{

  var webService=WebService().getInstanceOfDio();
  LoadingStatus loadingStatus=LoadingStatus.empty;
  List<SearchResults> searchResults;
  String error="حدث خطأ ما تحقق منن الانترنت وحاول مره أخري";


  void doSearchClient(String name,String token)  async{

    this.loadingStatus = LoadingStatus.searching;
    notifyListeners();

    try {
      final response = await webService.get("/api.php",queryParameters:
      {"action":"doSearchClient","name":name,"token":token});

      if (response.statusCode == 200) {

        var parsedJson = json.decode(response.data);
        SearchModel results = SearchModel.fromJson(parsedJson);
        if(results.status=="01"){

          searchResults=results.results;
          this.loadingStatus=LoadingStatus.completed;
          notifyListeners();
        }
        else{
          this.loadingStatus = LoadingStatus.error;
          error=results.message;
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

