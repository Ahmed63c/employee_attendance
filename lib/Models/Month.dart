
class Month {
    List<String> absentDates;
    List<String> earlyLeftDates;
    List<String> lateDates;
    List<String> type;
    String name;
    String salary;
    String code;
    String additionalHours;



    Month({this.absentDates, this.code, this.earlyLeftDates, this.lateDates, this.name, this.salary, this.type,this.additionalHours});

    factory Month.fromJson(Map<String, dynamic> json) {
        return Month(
            absentDates: json['absentDates'] != null ? new List<String>.from(json['absentDates']) : null, 
            earlyLeftDates: json['earlyLeftDates'] != null ? new List<String>.from(json['earlyLeftDates']) : null,
            lateDates: json['lateDates'] != null ? new List<String>.from(json['lateDates']) : null,
            name: json['name'],
            code: json['code'],
            salary: json['salary'],
            additionalHours: json['additionalHours'],
            type: json['type'] != null ? new List<String>.from(json['type']) : null, 
        );
    }
}