
import 'dart:async';

import 'package:netflixdemo/bloc/bloc.dart';
import 'package:netflixdemo/repository/MovieDetailsRepo.dart';
import 'package:netflixdemo/rest/Response.dart';
import 'package:netflixdemo/rest/response/MovieDetails.dart';

class MovieDetailsBloc extends Bloc{

  StreamController<Response<MovieDetails>> _streamController;
  MovieDetailsRepo _movieDetailsRepo;

  Stream<Response<MovieDetails>> get movieDetailsStream =>_streamController.stream;
  StreamSink<Response<MovieDetails>> get movieDetailsSink=>_streamController.sink;
  final int movieId;

  MovieDetailsBloc({this.movieId}){


    _streamController = new StreamController<Response<MovieDetails>>();
    _movieDetailsRepo = new MovieDetailsRepo();
    fetchrMovieDetails(movieId);
  }


   void fetchrMovieDetails(int movieId)async{

    movieDetailsSink.add(Response.loading('Fetching movie details....'));
    try{
      MovieDetails resp = await _movieDetailsRepo.fetchMovieDetails(movieId);
      movieDetailsSink.add(Response.completed(resp));
    }catch(e){
      movieDetailsSink.add(Response.error(e.toString()));
    }
  }

  @override
  void dispose() {
    _streamController?.close();
  }

  @override
  void refershIfNeeded(String blocType) {
    // TODO: implement refershIfNeeded

    fetchrMovieDetails(movieId);

  }
}