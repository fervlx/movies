import 'dart:convert';

import '../../models/models.dart';


class VideosResponse {

  int id;
  List<Video> results;
    
  VideosResponse({ required this.id, required this.results });


  factory VideosResponse.fromJson( String str ) => VideosResponse.fromMap( json.decode( str ));


  factory VideosResponse.fromMap(Map<String, dynamic> json) => VideosResponse(
    id: json["id"],
    results: List<Video>.from(json["results"].map(( video ) => Video.fromMap( video ))),
  );
}



