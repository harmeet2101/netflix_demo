import 'dart:async';

import 'package:netflixdemo/bloc/bloc.dart';
import 'package:netflixdemo/repository/TopRatedMoviesRepo.dart';
import 'package:netflixdemo/rest/Response.dart';
import 'package:netflixdemo/rest/response/popular.dart';

class TopRatedMoviesBloc extends Bloc{


  StreamController<Response<Popular>> _topRatedMoviesStreamController;
  TopRatedMoviesRepo _topRatedMoviesRepo;

  Stream<Response<Popular>> get topRatedMovieStream =>_topRatedMoviesStreamController.stream;
  StreamSink<Response<Popular>> get topRatedMovieSink=>_topRatedMoviesStreamController.sink;


  TopRatedMoviesBloc(){

    _topRatedMoviesRepo = new TopRatedMoviesRepo();
    _topRatedMoviesStreamController = new StreamController<Response<Popular>>();
    fetchTopRatedMovies();

  }

  void fetchTopRatedMovies()async{

    _topRatedMoviesStreamController.add(Response.loading('Fetching Top rated movies....'));
    try{
      Popular resp = await _topRatedMoviesRepo.fetchTopRatedMovies();
      _topRatedMoviesStreamController.add(Response.completed(resp));
    }catch(e){
      _topRatedMoviesStreamController.add(Response.error(e.toString()));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _topRatedMoviesStreamController?.close();
  }


  Future<dynamic> referesh(){

    fetchTopRatedMovies();

  }

  @override
  void refershIfNeeded(String blocType) {
    // TODO: implement refershIfNeeded
    referesh();
  }
}