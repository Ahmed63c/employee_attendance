import 'Month.dart';
class MonthModel {
    String isAbsentCount;
    String isAbsentPercentage;
    String isEarlyLeftCount;
    String isEarlyLeftPercentage;
    String isLateCount;
    String isLatePercentage;
    String isNormalCount;
    String isNormalPercentage;
    String message;
    List<Month> month;
    String status;

    MonthModel({this.isAbsentCount, this.isAbsentPercentage, this.isEarlyLeftCount, this.isEarlyLeftPercentage, this.isLateCount, this.isLatePercentage, this.isNormalCount, this.isNormalPercentage, this.message, this.month, this.status});

    factory MonthModel.fromJson(Map<String, dynamic> json) {
        return MonthModel(
            isAbsentCount: json['isAbsentCount'], 
            isAbsentPercentage: json['isAbsentPercentage'], 
            isEarlyLeftCount: json['isEarlyLeftCount'], 
            isEarlyLeftPercentage: json['isEarlyLeftPercentage'], 
            isLateCount: json['isLateCount'], 
            isLatePercentage: json['isLatePercentage'], 
            isNormalCount: json['isNormalCount'], 
            isNormalPercentage: json['isNormalPercentage'], 
            message: json['message'], 
            month: json['details'] != null ? (json['details'] as List).map((i) => Month.fromJson(i)).toList() : null,
            status: json['status'], 
        );
    }

}