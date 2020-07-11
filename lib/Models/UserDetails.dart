class UserDetails {
    String code;
    String created_at;
    String id;
    String name;
    String salary;
    String token;
    String type;

    UserDetails({this.code, this.created_at, this.id, this.name, this.salary, this.token, this.type});

    factory UserDetails.fromJson(Map<String, dynamic> json) {
        return UserDetails(
            code: json['code'], 
            created_at: json['created_at'], 
            id: json['id'], 
            name: json['name'], 
            salary: json['salary'], 
            token: json['token'], 
            type: json['type'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['code'] = this.code;
        data['created_at'] = this.created_at;
        data['id'] = this.id;
        data['name'] = this.name;
        data['salary'] = this.salary;
        data['token'] = this.token;
        data['type'] = this.type;
        return data;
    }
}