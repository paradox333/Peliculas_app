import 'package:flutter/material.dart';

class MoviesProvider extends ChangeNotifier{

  MoviesProvider(){
    print('inicializado');
    this.getOnDisplayMovies();
  }

  getOnDisplayMovies(){
    print('getOnDisplayMovies');
  }
}