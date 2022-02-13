import 'package:flutter/material.dart';

import 'package:movies/models/models.dart';


class SuggestionItem extends StatelessWidget {

  final Movie movie;
  final void Function() close;
  const SuggestionItem({ Key? key, required this.movie, required this.close }) : super(key: key);


  @override
  Widget build( BuildContext context ) {

    movie.tagId = 'suggestion-${movie.id}';

    return Padding(
      padding: const EdgeInsets.symmetric( vertical: 12.0 ),
      child: ListTile(
        leading: Hero(
          tag: movie.tagId!,
          child: ClipRRect(
            borderRadius: BorderRadius.circular( 10.0 ),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage( movie.getPosterPath() ),
              width: 50,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text( movie.title, style: const TextStyle( fontWeight: FontWeight.w500 )),
        subtitle: Text( movie.overview, maxLines: 2, textAlign: TextAlign.justify ),
        onTap: () {
          close();
          Navigator.pushNamed( context, 'details', arguments: movie );
        }
      ),
    );
  }
}