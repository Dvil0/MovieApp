import 'package:flutter/material.dart';
import 'package:movieapp/src/models/movie_model.dart';
import 'package:movieapp/src/providers/movies_provider.dart';
import 'package:movieapp/src/widgets/card_swiper_widget.dart';
import 'package:movieapp/src/widgets/movie_horizontal.dart';


class HomeView extends StatelessWidget{

  MoviesProvider moviesProvider =new MoviesProvider();

  @override
  Widget build( BuildContext context ){

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Movies'),
        backgroundColor: Colors.black87,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){},
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperCards(),
            _footer( context )
            ],
          )
        )
    );
  }

  Widget _swiperCards() {

    return FutureBuilder(
      future: moviesProvider.getCinema(),
      builder: ( BuildContext context, AsyncSnapshot<List<Movie>> snapshot){
        
        if( snapshot.hasData ){
          return CardSwiper(
          movies: snapshot.data,
          );
        }
        else{
          return Container(
            height: 400.0,
            child: Center(
                child: CircularProgressIndicator()
            )
          );
        }
        
        
      },
    );
  }

  Widget _footer( BuildContext context ) {

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'Popular', 
              style: Theme.of(context).textTheme.subhead,  
            ),
          ),
          SizedBox(height: 10.0,),
          FutureBuilder(
            future: moviesProvider.getPopular(),
            builder: ( BuildContext context, AsyncSnapshot<List<Movie>> snapshot ){

              if( snapshot.hasData ){
                return MovieHorizontal(
                  movies: snapshot.data,
                );
              }
              else{
                return Center(
                      child: CircularProgressIndicator()
                );
              }
            },
          ),
        ],
      ),
    );
  }
}