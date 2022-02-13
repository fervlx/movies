import 'package:flutter/material.dart';

import 'package:movies/screens/screen.dart';


class AppRoutes {

  static const String initalRoute = 'home';

  static Map<String, Widget Function( BuildContext context )> routes = {
    'home' : ( context ) => const HomeScreen(),
    'details' : ( context ) => const DetailsScreen()
  };
}