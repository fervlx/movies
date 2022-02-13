import 'package:flutter/material.dart';
import 'package:movies/search/search.dart';
import 'package:provider/provider.dart';

import 'package:movies/providers/movies_provider.dart';
import 'package:movies/widgets/widgets.dart';


class HomeScreen extends StatefulWidget {

  const HomeScreen({ Key? key }) : super( key: key );

  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build( BuildContext context ) {

    final moviesProvider = Provider.of<MoviesProviders>( context ); 

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Movies'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon( Icons.search_outlined ),
              onPressed: () => showSearch( context: context, delegate: Search( moviesProvider.findMovies, moviesProvider.stream )), 
            )
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
    
              CardSwiper( movies: moviesProvider.nowPlayingList ),

              const SizedBox( height: 16.0 ),

              MovieSlider( 
                movies: moviesProvider.upcomingList, 
                sectionTitle: "Upcoming",
                onNextPage: () => moviesProvider.getUpcoming() 
              ),

              const SizedBox( height: 16.0 ),
              
              MovieSlider( 
                movies: moviesProvider.popularList, 
                sectionTitle: "Top Movies",
                onNextPage: () => moviesProvider.getPopular() 
              ),
            ],
          )
        )
      )
    );
  }
}