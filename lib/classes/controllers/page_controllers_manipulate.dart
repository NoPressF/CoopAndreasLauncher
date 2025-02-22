import 'package:flutter/material.dart';

class PageControllersManipulate {
  static final PageController _pageController = PageController();
  static int _currentPage = 0;

  static get getController => _pageController;
  static get getCurrentPage => _currentPage;

  static void setCurrentPage(int page) {
    _currentPage = page;
  }

  static void animateToPage(int page) {
    _pageController.animateToPage(page,
        duration: kTabScrollDuration, curve: Curves.ease);
  }
}
