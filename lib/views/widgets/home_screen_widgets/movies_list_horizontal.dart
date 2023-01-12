import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:movie_app_bloc/bloc/theme_bloc/theme_controller.dart';
import 'package:movie_app_bloc/models/movie.dart';
import 'package:movie_app_bloc/models/movie_detail.dart';
import 'package:movie_app_bloc/services/movie_repository.dart';
import 'package:movie_app_bloc/views/pages/movie_detail_screen/movie_detail_screen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';

class MoviesListHorizontal extends StatefulWidget {
  MoviesListHorizontal({
    Key? key,
    required this.themeController,
    required this.movieRepository,
    required this.movies,
  }) : super(key: key);

  final MovieRepository? movieRepository;
  ThemeController? themeController;
  final List<Movie>? movies;

  @override
  _MoviesListHorizontalState createState() => _MoviesListHorizontalState();
}

class _MoviesListHorizontalState extends State<MoviesListHorizontal> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.movies?.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 8),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailScreen(
                        movieId: widget.movies![index].id,
                        movieRepository: widget.movieRepository!,
                        themeController: widget.themeController!,
                      ),
                    ));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    child: Stack(children: [
                      Shimmer.fromColors(
                        baseColor: Colors.black87,
                        highlightColor: Colors.white54,
                        child: const SizedBox(
                          height: 160.0,
                          child: AspectRatio(
                              aspectRatio: 2 / 3,
                              child: Icon(
                                FontAwesome5.film,
                                color: Colors.black26,
                                size: 40.0,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 160,
                        child: AspectRatio(
                          aspectRatio: 2 / 3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                fit: BoxFit.cover,
                                image: "https://image.tmdb.org/t/p/w300/" +
                                    widget.movies![index].poster),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
