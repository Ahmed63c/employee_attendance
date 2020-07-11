class Response {
  String message;
  String status;

  Response({ this.message, this.status});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      message: json['message'],
      status: json['status'],
    );
  }

}