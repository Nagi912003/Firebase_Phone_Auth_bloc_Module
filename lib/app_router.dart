import 'package:flutter/material.dart';

import 'package:maps_firebase_sqflite_bloc/presentation/screens/login_screen.dart';

import 'constants/strings.dart';

class AppRouter{

  static Route? generateRoute(RouteSettings settings){
    switch(settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case loginScreen:
          return MaterialPageRoute(builder: (_) => LoginScreen());
      default:
        return null;
    }
  }
}