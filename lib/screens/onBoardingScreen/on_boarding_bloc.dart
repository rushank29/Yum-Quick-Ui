import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:food_ui/screens/onBoardingScreen/on_boarding_dl.dart';
import 'package:food_ui/screens/onBoardingScreen/on_boarding_json.dart';
import 'package:rxdart/rxdart.dart';

class OnBoardingBloc {
  BuildContext context;
  CarouselSliderController? carouselSliderController;
  final subject = BehaviorSubject<OnBoardingPojo>();
  final selectedIndexSubject = BehaviorSubject<int>();

  OnBoardingBloc(this.context) {
    carouselSliderController = CarouselSliderController();
    getOnBoardingData();
  }

  void getOnBoardingData() {
    var response = OnBoardingPojo.fromJson(onBoardingJson);
    subject.sink.add(response);
  }

  void dispose() {
    subject.close();
    selectedIndexSubject.close();
  }
}