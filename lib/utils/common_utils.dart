import 'package:netflixdemo/rest/response/Genre.dart';
import 'package:netflixdemo/rest/response/MovieResults.dart';

class CommonUtils{


  static String getGenreListAsString(List<Genre> gl){

    var res = '';

    if(gl.length==1)
      {
        res = gl[0].name;
        return res;
      }

    for(int i=0; i <gl.length;i++){
      res = res + gl[i].name;

      if(gl.length-1!=i)
        res = res + ',';
    }

    return res;
  }

  static List<MovieResults> getDummyScreenShots(){

    List<MovieResults> res = List();

    for(int i =0;i< 5 ;i++){

      res.add(new MovieResults(id: 0,poster_path: null,backdrop_path: null));
    }

    return res;
  }
}