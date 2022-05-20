import 'package:flutter/material.dart';
import 'package:peliculas_app_2/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //TODO: Cambiar por instancia de movie
    final String movie = ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(),
              _Overview(),
              _Overview(),
              _Overview(),
              CastingCards() 
            ]),
          )
      
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({ Key? key }) : super(key: key);

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
            'move-title',
            style: TextStyle( fontSize: 16),),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage('https://via.placeholder.com/500x300'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {

  const _PosterAndTitle({ Key? key }) : super(key: key);

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
              image: NetworkImage('https://via.placeholder.com/200x300'),
              height: 150,
            ),
          ),
          SizedBox(width: 20,),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('movie.title', style: textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2,),
              Text('movie.originalTitle', style: textTheme.subtitle1, overflow: TextOverflow.ellipsis),

              Row(
                children: [
                  Icon( Icons.star_outline, size: 15, color: Colors.grey,),
                  SizedBox(width: 5,),
                  Text('movie.voteAverage', style: textTheme.caption,)

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
  const _Overview({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text('Esanim aliqua voluptate ad tempor magna proident. Fugiat non aliqua cillum veniam sunt ipsum sit Lorem. Mollit officia irure quis exercitation minim veniam enim nisi ex officia exercitation et deserunt. Veniam nostrud nulla quis officia.',
      textAlign: TextAlign.justify,
      style: Theme.of(context).textTheme.subtitle1
      )

    );
  }
}