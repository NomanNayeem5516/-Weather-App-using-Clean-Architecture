import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../models/change_profile_model.dart';
import '../../networkManager/repository.dart';

part 'change_profile_state.dart';

class ChangeProfileCubit extends Cubit<ChangeProfileState> {
  ChangeProfileCubit() : super(ChangeProfileInitial());

  changeProfile(File file) async{
    emit(ChangeProfileLoading());
    String fileName=file.path.split('/').last;
    FormData fileData=FormData.fromMap({
      "file":
          await MultipartFile.fromFile(file.path,filename: fileName),
    });

    Repository().changeProfile(fileData).then((value) {
      emit(ChangeProfileLoaded(value));

    }).onError((error, stackTrace) {
      emit(ChangeProfileError());
      debugPrint('ERROR=>${error.toString()}');
    });
  }

}
