import 'package:netflixdemo/rest/response/MovieResults.dart';

class Popular{

  final int page;
  final int totalResults ;
  final int totalPages;
  final List<MovieResults> results;

  Popular({this.page,this.totalResults,this.totalPages,this.results});

  factory Popular.fromJson(Map<String,dynamic> json){

    return Popular(
      page: json['page'],
      totalResults: json['total_results'],
      totalPages: json['total_pages'],
      results: (json['results']==null)?new List<MovieResults>(0)
          :(json['results'] as List).map((i)=>MovieResults.fromJson(i)).toList()
    );
  }

  @override
  String toString() {
    return 'Popular{page: $page, totalResults: $totalResults, totalPages: $totalPages, results: $results}';
  }


}