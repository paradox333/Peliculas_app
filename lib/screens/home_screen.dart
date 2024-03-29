import 'package:flutter/material.dart';
import 'package:peliculas_app_2/providers/movies_provider.dart';
import 'package:peliculas_app_2/search/search_delegate.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas en cines'),
        elevation: 0,
        actions: [
          IconButton(
          icon: Icon(Icons.search_outlined),
          onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate()),)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardSwiper(movies: moviesProvider.onDisplayMovie,),
            
            MoveSlider(movies: moviesProvider.popularMovies,
            title: 'Populares',
            onNextPage: () => moviesProvider.getPopularMovies(),
            ),
            ]
            
        ),
      ),
    );
  }
}