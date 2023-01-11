import 'package:dio/dio.dart';

import '../models/movie_response.dart';

class MovieRepository {
  final String apiKey = "bc147b55e819c6794234abc51e4c883f";
  static String mainUrl = "https://api.themoviedb.org/3";
  final Dio _dio = Dio();

  var getUpComingApi = '$mainUrl/movie/upcoming';
  var getPopularMoviesApi = '$mainUrl/movie/popular';
  var getTopRatedMoviesApi = '$mainUrl/movie/top_rated';
  var getNowPlayingMoviesApi = '$mainUrl/movie/now_playing';

  var getMoviesApi = '$mainUrl/movie/top_rated';
  var getMoviesUrl = '$mainUrl/discover/movie';
  var getPlayingUrl = '$mainUrl/movie/now_playing';
  var getGenresUrl = "$mainUrl/genre/movie/list";
  var getPersonsUrl = "$mainUrl/trending/person/week";
  var movieUrl = "$mainUrl/movie";

  Future<MovieResponse> getUpcomingMovies() async {
    var params = {"api_key": apiKey, "language": "en-US", "page": 1};
    try {
      Response response =
          await _dio.get(getUpComingApi, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      return MovieResponse.withError("Error: $error, StackTrace: $stacktrace");
    }
  }
}
