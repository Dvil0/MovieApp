import 'package:movieapp/src/models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MoviesProvider{
  String _apiKey = '12f76d12c95f1a0b86df28eebc6f58a0';
  String _url = 'api.themoviedb.org';
  String _language = 'en-US';

  Future<List<Movie>> getCinema() async{

    final url = Uri.https( _url, '3/movie/now_playing', {
      'api_key'   : _apiKey,
      'language'  : _language
    });

    return await _processResponse( url );
  }

  Future<List<Movie>> getPopular() async{

    final url = Uri.https( _url , '3/movie/popular', {
      'api_key' : _apiKey,
      'language' : _language
    });

    return await _processResponse( url );
  }

  Future<List<Movie>> _processResponse( Uri url) async{
    
    final response = await http.get( url );
    final decodedData = json.decode( response.body );
    final movies = new Movies.fromJsonList( decodedData['results'] );

    return movies.items;
  }
}