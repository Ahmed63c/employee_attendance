class SearchModel {
    List<SearchResults> results;
    String message;
    String status;

    SearchModel({this.results, this.message, this.status});

    factory SearchModel.fromJson(Map<String, dynamic> json) {
        return SearchModel(
            results: json['details'] != null ? (json['details'] as List).map((i) => SearchResults.fromJson(i)).toList() : null,
            message: json['message'], 
            status: json['status'], 
        );
    }

}


class SearchResults {
    String code;
    String name;

    SearchResults({this.code, this.name});

    factory SearchResults.fromJson(Map<String, dynamic> json) {
        return SearchResults(
            code: json['code'],
            name: json['name'],
        );
    }

}