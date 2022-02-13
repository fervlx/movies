import 'dart:convert';


class Movie {

  int id;
  int voteCount;
  String title;
  String overview;
  String originalTitle;
  String originalLanguage;
  bool video;
  bool adult;
  double popularity;
  double voteAverage;
  List<int> genreIds;
  String? backdropPath;
  String? posterPath;
  String? releaseDate;
  String? tagId;
  
  Movie({
    required this.adult,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    this.backdropPath,
    this.posterPath,
    this.releaseDate,
  });


  factory Movie.fromJson( String str ) => Movie.fromMap( json.decode( str ));


  factory Movie.fromMap(Map<String, dynamic> json) => Movie(
      adult: json["adult"],
      backdropPath: json["backdrop_path"],
      genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
      id: json["id"],
      originalLanguage: json["original_language"],
      originalTitle: json["original_title"],
      overview: json["overview"],
      popularity: json["popularity"].toDouble(),
      posterPath: json["poster_path"],
      releaseDate: json["release_date"],
      title: json["title"],
      video: json["video"],
      voteAverage: json["vote_average"].toDouble(),
      voteCount: json["vote_count"],
  );


  String getPosterPath() {

    return posterPath != null  
      ? 'https://image.tmdb.org/t/p/w500$posterPath'
      : 'https://i.stack.imgur.com/GNhxO.png';
  }


  String getBackdropPath() {

    return posterPath != null  
      ? 'https://image.tmdb.org/t/p/w500$backdropPath'
      : 'https://i.stack.imgur.com/GNhxO.png';
  } 
}