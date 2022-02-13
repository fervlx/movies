import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:movies/models/models.dart';
import 'package:movies/widgets/widgets.dart';


class Search extends SearchDelegate {

  final void Function( String ) findMovies;
  final Stream<List<Movie>> stream;


  Search( this.findMovies, this.stream );


  @override
  String? get searchFieldLabel => 'search movie';


  @override
  ThemeData appBarTheme( BuildContext context ) {
    return Theme.of( context ).copyWith(
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none
      ),//searchFieldDecorationTheme,
      textTheme: Theme.of(context).textTheme.copyWith(
        headline6: const TextStyle( color: Colors.white ),
      ),
      hintColor: Colors.white,
    );
  }


  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon( Icons.cancel_rounded ),
        onPressed: () => query = '', 
      )
    ];
  }


  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon( Icons.arrow_back ),
      onPressed: () {
        FocusScope.of( context ).unfocus();
        close( context, null );
      }, 
    );
  }


  @override
  Widget buildResults( BuildContext context ) {
    
    if ( query.isEmpty ) {
      return const SuggestionEmpty();
    }

    findMovies( query );

    return StreamBuilder(
      stream : stream,
      builder: ( _, AsyncSnapshot<List<Movie>> snapshot ) {

        if ( snapshot.connectionState == ConnectionState.waiting ) {
          return const Center( child: CupertinoActivityIndicator());
        }

        if ( !snapshot.hasData ) {
          return const SuggestionEmpty();
        }

        return ListView.builder(
          itemCount   : snapshot.data!.length,
          itemBuilder : ( _ , i ) {
            final movie = snapshot.data![ i ];
            return SuggestionItem( movie: movie, close: () {});
          }
        );
      }
    );
  }


  @override
  Widget buildSuggestions( BuildContext context ) {
    
    if ( query.isEmpty ) {
      return const SuggestionEmpty();
    }

    findMovies( query );

    return StreamBuilder(
      stream : stream,
      builder: ( _, AsyncSnapshot<List<Movie>> snapshot ) {

        if ( !snapshot.hasData ) {
          return const SuggestionEmpty();
        }

        return ListView.builder(
          itemCount   : snapshot.data!.length,
          itemBuilder : ( _ , i ) {
            final movie = snapshot.data![ i ];
            return SuggestionItem( movie: movie, close: () => close( context, null ));
          }
        );
      }
    );
  }
}