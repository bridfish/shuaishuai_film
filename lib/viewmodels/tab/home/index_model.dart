import 'package:flutter/cupertino.dart';

class IndexModel with ChangeNotifier {
  PageController _pageController;
  int navBarCurrentIndex = 0;

  void setNavBarCurrentIndex(int navBarCurrentIndex) {
    this.navBarCurrentIndex = navBarCurrentIndex;
    _pageController.jumpToPage(navBarCurrentIndex);
    notifyListeners();
  }

  IndexModel(this._pageController);
}