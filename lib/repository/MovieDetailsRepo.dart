import 'package:netflixdemo/rest/api_provider.dart';
import 'package:netflixdemo/rest/response/MovieDetails.dart';
import 'package:netflixdemo/utils/AppConstants.dart';

class MovieDetailsRepo{


  ApiProvider _apiProvider = new ApiProvider();


  Future<MovieDetails> fetchMovieDetails(int movieId)async{
    var resp = await _apiProvider.getResponse(AppConstants.MOVIE_DETAIL_END_POINT+movieId.toString());
    MovieDetails movieDetails = MovieDetails.fromJson(resp);
    return movieDetails;
  }
}