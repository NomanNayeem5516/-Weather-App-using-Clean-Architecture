import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:weather_app_eith_clean_arc/networkManager/repository.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {

  UserProfileCubit() : super(UserProfileInitial());

  userProfile(){

    Repository().userProfile().then((value){

    }).onError((error,stackTrace){

      debugPrint('ERROR ==>${error.toString()}');
    });

  }
}
