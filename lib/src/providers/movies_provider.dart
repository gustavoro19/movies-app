import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

import 'package:movies/src/models/cast_model.dart';
import 'package:movies/src/models/movie_model.dart';
// import 'package:flutter/material.dart';


class MoviesProvider {

  String _apikey   = 'd604b73d6a8f4b7329b049e6360127c4';
  String _url      = 'api.themoviedb.org';
  String _language = 'en-EN';

  int _popularPage = 0;
  bool _loading = false;

  List<Movie> _populars = new List();

  final _popularsStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularsSink => _popularsStreamController.sink.add; 

  Stream<List<Movie>> get popularsStream => _popularsStreamController.stream;

  void disposeStreams() {
    _popularsStreamController?.close();
  }

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

    if( _loading ) return [];

    _loading = true;

    _popularPage++;
   
   
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key'   : _apikey,
      'language'  : _language,
      'page'      : _popularPage.toString()
    } );
  
    final resp = await _processRespond(url);
 
    _populars.addAll(resp);
    popularsSink(_populars);

    _loading = false;
    return resp;

   
  }

  Future<List<Cast>> getCast( String movId ) async {

    final url = Uri.https(_url, '3/movie/$movId/credits', {
      'api_key'   : _apikey,
      'language'  : _language
    });

    final resp = await http.get(url);
    final decodedData = json.decode( resp.body );

    final movieCast = new MovieCast.fromJsonList( decodedData['cast'] );

    return movieCast.cast;

  }

  Future<List< Movie >> searchMovie( String query ) async {

    final url = Uri.https(_url, '3/search/movie', {
      'api_key'   : _apikey,
      'language'  : _language,
      'query'     : query
    } );  

    return await _processRespond(url);

  }

}