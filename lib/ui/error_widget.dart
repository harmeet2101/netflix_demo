import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflixdemo/bloc/bloc.dart';

class NetflixErrorWidget extends StatelessWidget{


   final String errorMsg;
   final String blocType;
   final Bloc bloc;

   NetflixErrorWidget({@required this.errorMsg,@required this.bloc,@required this.blocType});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Text(errorMsg,
          style: TextStyle(fontSize: 15,color: Colors.black),),
        RaisedButton(onPressed: (){
          bloc.refershIfNeeded(blocType);
        },child: Text('Try again',style: TextStyle(color: Colors.red,fontSize: 15),),)
      ],
    );
  }
}