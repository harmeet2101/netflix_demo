import 'package:flutter/material.dart';
import 'package:netflixdemo/rest/response/MovieResults.dart';
import 'package:netflixdemo/ui/details_screen.dart';
import 'package:netflixdemo/utils/AppConstants.dart';

class CategoryHorizontalList extends StatelessWidget{

  Size itemSize;
  List<MovieResults> results;
  CategoryHorizontalList({@required this.itemSize,@required this.results});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(

      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[

        Container(
            width: itemSize.width,
            height: itemSize.height,
            child: ListView.builder(itemBuilder: (context,index)=>Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child:Material(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)
                ),
                child: InkWell(

                  onTap: (){

                    if(results[index].id==0)
                      return;
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen(movieId:results[index].id,)));
                  },
                  child: Container(

                    width: MediaQuery.of(context).size.width/2.5,

                    child: ClipRRect(child:(results[index].poster_path==null)?
                    Image.asset('assets/images/logo.png',fit: BoxFit.fill,)
                        :FadeInImage.assetNetwork(placeholder: 'assets/images/logo.png', image: AppConstants.TMDB_IMAGE_BASE_URL +
                        results[index].poster_path,fit: BoxFit.fill,),
                      borderRadius: BorderRadius.circular(10.0),),
                  ),
                ),
              ),
            ),itemCount: results.length,scrollDirection: Axis.horizontal,))
      ],
    );
  }
}