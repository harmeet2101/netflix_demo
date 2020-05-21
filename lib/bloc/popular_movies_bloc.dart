import 'dart:async';

import 'package:netflixdemo/bloc/bloc.dart';
import 'package:netflixdemo/repository/TopRatedMoviesRepo.dart';
import 'package:netflixdemo/repository/UpcomingMoviesRepo.dart';
import 'package:netflixdemo/repository/popularMoviesRepo.dart';
import 'package:netflixdemo/rest/Response.dart';
import 'package:netflixdemo/rest/Status.dart';
import 'package:netflixdemo/rest/response/popular.dart';

class PopularMoviesBloc extends Bloc{

  StreamController<Response<Popular>> _popularMoviesStreamController;

  PopularMoviesRepo _popularMoviesRepo;

  Stream<Response<Popular>> get popularMovieStream =>_popularMoviesStreamController.stream;

  StreamSink<Response<Popular>> get popularMovieSink=>_popularMoviesStreamController.sink;


  PopularMoviesBloc(){
    _popularMoviesRepo = new PopularMoviesRepo();

    _popularMoviesStreamController = new StreamController<Response<Popular>>();

    fetchPopularMovies();
  }

  void fetchPopularMovies()async{

    popularMovieSink.add(Response.loading('Fetching popular movies....'));
    try{
        Popular resp = await _popularMoviesRepo.fetchPopularMovies();
        popularMovieSink.add(Response.completed(resp));
    }catch(e){
      popularMovieSink.add(Response.error(e.toString()));
    }
  }


  Future<dynamic> referesh()async{
    await fetchPopularMovies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _popularMoviesStreamController?.close();
  }

  @override
  void refershIfNeeded(String blocType) {
    // TODO: implement refershIfNeeded
    referesh();
  }
}