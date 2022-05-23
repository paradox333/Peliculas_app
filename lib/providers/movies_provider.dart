import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_app_2/models/models.dart';
import 'package:peliculas_app_2/models/populard_response.dart';


class MoviesProvider extends ChangeNotifier{

  String _apiKey = 'b853f5daeaefb4f29a803dddcbec84ad';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';

  List<Movie> onDisplayMovie = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;
 

  MoviesProvider(){
    print('inicializado');

    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  Future<String> _getJasonData(String endpoint, [int page = 1]) async {
    var url = Uri.https(_baseUrl, endpoint, {
        "api_key": _apiKey,
        "language": _language,
        "page": '$page'
        });

  // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    

    final _getJasonData = await this._getJasonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(_getJasonData);

    onDisplayMovie = nowPlayingResponse.results;

    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;

    final _getJasonData = await this._getJasonData('3/movie/popular', _popularPage);

    final popularResponse = PopularResponse.fromJson(_getJasonData);

    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId ) async {

    if( moviesCast.containsKey(movieId) ) return moviesCast[movieId]!;

    final jsonData = await this._getJasonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);
    moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }
}