import 'package:flutter/material.dart';


class SuggestionEmpty extends StatelessWidget {

  const SuggestionEmpty({Key? key}) : super(key: key);

  @override
  Widget build( BuildContext context ) {
    
    return const Center(
      child: Icon( Icons.movie_creation_outlined, color: Colors.black38, size: 100.0 ),
    );
  }
}