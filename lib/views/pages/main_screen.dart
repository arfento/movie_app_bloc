import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app_bloc/bloc/bottom_navbar_bloc.dart';
import 'package:movie_app_bloc/views/pages/movies_list.dart';

import '../../bloc/theme_bloc/theme_controller.dart';
import '../../services/movie_repository.dart';
import 'home_screen/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen(
      {Key? key, required this.themeController, required this.movieRepository})
      : super(key: key);

  final ThemeController? themeController;
  final MovieRepository? movieRepository;

  @override
  State<MainScreen> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  final BottomNavbarBloc _bottomNavBarBloc = BottomNavbarBloc();
  late bool isDarkMode;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _bottomNavBarBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isDarkMode = widget.themeController?.themeMode == ThemeMode.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        // For Android.
        // Use [light] for white status bar and [dark] for black status bar.
        statusBarIconBrightness: Brightness.light,
        // For iOS.
        // Use [dark] for white status bar and [light] for black status bar.
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: StreamBuilder<NavBarItem>(
          stream: _bottomNavBarBloc.itemStream,
          initialData: _bottomNavBarBloc.defaultItems,
          builder: (context, snapshot) {
            switch (snapshot.data) {
              case NavBarItem.home:
                return HomeScreen(
                    movieRepository: widget.movieRepository,
                    themeController: widget.themeController);
              case NavBarItem.genres:
                return Container();
              case NavBarItem.profile:
                return Container();
              case NavBarItem.search:
                return Container();
              case NavBarItem.list:
                return MoviesList();
              default:
                return Container();
            }
          },
        ),
        bottomNavigationBar: StreamBuilder(
          initialData: _bottomNavBarBloc.defaultItems,
          stream: _bottomNavBarBloc.itemStream,
          builder: (context, snapshot) {
            return Container(
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          width: 0.5, color: Colors.grey.withOpacity(0.4)))),
              child: BottomNavigationBar(
                elevation: 0.9,
                iconSize: 21,
                unselectedFontSize: 10.0,
                selectedFontSize: 10.0,
                type: BottomNavigationBarType.fixed,
                currentIndex: snapshot.data!.index,
                onTap: _bottomNavBarBloc.pickItem,
                items: [
                  BottomNavigationBarItem(
                    label: "Home",
                    icon: SizedBox(
                      child: SvgPicture.asset(
                        "assets/icons/home.svg",
                        color: Colors.grey.shade700,
                        height: 25.0,
                        width: 25.0,
                      ),
                    ),
                    activeIcon: SizedBox(
                      child: SvgPicture.asset(
                        "assets/icons/home-active.svg",
                        color: Colors.white,
                        height: 25.0,
                        width: 25.0,
                      ),
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: "Genres",
                    icon: SvgPicture.asset(
                      "assets/icons/layers.svg",
                      color: Colors.grey.shade700,
                      height: 25.0,
                      width: 25.0,
                    ),
                    activeIcon: SizedBox(
                      child: SvgPicture.asset(
                        "assets/icons/layers-active.svg",
                        color: Colors.white,
                        height: 25.0,
                        width: 25.0,
                      ),
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: "Search",
                    icon: SvgPicture.asset(
                      "assets/icons/search.svg",
                      color: Colors.grey.shade700,
                      height: 25.0,
                      width: 25.0,
                    ),
                    activeIcon: SizedBox(
                      child: SvgPicture.asset(
                        "assets/icons/search-active.svg",
                        color: Colors.white,
                        height: 25.0,
                        width: 25.0,
                      ),
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: "Profile",
                    icon: SvgPicture.asset(
                      "assets/icons/profile.svg",
                      color: Colors.grey.shade700,
                      height: 25.0,
                      width: 25.0,
                    ),
                    activeIcon: SizedBox(
                      child: SvgPicture.asset(
                        "assets/icons/profile-active.svg",
                        color: Colors.white,
                        height: 25.0,
                        width: 25.0,
                      ),
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: "List",
                    icon: SvgPicture.asset(
                      "assets/icons/layers.svg",
                      color: Colors.grey.shade700,
                      height: 25.0,
                      width: 25.0,
                    ),
                    activeIcon: SizedBox(
                      child: SvgPicture.asset(
                        "assets/icons/layers-active.svg",
                        color: Colors.white,
                        height: 25.0,
                        width: 25.0,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
