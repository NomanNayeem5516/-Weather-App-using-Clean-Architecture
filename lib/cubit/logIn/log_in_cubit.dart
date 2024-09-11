import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:weather_app_eith_clean_arc/helper/storage_helper.dart';
import 'package:weather_app_eith_clean_arc/models/login_model.dart';
import 'package:weather_app_eith_clean_arc/screens/home_page.dart';

import '../../networkManager/repository.dart';
import 'log_in_state.dart';







class LogInCubit extends Cubit<LogInState> {
  LogInCubit() : super(LogInInitial());


  userLogIn(String email,String password,BuildContext context ){
    emit(LogInLoading());
    Map requestBody=
    {
      "email" : email,
      "password":password,
    };
    Repository().login(requestBody).then((value){
      emit(LogInLoaded(value));
      StorageHelper().setUserAccessToken(value.accessToken??"");
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomePage()));

      debugPrint('Data===>${value.toString()}');

    }).onError((error,stackTrace){
      emit(LogInError());
      debugPrint('ERROR=>${error.toString()}');
    });
  }

}
