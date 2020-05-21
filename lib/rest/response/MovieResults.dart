class MovieResults{

  final String poster_path;
  final int id;
  final String backdrop_path;
  final String original_language;
  final String original_title;
  final String title;
  final dynamic voteAvg;
  final String overview;
  final String releaseDate;

  MovieResults({this.poster_path,this.id,this.backdrop_path,
    this.original_language,this.original_title,this.voteAvg,this.overview,this.releaseDate,this.title});

  factory MovieResults.fromJson(Map<String,dynamic> json){

    return MovieResults(
      id: json['id'],
      poster_path:  json['poster_path'],
      backdrop_path: json['backdrop_path'],
      original_language: json['original_language'],
      original_title: json['original_title'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      voteAvg: json['vote_average'],
      title: json['title']
    );
  }

  @override
  String toString() {
    return 'MovieResults{poster_path: $poster_path, id: $id, backdrop_path: $backdrop_path,'
        ' original_language: $original_language, original_title: $original_title, '
        'title: $title, voteAvg: $voteAvg, overview: $overview, releaseDate: $releaseDate}';
  }


}