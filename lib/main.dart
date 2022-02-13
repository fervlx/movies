import 'package:flutter/material.dart';
import 'package:movies/providers/movies_provider.dart';

import 'package:movies/routes/app_routes.dart';
import 'package:movies/theme/app_theme.dart';
import 'package:provider/provider.dart';


void main() {
  runApp( const AppState() );
}


class AppState extends StatelessWidget {

  const AppState({ Key? key }) : super( key: key );


  @override
  Widget build( BuildContext context ) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create: ( _ ) => MoviesProviders(), lazy: false )
      ],
      child: const MyApp(),
    );
  }
}


class MyApp extends StatelessWidget {

  const MyApp({ Key? key }) : super( key: key );

  @override
  Widget build( BuildContext context)  {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies',
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.initalRoute,
      routes: AppRoutes.routes,
    );
  }
}