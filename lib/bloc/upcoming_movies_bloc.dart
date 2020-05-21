import 'dart:async';

import 'package:netflixdemo/bloc/bloc.dart';
import 'package:netflixdemo/repository/UpcomingMoviesRepo.dart';
import 'package:netflixdemo/rest/Response.dart';
import 'package:netflixdemo/rest/response/popular.dart';

class UpcomingMoviesBloc extends Bloc{

  StreamController<Response<Popular>> _upComingMoviesStreamController;
  UpcomingMoviesRepo _upcomingMoviesRepo;
  Stream<Response<Popular>> get upcomingMovieStream =>_upComingMoviesStreamController.stream;
  StreamSink<Response<Popular>> get upcomingMovieSink=>_upComingMoviesStreamController.sink;

  UpcomingMoviesBloc(){

    _upcomingMoviesRepo = new UpcomingMoviesRepo();
    _upComingMoviesStreamController = new StreamController<Response<Popular>>();
    fetchUpcomingMovies();
  }


  void fetchUpcomingMovies()async{

    _upComingMoviesStreamController.add(Response.loading('Fetching upcoming movies....'));
    try{
      Popular resp = await _upcomingMoviesRepo.fetchUpcomingMovies();
      _upComingMoviesStreamController.add(Response.completed(resp));
    }catch(e){
      _upComingMoviesStreamController.add(Response.error(e.toString()));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _upComingMoviesStreamController?.close();
  }

  Future<dynamic> referesh()async{

    fetchUpcomingMovies();
  }

  @override
  void refershIfNeeded(String blocType) {
    // TODO: implement refershIfNeeded
    referesh();
  }
}