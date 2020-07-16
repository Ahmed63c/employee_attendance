import 'Time.dart';
class TimeConfModel {
    String message;
    String status;
    Time time;

    TimeConfModel({this.message, this.status, this.time});

    factory TimeConfModel.fromJson(Map<String, dynamic> json) {
        return TimeConfModel(
            message: json['message'], 
            status: json['status'], 
            time: json['details'] != null ? Time.fromJson(json['details']) : null,
        );
    }
}