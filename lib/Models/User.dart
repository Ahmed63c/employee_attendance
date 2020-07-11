import 'UserDetails.dart';

class User {
    UserDetails details;
    String message;
    String status;

    User({this.details, this.message, this.status});

    factory User.fromJson(Map<String, dynamic> json) {
        return User(
            details: json['details'] != null ? UserDetails.fromJson(json['details']) : null,
            message: json['message'], 
            status: json['status'], 
        );
    }
}