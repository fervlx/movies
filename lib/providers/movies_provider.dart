import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movies/helper/debouncer.dart';
import 'package:movies/repo/movies_repo.dart';
import 'package:movies/models/models.dart';
import 'package:movies/repo/responses/video_response.dart';


class MoviesProviders extends ChangeNotifier {

  final MovieRepo _repo = MovieRepo();
  final Map<int,List<Cast>> _credits = {};
  final Map<int,List<Video>> _videos = {};
  final List<Movie> _nowPlaying = [];
  final List<Movie> _popularMovies  = [];
  final List<Movie> _upcomingMovies = [];

  final StreamController<List<Movie>> _controller = StreamController.broadcast();
  Stream<List<Movie>> get stream => _controller.stream;
  void Function( List<Movie> ) get _addMovies => _controller.sink.add;


  Debouncer debouncer = Debouncer( 
    duration : const Duration( milliseconds: 500 ),
    //onValue  : 
  );


  List<Movie> get nowPlayingList => _nowPlaying;
  List<Movie> get popularList => _popularMovies;
  List<Movie> get upcomingList => _upcomingMovies;
  Map<int,List<Cast>> get credits => _credits;
  Map<int,List<Video>> get videos => _videos;

  MoviesProviders() {
    getNowPlaying();
    getPopular();
    getUpcoming();
  }


  void getNowPlaying() async {
    _nowPlaying.addAll( await _repo.getNowPlayingMovies() );
    notifyListeners();
  }


  void getPopular() async {
    _popularMovies.addAll( await _repo.getPopularMovies() );
    notifyListeners();
  }


  void getUpcoming() async {
    _upcomingMovies.addAll( await _repo.getUpComing() );
    notifyListeners();
  }


  Future<List<Cast>> getCredits( int id ) async { 
    
    if ( _credits.containsKey( id )) {
      return Future.value( _credits[id]! );
    }

    List<Cast> credits = await _repo.getCredits( id );
    
    _credits[id] = credits;

    return Future.value( credits );  
  }


  Future<List<Video>> getVideos( int id ) async {

    if ( _videos.containsKey( id )) {
      return Future.value( _videos[id] );
    }

    List<Video> videos = await _repo.getVideos( id );
    _videos[id] = videos;

    return Future.value( videos );
  }


  Future<List<Movie>> searchMovies( String query ) async => await _repo.searchMovies(query);


  void _findMovies( dynamic query ) async {
    
    if (( query as String ).isNotEmpty ) {
      final results = await searchMovies( query );
      _addMovies( results );
    }
  }


  void findMovies( String query ) {

    debouncer.value = query;
    debouncer.onValue = _findMovies;

    // final timer = Timer.periodic( const Duration( milliseconds: 300 ), ( timer ) {
    //   print( timer.tick );
    //   print('timer executed');
    // });

    // Future.delayed( const Duration( milliseconds: 301 )).then(( _ ) => timer.cancel() );

  }
}