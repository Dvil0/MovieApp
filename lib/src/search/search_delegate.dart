import 'package:flutter/material.dart';
import 'package:movieapp/src/models/movie_model.dart';
import 'package:movieapp/src/providers/movies_provider.dart';

class DataSearch extends SearchDelegate{

  String selected = '';
  final moviesProvider = new MoviesProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    //Acciones del appBar.
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //Icono a la izquierda del appBar.
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //Crea los resultados a mostrar.
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.black87,
        child: Text(selected),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Sugerencias cuando se escribe.


    if( query.isEmpty ) return Container();

    return FutureBuilder(
      future: moviesProvider.searchMovie( query ),
      builder: ( BuildContext context, AsyncSnapshot<List<Movie>> snapshot ){

        if(snapshot.hasData){

          final movies = snapshot.data;

          return ListView(
            children: movies.map( (movie){
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage( movie.getPosterImg() ),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                ),
                title: Text( movie.title ),
                subtitle: Text( movie.originalTitle ),
                onTap: (){
                  close( context, null);
                  movie.uniqueId = '';
                  Navigator.pushNamed(context, 'detail', arguments: movie);
                },
              );
            }).toList(),
          );
        }
        else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }


}