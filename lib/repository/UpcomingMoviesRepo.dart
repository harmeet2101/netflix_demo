import 'package:netflixdemo/rest/api_provider.dart';
import 'package:netflixdemo/rest/response/popular.dart';
import 'package:netflixdemo/utils/AppConstants.dart';

class UpcomingMoviesRepo{

  ApiProvider _apiProvider = new ApiProvider();


  Future<Popular> fetchUpcomingMovies()async{
    var resp = await _apiProvider.getResponse(AppConstants.UPCOMING_MOVIE_END_POINT);
    Popular popular = Popular.fromJson(resp);
    return popular;
  }
}