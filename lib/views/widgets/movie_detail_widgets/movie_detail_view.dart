import 'dart:html';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:movie_app_bloc/views/widgets/movie_detail_widgets/cast_widget_loader.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../bloc/movie_detail_bloc/movie_detail_cubit.dart';
import '../../../bloc/theme_bloc/theme_controller.dart';
import '../../../services/movie_repository.dart';

class MovieDetailView extends StatefulWidget {
  MovieDetailView({
    Key? key,
    required this.movieId,
    required this.movieRepository,
    required this.themeController,
  }) : super(key: key);

  int? movieId;
  ThemeController? themeController;
  MovieRepository? movieRepository;
  @override
  _MovieDetailViewState createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => MovieDetailCubit(
          repository: context.read<MovieRepository>(),
        )..fetchMovie(widget.movieId!),
        child: DetailView(
          movieId: widget.movieId!,
          movieRepository: widget.movieRepository!,
          themeController: widget.themeController!,
        ),
      ),
    );
  }
}

class DetailView extends StatelessWidget {
  const DetailView(
      {Key? key,
      required this.movieId,
      required this.themeController,
      required this.movieRepository})
      : super(key: key);
  final ThemeController themeController;
  final MovieRepository movieRepository;
  final int movieId;

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat();
    final state = context.watch<MovieDetailCubit>().state;

    switch (state.status) {
      case ListStatus.failure:
        return const Center(
            child: Text(
          'Oops something went wrong!',
          style: TextStyle(color: Colors.white),
        ));
      case ListStatus.success:
        return ListView(padding: EdgeInsets.zero, children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Stack(
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.white,
                      highlightColor: Colors.white54,
                      child: AspectRatio(
                          aspectRatio: 3 / 2,
                          child: Container(
                              decoration: const BoxDecoration(
                            color: Colors.black12,
                          ))),
                    ),
                    AspectRatio(
                        aspectRatio: 3 / 2,
                        child: FadeInImage.memoryNetwork(
                            fit: BoxFit.cover,
                            placeholder: kTransparentImage,
                            // ignore: prefer_interpolation_to_compose_strings
                            image: "https://image.tmdb.org/t/p/original/" +
                                state.movie.backPoster)),
                  ],
                ),
                AspectRatio(
                  aspectRatio: 3 / 2,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.2),
                          Colors.black.withOpacity(1.0)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0, 1],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  left: 10.0,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Shimmer.fromColors(
                              baseColor: Colors.white10,
                              highlightColor: Colors.white30,
                              child: SizedBox(
                                height: 120.0,
                                child: AspectRatio(
                                  aspectRatio: 2 / 3,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.black12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              height: 120.0,
                              child: AspectRatio(
                                aspectRatio: 2 / 3,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: FadeInImage.memoryNetwork(
                                    placeholder: kTransparentImage,
                                    image:
                                        "https://image.tmdb.org/t/p/w200/${state.movie.poster}",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 140,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                state.movie.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Release Data : ${state.movie.releaseDate}",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w200),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    left: 5.0,
                    child: SafeArea(
                        child: IconButton(
                      icon: Icon(
                        EvaIcons.arrowIosBack,
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ))),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(EvaIcons.clockOutline, size: 15,),
                  SizedBox(width: 5,),
                  Text(getDuration(state.movie.runtime),style: TextStyle(
                    fontSize: 11.0, fontWeight: FontWeight.bold,
                  ),),
                  SizedBox(width: 10,),
                  Expanded(child: Container())

                ],

              ),
            ],

          ),)
        ]);
      default:
        return buildCastslistLoaderWidget(context);
    }
  }

  String getDuration(int minutes) {
    var d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '0')}h ${parts[1].padLeft(2, '0')}min';
  }
}