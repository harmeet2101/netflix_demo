import 'package:netflixdemo/rest/api_provider.dart';
import 'package:netflixdemo/rest/response/popular.dart';
import 'package:netflixdemo/utils/AppConstants.dart';

class PopularMoviesRepo{

  ApiProvider _apiProvider = new ApiProvider();


  Future<Popular> fetchPopularMovies()async{
    var resp = await _apiProvider.getResponse(AppConstants.POPULAR_MOVIE_END_POINT);
    Popular popular = Popular.fromJson(resp);
    return popular;
  }
}