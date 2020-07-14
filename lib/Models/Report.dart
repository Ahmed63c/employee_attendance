import 'package:employeeattendance/Models/EmployeeDetail.dart';

class Report {
    List<Detail> details;
    String isAbsentCount;
    String isAbsentPercentage;
    String isEarlyLeftCount;
    String isEarlyLeftPercentage;
    String isLateCount;
    String isLatePercentage;
    String isNormalCount;
    String isNormalPercentage;
    String message;
    String status;

    Report({this.details, this.isAbsentCount, this.isAbsentPercentage, this.isEarlyLeftCount, this.isEarlyLeftPercentage, this.isLateCount, this.isLatePercentage, this.isNormalCount, this.isNormalPercentage, this.message, this.status});

    factory Report.fromJson(Map<String, dynamic> json) {
        return Report(
            details: json['details'] != null ? (json['details'] as List).map((i) => Detail.fromJson(i)).toList() : null, 
            isAbsentCount: json['isAbsentCount'], 
            isAbsentPercentage: json['isAbsentPercentage'], 
            isEarlyLeftCount: json['isEarlyLeftCount'], 
            isEarlyLeftPercentage: json['isEarlyLeftPercentage'], 
            isLateCount: json['isLateCount'], 
            isLatePercentage: json['isLatePercentage'], 
            isNormalCount: json['isNormalCount'], 
            isNormalPercentage: json['isNormalPercentage'], 
            message: json['message'], 
            status: json['status'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['isAbsentCount'] = this.isAbsentCount;
        data['isAbsentPercentage'] = this.isAbsentPercentage;
        data['isEarlyLeftCount'] = this.isEarlyLeftCount;
        data['isEarlyLeftPercentage'] = this.isEarlyLeftPercentage;
        data['isLateCount'] = this.isLateCount;
        data['isLatePercentage'] = this.isLatePercentage;
        data['isNormalCount'] = this.isNormalCount;
        data['isNormalPercentage'] = this.isNormalPercentage;
        data['message'] = this.message;
        data['status'] = this.status;
        if (this.details != null) {
            data['details'] = this.details.map((v) => v.toJson()).toList();
        }
        return data;
    }
}