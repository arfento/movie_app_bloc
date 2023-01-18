import 'dart:async';

enum NavBarItem { home, genres, search, profile, list }

class BottomNavbarBloc {
  final StreamController<NavBarItem> _navBarController =
      StreamController<NavBarItem>.broadcast();

  NavBarItem defaultItems = NavBarItem.home;

  Stream<NavBarItem> get itemStream => _navBarController.stream;

  void pickItem(int i) {
    switch (i) {
      case 0:
        _navBarController.sink.add(NavBarItem.home);
        break;
      case 1:
        _navBarController.sink.add(NavBarItem.genres);
        break;
      case 2:
        _navBarController.sink.add(NavBarItem.search);
        break;
      case 3:
        _navBarController.sink.add(NavBarItem.profile);
        break;
      case 4:
        _navBarController.sink.add(NavBarItem.list);
        break;
    }
  }

  close() {
    _navBarController.close();
  }
}
