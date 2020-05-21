import 'package:netflixdemo/rest/response/Genre.dart';
import 'package:netflixdemo/rest/response/ProductionCountries.dart';

class MovieDetails{

  final int id;
  final String originalLang;
  final String overview;
  final String posterPath;
  final String backdrop_path;
  final int runtime;
  final String status;
  final String tagline;
  final String title;
  final String release_date;
  final double vote_average;
  final List<Genre>genres;
  final List<ProductionCountries>production_countries;

  MovieDetails({this.id,this.originalLang,this.overview,this.posterPath,
                this.backdrop_path,this.runtime,this.status,this.tagline,
                this.title,this.vote_average,this.genres,this.production_countries,this.release_date});

  factory MovieDetails.fromJson(Map<String,dynamic>json){

    return MovieDetails(
      id: json['id'],
      originalLang: json['original_language'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      backdrop_path: json['backdrop_path'],
      runtime: json['runtime'],
      status: json['status'],
      tagline: json['tagline'],
      title: json['title'],
      vote_average: json['vote_average'],
      genres: (json['genres']==null)?new List<Genre>(0):
      (json['genres'] as List).map((i)=>Genre.fromJson(i)).toList(),
      production_countries: (json['production_countries']==null)?new List<ProductionCountries>(0):
      (json['production_countries'] as List).map((i)=>ProductionCountries.fromJson(i)).toList(),
      release_date: json['release_date']
    );
  }

  @override
  String toString() {
    return 'MovieDetails{id: $id, originalLang: $originalLang, overview: $overview, '
        'posterPath: $posterPath, backdrop_path: $backdrop_path, runtime: $runtime, '
        'status: $status, tagline: $tagline, title: $title, vote_average: $vote_average, '
        'genres: $genres, production_countries: $production_countries}';
  }


}