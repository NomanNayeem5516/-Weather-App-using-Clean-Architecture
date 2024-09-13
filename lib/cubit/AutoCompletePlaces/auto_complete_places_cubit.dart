import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:weather_app_eith_clean_arc/models/auto_complite_complite.dart';

import '../../networkManager/repository.dart';

part 'auto_complete_places_state.dart';

class AutoCompletePlacesCubit extends Cubit<AutoCompletePlacesState> {
  AutoCompletePlacesCubit() : super(AutoCompletePlacesInitial());
  autoCompletePlaces(String placeName) {
    emit(AutoCompletePlacesLoading());
    Repository().autoCompletePlace(placeName).then((value) {
      emit(AutoCompletePlacesLoaded(value));
    }).onError((error, stackTrace) {
      emit(AutoCompletePlacesError());
      debugPrint('ERROR ==> ${error.toString()}');
    });
  }
}
