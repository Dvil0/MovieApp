import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:movieapp/src/models/movie_model.dart';
import 'package:movieapp/src/models/actors_model.dart';

class MoviesProvider{

  String _apiKey = '12f76d12c95f1a0b86df28eebc6f58a0';
  String _url = 'api.themoviedb.org';
  String _language = 'en-US';
  int _populars = 0;
  bool  _loading = false;
  List<Movie> _popularMovies = new List();
  final _streamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularsSink => _streamController.sink.add;

  Stream<List<Movie>> get popularsStream => _streamController.stream;


  void disposeStreams(){
    _streamController?.close();
  }

  Future<List<Movie>> getCinema() async{

    final url = Uri.https( _url, '3/movie/now_playing', {
      'api_key'   : _apiKey,
      'language'  : _language
    });

    return await _processResponse( url );
  }

  Future<List<Movie>> getPopular() async{

    if( _loading ) return [];

    _loading = true;
    _populars++;

    final url = Uri.https( _url , '3/movie/popular', {
      'api_key' : _apiKey,
      'language' : _language,
      'page'     : _populars.toString()
    });

    final resp = await  _processResponse( url );

    _popularMovies.addAll( resp );
    popularsSink( _popularMovies );
    
    _loading = false;
    
    return resp;
  }

  Future<List<Movie>> _processResponse( Uri url) async{
    
    final response = await http.get( url );
    final decodedData = json.decode( response.body );
    final movies = new Movies.fromJsonList( decodedData['results'] );

    return movies.items;
  }

  Future<List<Actor>> getCast( String idMovie ) async{

    final url = Uri.https( _url , '3/movie/$idMovie/credits', {
      'api_key'  : _apiKey,
      'language'  : _language,
    });

    final resp = await http.get( url );
    final decodedData = json.decode( resp.body );
    final actors = new Actors.fromJsonList( decodedData['cast'] );
    
    return actors.actors;
  }

  Future<List<Movie>> searchMovie( String query ) async{

    final url = Uri.https( _url , '3/search/movie', {
      'api_key'  : _apiKey,
      'language' : _language,
      'query'    : query
    } );

    return await _processResponse( url );

  }
}