
class Month {
    List<String> absentDates;
    List<String> earlyLeftDates;
    List<String> lateDates;
    List<String> type;
    String name;
    String salary;
    String code;
    List<String> additionalHoursDates;



    Month({this.absentDates, this.code, this.earlyLeftDates, this.lateDates, this.name, this.salary, this.type,this.additionalHoursDates});

    factory Month.fromJson(Map<String, dynamic> json) {
        return Month(
            absentDates: json['absentDates'] != null ? new List<String>.from(json['absentDates']) : null, 
            earlyLeftDates: json['earlyLeftDates'] != null ? new List<String>.from(json['earlyLeftDates']) : null,
            lateDates: json['lateDates'] != null ? new List<String>.from(json['lateDates']) : null,
            additionalHoursDates: json['additionalHoursDates'] != null ? new List<String>.from(json['additionalHoursDates']) : null,
            name: json['name'],
            code: json['code'],
            salary: json['salary'],
            type: json['type'] != null ? new List<String>.from(json['type']) : null,
        );
    }
}