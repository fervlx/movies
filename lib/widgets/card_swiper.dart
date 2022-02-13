import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:card_swiper/card_swiper.dart';


import 'package:movies/models/models.dart';


class CardSwiper extends StatelessWidget {

  final List<Movie> movies;

  const CardSwiper({ Key? key, required this.movies }) : super( key: key );


  @override
  Widget build( BuildContext context ) {

    final size = MediaQuery.of( context ).size;

    if ( movies.isEmpty ) {
      return Container(
        margin: const EdgeInsets.only( top: 16.0 ),
        width: size.width * .6,
        height: size.height * .5,
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular( 20.0 )
        // ),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            // width:  size.width * .3,
            // height: size.height * .3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular( 20.0 ),
              color: Colors.grey[300]
            ),
          )
        ),
      );
    }


    return Container(
      width: double.infinity,
      height: size.height * .5,
      margin: const EdgeInsets.only( top: 16.0 ),
      child: Swiper(
        itemCount: movies.length,
        //layout: SwiperLayout.TINDER,
        //itemWidth: size.width * .6,
        //itemHeight: size.height * .45,
        viewportFraction: 0.6,
        scale: 0.6,
        itemBuilder: ( _ , i ) {

          final movie = movies[i];
          movie.tagId = 'card-${movie.id}';

          return GestureDetector(
            onTap: () => Navigator.pushNamed( context, 'details', arguments: movie ),
            child: Hero(
              tag: movie.tagId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular( 20.0 ),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'), 
                  image: NetworkImage( movie.getPosterPath() ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}