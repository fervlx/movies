
import 'package:http/http.dart' as http;


class ApiQuery {


  final String _baseUrl  = 'api.themoviedb.org';
  final String _apiKey   = '';
  final String _language = 'es-ES';


  Future<String> getQuery( String endpoint, { int page = 1, Map<String,String>? args }) async {

    Map<String,String> params = { 
      'api_key'  : _apiKey,
      'language' : _language,
      'page'     : '$page'
    };

    if ( args != null ) {
      for (var key in args.keys) { 
        params[key] = args[key]!;
      }
    }

    var url = Uri.https( _baseUrl, endpoint, params );


    var response = await http.get( url );
    return response.body;
  }
}