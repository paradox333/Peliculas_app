

import 'package:flutter/material.dart';
import 'package:peliculas_app_2/providers/movies_provider.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class MovieSearchDelegate extends SearchDelegate{
  
  @override
  // TODO: implement searchFieldLabel
  String? get searchFieldLabel => 'Buscar';

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
        )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: (){
      close(context, null);
    }, 
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Text('buildResults');
  }

  Widget _emptyContainer(){
    return Center(
          child: Icon(Icons.movie_creation_outlined, color: Colors.black38, size: 130,),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    
    if( query.isEmpty ){
      return _emptyContainer();
      }

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    moviesProvider.getSuggestionsByQuery(query);


    return StreamBuilder(
      stream: moviesProvider.suggestionStream,
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {

        if(!snapshot.hasData) return _emptyContainer();
        
        final movies = snapshot.data!;

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (_, int index) => _MovieItem( movies[index])
          );
      },
    );
  }

}

class _MovieItem extends StatelessWidget {
  const _MovieItem(this.movie);

  final Movie movie;

  @override
  Widget build(BuildContext context) {

    movie.heroId = 'search-${ movie.id }';

    return Hero(
      tag: movie.heroId!,
      child: ListTile(
       leading: FadeInImage(
         placeholder: AssetImage('assets/no-image.jpg'),
         image: NetworkImage(movie.fullPosterImg),
         width: 50,
         fit: BoxFit.contain,
       ),
       title: Text(movie.title),
       subtitle: Text( movie.originalTitle),
       onTap: (){
         Navigator.pushNamed(context, 'details', arguments: movie); 
       },
      ),
    );
  }
}