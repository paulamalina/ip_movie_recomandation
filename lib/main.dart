import 'package:flutter/material.dart';
import 'package:ip_movie_recomandation/screens/ChooseScreen/choose.dart';
import 'package:ip_movie_recomandation/screens/CreateAccountScreen/register.dart';
import 'package:ip_movie_recomandation/screens/GenreScreen/genre.dart';
import 'package:ip_movie_recomandation/screens/LoginScreen/login.dart';
import 'package:ip_movie_recomandation/screens/MainScreen/main.dart';
import 'package:ip_movie_recomandation/screens/WelcomeScreen/welcome.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'RecomandationMovieApp',
      // Start the app with the "/" named route. In this case, the app starts
      // on the WelcomeScreen widget.
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const WelcomeScreen(),
        // When navigating to the "/choose" route, build the ChooseScreen widget.
        '/choose': (context) => const ChooseScreen(),
        '/login' : (context) => const LoginScreen(),
        '/register' : (context) => const RegisterScreen(),
        '/main' : (context) => const MainScreen(),
        '/genre' : (context) => const GenreScreen(),
      },
    ),
  );
}

