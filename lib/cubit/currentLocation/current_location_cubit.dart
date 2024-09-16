import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:weather_app_eith_clean_arc/helper/storage_helper.dart';
import 'package:weather_app_eith_clean_arc/screens/home_screen.dart';

import '../../screens/authScreens/parmision_hendle.dart';

part 'current_location_state.dart';

class CurrentLocationCubit extends Cubit<CurrentLocationState> {
  CurrentLocationCubit() : super(CurrentLocationInitial());

  grtGeoLocator(BuildContext context){
    emit(CurrentLocationLoading());
    determinePosition().then((value){
      debugPrint('User Location==>Lat:${value.latitude}|| Lug:${value.longitude}');
      StorageHelper().setUserLat(value.latitude);
      StorageHelper().setUserLng(value.longitude);


      StorageHelper().setUserLat(value.latitude);
      StorageHelper().setUserLng(value.longitude);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));

      emit(CurrentLocationLoaded());
    }).onError((error,stackTrace){
      emit(CurrentLocationError());
      debugPrint('ERROR==>Lat:${error.toString()}');
    });
  }

}
