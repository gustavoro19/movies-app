import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:movies/src/models/movie_model.dart';



class MoviesProvider {

  String _apikey   = 'd604b73d6a8f4b7329b049e6360127c4';
  String _url      = 'api.themoviedb.org';
  String _language = 'en-EN';

  Future<List<Movie>> _processRespond(Uri url ) async {
 
    final resp = await http.get( url );
    final decodedData = json.decode(resp.body);

    final movies = new Movies.fromJsonList(decodedData['results']);


    return movies.items;

  }


  Future<List< Movie >> getNowPlaying() async {

    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key'   : _apikey,
      'language'  : _language
    } );  

    return await _processRespond(url);

  }

   Future<List< Movie >> getPopular() async {
   
   
   final url = Uri.https(_url, '3/movie/popular', {
      'api_key'   : _apikey,
      'language'  : _language
    } );
  
    return await _processRespond(url);


   
   }

}