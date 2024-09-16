import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:meta/meta.dart';
import 'package:weather_app_eith_clean_arc/models/current_weather_model.dart';

import '../../networkManager/repository.dart';

part 'current_weather_state.dart';

class CurrentWeatherCubit extends Cubit<CurrentWeatherState> {
  CurrentWeatherCubit() : super(CurrentWeatherInitial());

  currentWeather(String lat, String lon) {
    emit(CurrentWeatherLoading());

    Repository().currentWeather(lat, lon).then((currentWeather) async {
      await placemarkFromCoordinates(double.parse(lat), double.parse(lon))
          .then((value) {
        Placemark placeMark = value[0];
        String name = placeMark.name ?? '';
        String subLocation = placeMark.subLocality ?? '';
        String locality = placeMark.locality ?? '';
        String administrativeArea = placeMark.administrativeArea ?? '';
        String postalCode = placeMark.postalCode ?? '';
        String country = placeMark.country ?? '';
        String address =
            "$name,$subLocation,$locality,$administrativeArea,$postalCode,$country";

       debugPrint(address);

        emit(CurrentWeatherLoaded(currentWeather, locality));
      }).onError((error, stackTrace) {
        emit(CurrentWeatherError());
        debugPrint('ERROR ==>${error.toString()}');
      });
    }).onError((error, stackTrace) {
      emit(CurrentWeatherError());

      debugPrint('ERROR ==>${error.toString()}');
    });
  }
}
