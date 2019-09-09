import 'package:flutter/material.dart';
import 'package:movieapp/src/models/movie_model.dart';

class MovieDetail extends StatelessWidget{

  

  @override
  Widget build( BuildContext context ){

    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _createAppBar( movie ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10.0,),
                _addTitle( movie, context ),
                _description( movie ),
                _description( movie ),
                _description( movie ),
              ]
            ),
          )
        ],
      )
    );
  }

  Widget _createAppBar(Movie movie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.black87,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
          overflow: TextOverflow.ellipsis, 
        ),
        background: FadeInImage(
          image: NetworkImage( movie.getBackgroundImage()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _addTitle(Movie movie, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image( 
                image: NetworkImage( movie.getPosterImg() ),
                height: 150.0,
              ),
          ),
          SizedBox(width: 20.0,),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text( 
                  movie.title,
                  style: Theme.of(context).textTheme.title, overflow: TextOverflow.ellipsis, 
                  ),
                  Text( 
                  movie.originalTitle,
                  style: Theme.of(context).textTheme.subhead, overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: <Widget>[
                      Icon( Icons.star_border),
                      Text( 
                        movie.voteAverage.toString(),
                        style: Theme.of(context).textTheme.subhead
                        )
                    ],
                  )
              ],
            ),
            )
        ],
      ),
    );
  }

  Widget _description(Movie movie) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text( 
        movie.overview,
        textAlign: TextAlign.justify,
        ),
    );

  }
}