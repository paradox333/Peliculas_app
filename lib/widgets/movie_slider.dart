import 'package:flutter/material.dart';
import 'package:peliculas_app_2/models/models.dart';
import 'package:peliculas_app_2/providers/movies_provider.dart';

class MoveSlider extends StatefulWidget {
  const MoveSlider({ Key? key, required this.movies, this.title, required this.onNextPage, }) : super(key: key);

  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  @override
  State<MoveSlider> createState() => _MoveSliderState();
}

class _MoveSliderState extends State<MoveSlider> {

final ScrollController scrollController = new ScrollController();

@override
  void initState() {
    // TODO: implement initState
    super.initState();

    scrollController.addListener(() {
      
      if(scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500){
      widget.onNextPage();
      }

    });
  }

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(this.widget.title != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(this.widget.title!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              ),
            
          SizedBox(height: 5,),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: (_, int index) => _MoviePoster( widget.movies[index], '${ widget.title }-${widget.movies[index].id}')                
              ),
          )           
          
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {

const _MoviePoster(this.movie, this.heroId);

final Movie movie;
final String heroId;


  @override
  Widget build(BuildContext context) {

    movie.heroId = heroId;

    return Container(
      width: 130,
      height: 190,
      margin: EdgeInsets.symmetric(horizontal: 10,),
      child: Column(
        children: [

          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: movie ),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'), 
                  image: NetworkImage(movie.fullPosterImg),
                  width: 130,
                  height: 190,
                  fit: BoxFit.cover,
                  ),
              ),
            ),
          ),

          SizedBox(height: 5),

          Text(movie.title,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}