class Time {
    String day_end_time;
    String day_start_time;
    String thursday_end_time;
    String thursday_start_time;

    Time({this.day_end_time, this.day_start_time, this.thursday_end_time, this.thursday_start_time});

    factory Time.fromJson(Map<String, dynamic> json) {
        return Time(
            day_end_time: json['day_end_time'], 
            day_start_time: json['day_start_time'], 
            thursday_end_time: json['Thursday_end_time'],
            thursday_start_time: json['Thursday_start_time'],
        );
    }

}