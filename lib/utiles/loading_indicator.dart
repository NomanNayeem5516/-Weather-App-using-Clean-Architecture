import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app_eith_clean_arc/helper/colors_helper.dart';

Widget loadingIndicator({Color? color}) {
  return  CircularProgressIndicator(
    color:color?? ColorsHelper.whiteColor,
  );
}
