import 'package:flutter/material.dart';

class CategoryHeader extends StatefulWidget{

  final String heading;

  CategoryHeader({@required this.heading});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CategoryHeaderState();
  }
}

class CategoryHeaderState extends State<CategoryHeader>{



  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Text(widget.heading,style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),),
        ),
        IconButton(icon: Icon(Icons.arrow_forward,size: 26,), onPressed: (){}),
      ],
    );
  }
}