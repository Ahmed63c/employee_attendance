class Detail {
    String additionalHours;
    String attendingImg;
    String attendingLocation;
    String attendingTime;
    String code;
    String leavingImg;
    String leavingLocation;
    String leavingTime;
    String name;
    String salary;
    String type;

    Detail({this.additionalHours, this.attendingImg, this.attendingLocation, this.attendingTime, this.code, this.leavingImg, this.leavingLocation, this.leavingTime, this.name, this.salary, this.type});

    factory Detail.fromJson(Map<String, dynamic> json) {
        return Detail(
            additionalHours: json['additionalHours'], 
            attendingImg: json['attendingImg'], 
            attendingLocation: json['attendingLocation'], 
            attendingTime: json['attendingTime'], 
            code: json['code'], 
            leavingImg: json['leavingImg'], 
            leavingLocation: json['leavingLocation'], 
            leavingTime: json['leavingTime'], 
            name: json['name'], 
            salary: json['salary'], 
            type: json['type'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['additionalHours'] = this.additionalHours;
        data['attendingImg'] = this.attendingImg;
        data['attendingLocation'] = this.attendingLocation;
        data['attendingTime'] = this.attendingTime;
        data['code'] = this.code;
        data['leavingImg'] = this.leavingImg;
        data['leavingLocation'] = this.leavingLocation;
        data['leavingTime'] = this.leavingTime;
        data['name'] = this.name;
        data['salary'] = this.salary;
        data['type'] = this.type;
        return data;
    }
}