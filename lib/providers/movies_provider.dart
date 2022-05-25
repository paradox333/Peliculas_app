import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_app_2/helpers/debouncer.dart';
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

  final debouncer = Debouncer(
    duration: Duration(milliseconds: 500),
    );

  final StreamController<List<Movie>> _suggestionSreamController = new StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream => this._suggestionSreamController.stream;
 

  MoviesProvider(){
    print('inicializado');

    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  Future<String> _getJasonData(String endpoint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, endpoint, {
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

  Future <List<Movie>>searchMovie(String query) async {

    final url = Uri.https(_baseUrl, '3/search/movie', {
        "api_key": _apiKey,
        "language": _language,
        'query': query
        });
    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);

    return searchResponse.results;
  }

  void getSuggestionsByQuery(String searchTerm){

    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await this.searchMovie(value);
      this._suggestionSreamController.add(results);
    }; 

    final timer = Timer.periodic(Duration(milliseconds: 300), (_) { 
      debouncer.value = searchTerm;
    });

    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());


  }
}