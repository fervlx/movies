import 'package:movies/repo/http/api_query.dart';

import 'package:movies/models/models.dart';
import 'package:movies/repo/responses/search_response.dart';
import 'package:movies/repo/responses/upcoming_response.dart';
import 'responses/responses.dart';


class MovieRepo {

  final ApiQuery _api = ApiQuery();

  static final MovieRepo _instance = MovieRepo._();
  factory MovieRepo() => _instance;
  MovieRepo._();

  int _popularPage  = 0;
  int _upcomingPage = 0;


  Future<List<Movie>> getNowPlayingMovies() async {

    const endpoint = '3/movie/now_playing';
    
    var json = await _api.getQuery( endpoint );
    final nowPlaying = NowPlayingResponse.fromJson( json );
    
    return Future.value( nowPlaying.results );
  }


  Future<List<Movie>> getPopularMovies() async {

    const endpoint = '/3/movie/popular';

    _popularPage++;

    var json = await _api.getQuery( endpoint, page: _popularPage );
    
    if (json.isEmpty ) {
      return [];
    }

    return PopularResponse.fromJson( json ).results;
  }


  Future<List<Movie>> getUpComing() async {

    _upcomingPage++;

    const endpoint = '3/movie/upcoming';
    String json = await _api.getQuery( endpoint, page: _upcomingPage );

    if ( json.isEmpty ) {
      return [];
    }

    return UpcomingResponse.fromRawJson( json ).results;
  }


  Future<List<Cast>> getCredits( int id ) async {

    final endpoint = '/3/movie/$id/credits';

    var json = await _api.getQuery( endpoint );
    final credits = creditResponseFromJson( json );
    
    return Future.value( credits.cast );
  }


  Future<List<Movie>> searchMovies( String query, { int page = 1 }) async {

    const endpoint = '/3/search/movie';
    final args = {
      'query' : query
    };

    String json = await _api.getQuery( endpoint, page: page, args: args );
    
    return SearchResponse.fromJson( json ).results;
  }


  Future<List<Video>> getVideos( int id ) async {

    final endpoint = '3/movie/$id/videos';

    String json = await _api.getQuery( endpoint );
    
    return VideosResponse.fromJson( json ).results;
  }
}