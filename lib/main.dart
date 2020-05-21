import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflixdemo/bloc/bloc_provider.dart';
import 'package:netflixdemo/bloc/app_bloc.dart';
import 'package:netflixdemo/rest/Response.dart';
import 'package:netflixdemo/rest/Status.dart';
import 'package:netflixdemo/rest/response/MovieResults.dart';
import 'package:netflixdemo/rest/response/popular.dart';
import 'package:netflixdemo/ui/error_widget.dart';
import 'package:netflixdemo/utils/AppConstants.dart';
import 'package:netflixdemo/ui/category_horiz_list.dart';
import 'package:netflixdemo/ui/details_screen.dart';
import 'package:netflixdemo/ui/category_header.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: AppBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(

          primaryColor: Colors.white,
          accentColor: Colors.red,
          textTheme: TextTheme(
            title: TextStyle(color: Colors.red,fontSize: 22,fontWeight: FontWeight.bold)
          )
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var categories=['Home','TV Shows','Movies','Latest','My List'];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(


          slivers: <Widget>[

            SliverAppBar(
              backgroundColor: Theme.of(context).primaryColor,
              leading: IconButton(icon: Icon(Icons.dehaze), onPressed: (){
              },color: Colors.black,),
              title: Center(child: Text(AppConstants.APP_TITLE,style: Theme.of(context).textTheme.title,)),
              actions: <Widget>[
                IconButton(icon: Icon(Icons.search), onPressed: (){

                },color: Colors.black,)
              ],
            ),
            SliverToBoxAdapter(child:Container(
              width: 200,
              height: 200,
              child: StreamBuilder<Response<Popular>>(builder: (context,snapshot){

                  if(snapshot.hasData){

                    switch(snapshot.data.status){

                      case Status.LOADING:
                        // TODO: Handle this case.
                            return Container(child: Center(child: CircularProgressIndicator()));
                      case Status.COMPLETED:
                        return getPopularWidgetListView(context,snapshot.data.data.results);
                        break;
                      case Status.ERROR:
                        return Center(child: NetflixErrorWidget(errorMsg: snapshot.data.message,
                            bloc: BlocProvider.of<AppBloc>(context).popularMovieBloc, blocType: 'Popular'));
                    }

                  }return Container();

              }
              ,stream: BlocProvider.of<AppBloc>(context).popularMovieBloc.popularMovieStream,))),
            SliverToBoxAdapter(child:Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Container(

                  color: Colors.white,
                  height: 80,
                  child: getCategoryWidgetListView(context)),
            )),
            SliverToBoxAdapter(child: Padding(padding: EdgeInsets.symmetric(vertical: 20),
              child:Column(
                  children: <Widget>[
                    CategoryHeader(heading: 'My List',),
                    StreamBuilder<Response<Popular>>(builder: (context,snapshot){

                      if(snapshot.hasData){

                        switch(snapshot.data.status){

                          case Status.LOADING:
                          // TODO: Handle this case.
                            return Container(child: Center(child: CircularProgressIndicator()));
                          case Status.COMPLETED:
                            return CategoryHorizontalList(itemSize: Size(200, 230),
                              results: snapshot.data.data.results,);
                            break;
                          case Status.ERROR:
                            return Center(child:NetflixErrorWidget(errorMsg: snapshot.data.message,
                                bloc: BlocProvider.of<AppBloc>(context).topRatedMovieBloc, blocType: 'Top Rated'));
                        }

                      }return Container();

                    }
                      ,stream: BlocProvider.of<AppBloc>(context).topRatedMovieBloc.topRatedMovieStream,),
    ],
    ))
              ,),
            SliverToBoxAdapter(child: Padding(padding: EdgeInsets.symmetric(vertical: 20),
              child:Column(
            children: <Widget>[
              CategoryHeader(heading: 'Popular on Netflix',),
              StreamBuilder<Response<Popular>>(builder: (context,snapshot){

                if(snapshot.hasData){

                  switch(snapshot.data.status){

                    case Status.LOADING:
                    // TODO: Handle this case.
                      return Container(child: Center(child: CircularProgressIndicator()));
                    case Status.COMPLETED:
                      return CategoryHorizontalList(itemSize: Size(200, 230),
                        results: snapshot.data.data.results,);
                      break;
                    case Status.ERROR:
                      return Center(child: NetflixErrorWidget(errorMsg: snapshot.data.message,
                          bloc: BlocProvider.of<AppBloc>(context).upcomingMoviesBloc, blocType: 'Upcoming'));
                  }

                }return Container();

              }
                ,stream: BlocProvider.of<AppBloc>(context).upcomingMoviesBloc.upcomingMovieStream,)
    ],
    )),

              )

          ],
        ),

    );
  }


  Widget getPopularWidgetListView(BuildContext context,List<MovieResults> _results){
    return ListView.builder(itemBuilder: (context,index)=>Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen(movieId: _results[index].id,)));
          },
          child: Container(

            width: MediaQuery.of(context).size.width/1.5,

            child: ClipRRect(child:Stack(

              children: <Widget>[
                Container(
                  width: double.maxFinite,
                  child: Image.network(AppConstants.TMDB_IMAGE_BASE_URL +
                      _results[index].poster_path,fit: BoxFit.fill,),
                ),
                Positioned(child: Text(_results[index].title,style: TextStyle(fontSize: 22,
                    fontWeight:FontWeight.w500,color: Colors.white),
                  maxLines: 2,softWrap: true,),
                  bottom: 8.0,left: 8.0,)
              ],
            ),
              borderRadius: BorderRadius.circular(10.0),),
          ),
        ),
      ),
    ),itemCount: _results.length,scrollDirection: Axis.horizontal,);
  }

  Widget getCategoryWidgetListView(BuildContext context){
    return ListView.builder(itemBuilder: (context,index)=>Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Material(
        color: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),

        elevation: 10,
        child: InkWell(
          child: Container(
            width: 200,
            child:ClipRRect(child:Container(child:
            Center(child: Text(categories[index],style: TextStyle(color: Colors.white,fontSize: 16),))),
              borderRadius: BorderRadius.circular(10.0),),
          ),
          onTap: (){},

        ),
      ),
    ),
      itemCount: categories.length ,scrollDirection: Axis.horizontal,);
  }

}

