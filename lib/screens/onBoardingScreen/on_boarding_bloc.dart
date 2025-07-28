import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../customWidget/networkConnectivityChecker/internet_service.dart';
import '../../utils/response_util.dart';
import 'on_boarding_dl.dart';
import 'on_boarding_json.dart';

class OnBoardingBloc {
  BuildContext context;
  CarouselSliderController? carouselSliderController;
  final subject = BehaviorSubject<ResponseUtil<OnBoardingPojo>>();
  final selectedIndexSubject = BehaviorSubject<int>();

  OnBoardingBloc(this.context) {
    carouselSliderController = CarouselSliderController();
    getOnBoardingData();
  }

  void getOnBoardingData() {
    subject.sink.add(ResponseUtil.loading());
    InternetService().runWhenOnline(() {
      try {
        var response = OnBoardingPojo.fromJson(onBoardingJson);
        subject.sink.add(ResponseUtil.completed(response));
      } catch (error) {
        subject.sink.add(ResponseUtil.error(error.toString()));
      }
    });
  }

  void dispose() {
    subject.close();
    selectedIndexSubject.close();
  }
}
