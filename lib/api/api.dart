import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies_apps/model/movie_model.dart';
import 'package:http/http.dart' as http;

class Api {
  final String apiKey = dotenv.get('MOVIE_DB_APIKEY');
  final upcomingApiUrl = "https://api.themoviedb.org/3/movie/upcoming";
  final popularApiUrl = "https://api.themoviedb.org/3/movie/popular";
  final topRatedApiUrl = "https://api.themoviedb.org/3/movie/top_rated";

  Future<List<Movie>> getUpcomingMovies() async {
    final response = await http.get(Uri.parse(upcomingApiUrl), headers: {
      'Authorization': 'Bearer $apiKey'
    });

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];

      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();

      return movies;
    } else {
      throw Exception('Failed to load upcoming movies');
    }
  }

  Future<List<Movie>> getPopularMovies() async {
    final response = await http.get(Uri.parse(popularApiUrl), headers: {
      'Authorization': 'Bearer $apiKey'
    });

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];

      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();

      return movies;
    } else {
      throw Exception('Failed to load popular movies');
    }
  }

  Future<List<Movie>> getTopRatedMovies() async {
    final response = await http.get(Uri.parse(topRatedApiUrl), headers: {
      'Authorization': 'Bearer $apiKey'
    });

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];

      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();

      return movies;
    } else {
      throw Exception('Failed to load top rated movies');
    }
  }
}