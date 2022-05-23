import 'package:flutter/material.dart';
import 'package:peliculas_app_2/models/models.dart';
import 'package:peliculas_app_2/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //TODO: Cambiar por instancia de movie
    final Movie movie = ModalRoute.of(context)?.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(
            titleBar: movie.title,
            imagePathBar: movie.fullPosterImg,
            
            ),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(
                originalTitle: movie.originalTitle,
                title: movie.title,
                voteAverage: movie.voteAverage.toString(), 
                imagePath: movie.fullPosterImg,
                ),
              _Overview(details: movie.overview),
              CastingCards() 
            ]),
          )
      
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({ Key? key, required this.titleBar, required this.imagePathBar }) : super(key: key);

  final String titleBar;
  final String imagePathBar;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      
      floating: false,
      pinned: true,
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black45,
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            titleBar,
            style: TextStyle( fontSize: 16),),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(imagePathBar),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {

  const _PosterAndTitle({ Key? key, required this.title, required this.originalTitle, required this.voteAverage, required this.imagePath }) : super(key: key);

  final String title;
  final String originalTitle;
  final String voteAverage;
  final String imagePath;

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal:20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage(imagePath),
              height: 150,
            ),
          ),
          SizedBox(width: 20,),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2,),
              Text(originalTitle, style: textTheme.subtitle1, overflow: TextOverflow.ellipsis),

              Row(
                children: [
                  Icon( Icons.star_outline, size: 15, color: Colors.grey,),
                  SizedBox(width: 5,),
                  Text(voteAverage, style: textTheme.caption,)

                ],
              )
            ],
          )

        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview({ Key? key, required this.details }) : super(key: key);
  
  final String details;

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(details,
      textAlign: TextAlign.justify,
      style: Theme.of(context).textTheme.subtitle1
      )

    );
  }
}