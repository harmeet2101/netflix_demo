import 'package:netflixdemo/bloc/bloc.dart';
import 'package:netflixdemo/bloc/popular_movies_bloc.dart';
import 'package:netflixdemo/bloc/top_rated_movies_bloc.dart';
import 'package:netflixdemo/bloc/upcoming_movies_bloc.dart';

class AppBloc extends Bloc{

  PopularMoviesBloc _popularMoviesBloc;
  TopRatedMoviesBloc _ratedMoviesBloc;
  UpcomingMoviesBloc _upcomingMoviesBloc;
  AppBloc(){

    _popularMoviesBloc = new PopularMoviesBloc();
    _ratedMoviesBloc = new TopRatedMoviesBloc();
    _upcomingMoviesBloc = new UpcomingMoviesBloc();
  }

  PopularMoviesBloc get popularMovieBloc =>_popularMoviesBloc;
  TopRatedMoviesBloc get topRatedMovieBloc =>_ratedMoviesBloc;
  UpcomingMoviesBloc get upcomingMoviesBloc =>_upcomingMoviesBloc;

  @override
  void dispose() {
    // TODO: implement dispose
    _popularMoviesBloc?.dispose();
    _ratedMoviesBloc?.dispose();
    _upcomingMoviesBloc?.dispose();
  }

  @override
  void refershIfNeeded(String blocType) {
    // TODO: implement refershIfNeeded

    switch(blocType){

      case 'Popular':
        _popularMoviesBloc?.referesh();
        break;
      case 'Top Rated':
        _ratedMoviesBloc?.referesh();
        break;
      case 'Upcoming':
        _upcomingMoviesBloc?.referesh();
        break;
    }
  }
}