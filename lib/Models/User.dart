import 'package:employeeattendance/Models/Details.dart';

class User {
    String status;
    String message;
    Details details;
    String appVersion;


    User({this.details, this.message, this.status,this.appVersion});

    factory User.fromJson(Map<String, dynamic> json) {
        return User(
            status: json['status'],
            message: json['message'],
            details: json['details'] !=null ? Details.fromJson(json['details']) : null,
            appVersion: json['appVersion'],

        );
    }
}