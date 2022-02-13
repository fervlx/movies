// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:movies/models/models.dart';
import 'package:movies/theme/app_theme.dart';
import 'package:movies/widgets/videos_card.dart';
import 'package:movies/widgets/widgets.dart';


class DetailsScreen extends StatefulWidget {

  const DetailsScreen({ Key? key }) : super( key: key );

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}


class _DetailsScreenState extends State<DetailsScreen> {


  @override
  Widget build( BuildContext context ) {

    final Movie movie = ModalRoute.of( context )!.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        slivers:  [
          _CustomAppBar( title: movie.title, backdropPath: movie.getBackdropPath() ),
          
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox( height: 8.0 ),
              _Poster( movie: movie ),
              SizedBox( height: 16.0 ),
              _Overview( description: movie.overview ),
              SizedBox( height: 16.0 ),
              VideosCard( videoId: movie.id),
              SizedBox( height: 16.0 ),
              CastingCards( movie.id )
            ])
          )
        ],
      ),
      // appBar: AppBar(
      //   title: const Text('Details'),
      // ),
      // body: Center( child: Text(movie) ),
    );
  }
}



class _CustomAppBar extends StatelessWidget {

  final String title;
  final String backdropPath;

  const _CustomAppBar({ Key? key, required this.title, required this.backdropPath }) : super( key: key );
  

  @override
  Widget build( BuildContext context ) {

    return SliverAppBar(
      backgroundColor: AppTheme.primary,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          padding: const EdgeInsets.only( bottom: 16.0 ),
          child: Text( title, textAlign: TextAlign.center,
            style: TextStyle( fontSize: 16.0 ),
          ),
        ),
        background: FadeInImage( 
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage( backdropPath ),
          imageErrorBuilder: ( context, _, stack ) => Center( child: Text('Image not found', style: TextStyle( color: Colors.white ))),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}


class _Poster extends StatelessWidget {

  final Movie movie;
  const _Poster({ Key? key, required this.movie }) : super( key: key );


  @override
  Widget build( BuildContext context ) {
    
    return Container(
      margin: EdgeInsets.only( top: 20.0 ),
      padding: EdgeInsets.symmetric( horizontal: 16.0 ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Hero(
            tag: movie.tagId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: FadeInImage(
                placeholder: AssetImage( 'assets/no-image.jpg'),
                image: NetworkImage( movie.getPosterPath() ),
                height: 150.0,
              ),
            ),
          ),

          SizedBox( width: 20.0 ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text( movie.title, overflow: TextOverflow.ellipsis, maxLines: 2, style: Theme.of( context ).textTheme.headline5 ),
                Text( movie.originalTitle, overflow: TextOverflow.ellipsis, maxLines: 2, style: Theme.of( context ).textTheme.subtitle1 ),
          
                Row(
                  children: [
                    Icon( Icons.star_outline, size: 15, color: Colors.yellow[900] ),
                    SizedBox( width: 4 ),
                    Text( '${movie.voteAverage}', style: TextStyle( color: Colors.yellow[900], fontSize: 13.0 ))
                  ],
                )
              ],
            ),
          )
        ]
      ),
    );
  }
}


class _Overview extends StatelessWidget {

  final String description;

  const _Overview({ Key? key, required this.description }) : super( key: key );

  @override
  Widget build( BuildContext context ) {
    
    return Container(
      padding: const EdgeInsets.symmetric( horizontal: 16.0, vertical: 16.0 ),
      child: Text( description,
        textAlign: TextAlign.justify,
        style: AppTheme.textTheme( context ).subtitle1
      ),
    );
  }
}


class _Videos extends StatelessWidget {

  const _Videos({ Key? key }) : super( key: key );

  @override
  Widget build( BuildContext context ) {
    return Container();
  }
}