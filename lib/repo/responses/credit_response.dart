import 'dart:convert';

import 'package:movies/models/models.dart';


CreditResponse creditResponseFromJson( String str ) => CreditResponse.fromJson( json.decode( str ));


class CreditResponse {
   
  int id;
  List<Cast> cast;
  List<Cast> crew;

  CreditResponse({ required this.id, required this.cast, required this.crew });


  factory CreditResponse.fromJson(Map<String, dynamic> json) => CreditResponse(
    id: json["id"],
    cast: List<Cast>.from( json["cast"].map(( x ) => Cast.fromJson( x ))),
    crew: List<Cast>.from( json["crew"].map(( x ) => Cast.fromJson( x ))),
  );
}
