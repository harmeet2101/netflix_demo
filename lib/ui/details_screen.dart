
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:netflixdemo/bloc/movie_details_bloc.dart';
import 'package:netflixdemo/rest/Response.dart';
import 'package:netflixdemo/rest/Status.dart';
import 'package:netflixdemo/rest/response/MovieDetails.dart';
import 'package:netflixdemo/ui/ImageClipper.dart';
import 'package:netflixdemo/ui/category_horiz_list.dart';
import 'package:netflixdemo/ui/error_widget.dart';
import 'package:netflixdemo/utils/common_utils.dart';
import 'package:netflixdemo/ui/category_header.dart';
import '../utils/AppConstants.dart';


class DetailsScreen extends StatefulWidget{

  final int movieId;

  DetailsScreen({this.movieId});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DetailScreenState();
  }
}

class DetailScreenState extends State<DetailsScreen>{

  MovieDetailsBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = new MovieDetailsBloc(movieId: widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      backgroundColor: Colors.white,
      body: StreamBuilder<Response<MovieDetails>>(builder: (context,snapshot){

        if (snapshot.connectionState == ConnectionState.none &&
            snapshot.hasData == null) {
          return Container();
        }
        if(snapshot.hasData){

          switch(snapshot.data.status){

            case Status.LOADING:
            // TODO: Handle this case.
              return Container(child: Center(child: CircularProgressIndicator()));
            case Status.COMPLETED:
              return CustomScrollView(
                slivers: <Widget>[
                  SliverPersistentHeader(delegate: CustomSliverAppbar(expandedHeight: MediaQuery.of(context).size.height/2,
                      imgUrl: snapshot.data.data.backdrop_path),pinned: false,),
                  SliverToBoxAdapter(child: Container(
                    color: Colors.white,
                    child: Column(

                      children: <Widget>[

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: IconButton(icon: Icon(Icons.add,size: 26,), onPressed: (){}),
                            ),
                            IconButton(icon: Icon(Icons.share,size: 26,), onPressed: (){}),
                          ],
                        ),
                        Padding(padding: EdgeInsets.fromLTRB(80, 10, 80, 10),
                          child: Container(
                            child: Text(snapshot.data.data.title,textAlign: TextAlign.center,maxLines: 2,softWrap:true,style:
                            TextStyle(fontSize: 24,color: Colors.black,fontWeight: FontWeight.w500),),),
                        ),
                        Padding(padding: EdgeInsets.fromLTRB(60, 0, 60, 10),
                          child: Container(
                            child: Text(CommonUtils.getGenreListAsString(snapshot.data.data.genres),
                              textAlign: TextAlign.center,maxLines: 1,softWrap:true,style:
                            TextStyle(fontSize: 18,color: Colors.black45),),),
                        ),
                        Padding(padding: EdgeInsets.fromLTRB(90, 0, 90, 10),
                          child: Container(
                              child: RatingBar(initialRating: 3,
                                minRating: 1,
                                direction: Axis.horizontal,
                                itemSize: 26,
                                allowHalfRating: true,
                                unratedColor: Colors.black54,
                                itemCount: 5,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                   color: Colors.red,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              )),
                        ),
                        Padding(padding: EdgeInsets.fromLTRB(90, 0, 90, 10),child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            getMovieParams('Year', snapshot.data.data.release_date.split('-').first),
                            getMovieParams('Country', snapshot.data.data.production_countries[0].isoName),
                            getMovieParams('Length', '${snapshot.data.data.runtime} min'),
                          ],
                        ),),
                        Padding(padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
                          child: Container(
                            child: Text(snapshot.data.data.overview
                              ,textAlign: TextAlign.justify,style:
                              TextStyle(fontSize: 18,color: Colors.black45),),),
                        ),
                        Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, 20),child:
                        Column(
                          children: <Widget>[
                            CategoryHeader(heading: 'Screenshots',),
                            CategoryHorizontalList(itemSize: Size(200, 130),results:CommonUtils.getDummyScreenShots(),),
                          ],
                        ),
)
                      ],
                    ),
                  ),)
                ],
              );
            case Status.ERROR:
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 60),
                child: Center(child: NetflixErrorWidget(errorMsg: snapshot.data.message,
                    bloc: _bloc, blocType: null)),
              );
          }

        }else{
          return new Container(child: Center(child: CircularProgressIndicator(),),);
        }


      },stream: _bloc.movieDetailsStream,),
    );
  }

  /* column widget to display year,country,duration*/
  Widget getMovieParams(String param1,String param2){

    return Column(children: <Widget>[
      Text(param1,style: TextStyle(color: Colors.black45,fontSize: 16),),
      Text(param2,style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),),
    ],);
  }
}



class CustomSliverAppbar extends SliverPersistentHeaderDelegate{

  final double expandedHeight;
  final String imgUrl;
  CustomSliverAppbar({@required this.expandedHeight,@required this.imgUrl});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,

        children: [

          ClipPath(

            clipper: ImageClipper(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/2,
             child:FadeInImage.assetNetwork(placeholder: 'assets/images/logo.png',
               image: AppConstants.TMDB_IMAGE_BASE_URL +imgUrl,fit: BoxFit.fill,)
            ),
          ),
          Positioned(child: Opacity(
            opacity: (1-shrinkOffset/expandedHeight),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

      IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
        Navigator.pop(context);
      },color: Colors.black,),
                Text(AppConstants.APP_TITLE,style: Theme.of(context).textTheme.title,),
      IconButton(icon: Icon(Icons.favorite_border), onPressed: (){},color: Colors.black,)
      ],
      ),
            ),
          ),top: 30,),
          Positioned(
            top: expandedHeight-shrinkOffset-40,
            left: MediaQuery.of(context).size.width / 2.5,
            child: Opacity(
              opacity: (1 - shrinkOffset / expandedHeight),
              child:playButton(),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
         boxShadow: [
        BoxShadow(
        color: Colors.grey,
        blurRadius: 100.0, // soften the shadow
        spreadRadius: 1.0, //extend the shadow
      )

        ]
      ),
    );
  }

  Widget playButton(){
    return InkWell(
      child: Container(

        width: 70,
        height: 70,
        child: Icon(Icons.play_arrow,color: Colors.red,size: 40,),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow:  [BoxShadow(
            color: Colors.grey,
            blurRadius: 100.0, // soften the shadow
            spreadRadius: 1.0, //extend the shadow
          )],
        ),
      ),
      onTap: (){},
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}