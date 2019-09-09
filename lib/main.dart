import 'package:flutter/material.dart';
import 'package:movieapp/src/views/home_view.dart';
import 'package:movieapp/src/views/movie_detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build( BuildContext context ){

    return MaterialApp(
      title: 'MovieApp',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/'       : ( BuildContext context ) => HomeView(),
        'detail'  : ( BuildContext context ) => MovieDetail(),
      },
    );
  }
}