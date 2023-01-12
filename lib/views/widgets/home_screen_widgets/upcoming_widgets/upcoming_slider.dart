import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app_bloc/bloc/upcoming_bloc/upcoming_bloc_cubit.dart';
import 'package:movie_app_bloc/services/movie_repository.dart';
import 'package:movie_app_bloc/views/widgets/home_screen_widgets/upcoming_widgets/upcoming_loader.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';

class UpcomingSlider extends StatefulWidget {
  const UpcomingSlider({Key? key}) : super(key: key);

  @override
  _UpcomingSliderState createState() => _UpcomingSliderState();
}

class _UpcomingSliderState extends State<UpcomingSlider> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpcomingBlocCubit(
        repository: context.read<MovieRepository>(),
      )..fetchUpComing(),
      child: const UpcomingView(),
    );
  }
}

class UpcomingView extends StatelessWidget {
  const UpcomingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<UpcomingBlocCubit>().state;
    switch (state.status) {
      case ListStatus.failure:
        return const Center(child: Text("Oops something went wrong!"));
      case ListStatus.success:
        return Stack(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: false,
                viewportFraction: 1.0,
                aspectRatio: 2 / 2.8,
                enlargeCenterPage: true,
              ),
              items: state.movies
                  .map(
                    (movie) => Stack(
                      children: [
                        Stack(
                          children: [
                            Shimmer.fromColors(
                              baseColor: Colors.black87,
                              highlightColor: Colors.white54,
                              enabled: true,
                              child: const FaIcon(FontAwesomeIcons.film),
                            ),
                            AspectRatio(
                                aspectRatio: 2 / 2.8,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: FadeInImage.memoryNetwork(
                                    fit: BoxFit.cover,
                                    alignment: Alignment.bottomCenter,
                                    placeholder: kTransparentImage,
                                    image:
                                        "https://image.tmdb.org/t/p/original/${movie.poster}",
                                  ),
                                )),
                          ],
                        ),
                        AspectRatio(
                          aspectRatio: 2 / 2.8,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  stops: const [
                                    0.0,
                                    0.4,
                                    0.4,
                                    1.0
                                  ],
                                  colors: [
                                    Colors.black.withOpacity(1.0),
                                    Colors.black.withOpacity(0.0),
                                    Colors.black.withOpacity(0.0),
                                    Colors.black.withOpacity(0.7),
                                  ]),
                            ),
                          ),
                        ),
                        Positioned(
                            top: 5.0,
                            right: 10.0,
                            child: SafeArea(
                              child: Column(
                                children: [
                                  const Text(
                                    "Release date: ",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  Text(
                                    movie.releaseDate,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  )
                  .toList(),
            ),
            Positioned(
                left: 10.0,
                top: 10.0,
                child: SafeArea(
                  child: Text(
                    "Upcoming movies",
                    style: TextStyle(
                        fontFamily: 'NunitoBold',
                        fontSize: 18.0,
                        color: Colors.white.withOpacity(0.5)),
                  ),
                )),
          ],
        );
      default:
        return buildLoadingCampaignsWidget(context);
    }
  }
}
