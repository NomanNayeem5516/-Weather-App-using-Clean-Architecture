import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:weather_app_eith_clean_arc/networkManager/repository.dart';

import '../../models/user_profile_model.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {

  UserProfileCubit() : super(UserProfileInitial());

  userProfile(){
    emit(UserProfileLoading());

    Repository().userProfile().then((value){
      emit(UserProfileLoaded(value));
      print(value.toString());

    }).onError((error,stackTrace){
      emit(UserProfileError());

      debugPrint('ERROR ==>${error.toString()}');
    });

  }
}
