import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:weather_app_eith_clean_arc/cubit/currentLocation/current_location_cubit.dart';
import 'package:weather_app_eith_clean_arc/cubit/currentWeather/current_weather_cubit.dart';
import 'package:weather_app_eith_clean_arc/cubit/userProfile/user_profile_cubit.dart';
import 'package:weather_app_eith_clean_arc/helper/assets_helper.dart';
import 'package:weather_app_eith_clean_arc/helper/dimensn_helper.dart';
import 'package:weather_app_eith_clean_arc/helper/font_helper.dart';
import 'package:weather_app_eith_clean_arc/helper/storage_helper.dart';
import 'package:weather_app_eith_clean_arc/models/current_weather_model.dart';
import 'package:weather_app_eith_clean_arc/screens/home_page.dart';
import 'package:weather_app_eith_clean_arc/screens/profileScreen/profile_screen.dart';

import '../helper/colors_helper.dart';
import '../helper/string_helper.dart';
import '../utiles/loading_indicator.dart';
import 'authScreens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime time = DateTime.now();
  @override
  void initState() {
    context.read<CurrentWeatherCubit>().currentWeather(
        StorageHelper().getUserLat().toString(),
        StorageHelper().getUseLng().toString());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              //StorageHelper().clean();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlocProvider(
                          create: (BuildContext context) => UserProfileCubit(),
                          child: const ProfileScreen())));
            },
            icon: CircleAvatar(
                backgroundColor: ColorsHelper.blueColor,
                child: const Icon(Icons.person))),
        backgroundColor: ColorsHelper.primaryColor,
        title: const Text(StringHelper.homeScreen),
        actions: [
          IconButton(
              onPressed: () async {
                //StorageHelper().clean();
                var param =await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomePage(
                              isPreviousScreen: true,
                            )));

                if (param != null) {
                  saveAddressPopup(param['lat'],param['lng']);

                  context.read<CurrentWeatherCubit>().currentWeather(
                      param['lat'].toString(),
                      param['lng'].toString());

                }
              },
              icon: CircleAvatar(
                  backgroundColor: ColorsHelper.whiteColor,
                  child: const Icon(Icons.location_on)))
        ],
      ),
      body: BlocBuilder<CurrentWeatherCubit, CurrentWeatherState>(
        builder: (context, state) {
          if (state is UserProfileLoading) {
            return Center(
              child: loadingIndicator(color: ColorsHelper.blueColor),
            );
          } else if (state is CurrentWeatherError) {
            return const Center(
              child: Text('something went wrong'),
            );
          } else if (state is CurrentWeatherLoaded) {
            return contentWidhet(state.currentWeatherModel, state.address);
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget contentWidhet(CurrentWeatherModel currentWeatherModel, String address) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: DimensnHelper.dimensn_100,
            ),
            Text(
              address,
              style: TextStyle(
                  color: ColorsHelper.blueColor,
                  fontWeight: FontWeight.bold,
                  fontSize: FontHelper.dimensn_25),
            ),
            Text(
              Jiffy.now().yMMMMEEEEdjm,
              style: TextStyle(
                  color: ColorsHelper.blackColor,
                  //fontWeight: FontHelper.reg,
                  fontSize: FontHelper.dimensn_20),
            ),
            SizedBox(
              height: DimensnHelper.dimensn_50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: DimensnHelper.dimensn_100,
                  width: DimensnHelper.dimensn_100,
                  child: Image.asset(AssetsHelper.weatherIcon),
                ),
                Text(
                  '${currentWeatherModel.currentWeather?.temperature.toString() ?? ''} ${currentWeatherModel.currentWeatherUnits?.temperature.toString() ?? ''}',
                  style: TextStyle(
                      color: ColorsHelper.blueColor,
                      fontWeight: FontWeight.bold,
                      fontSize: FontHelper.dimensn_25),
                ),
              ],
            ),
            Text(
              'Wind Speed: ${currentWeatherModel.currentWeather?.windspeed.toString() ?? ''} ${currentWeatherModel.currentWeatherUnits?.windspeed.toString() ?? ''}',
              style: TextStyle(
                  color: ColorsHelper.blackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: FontHelper.dimensn_20),
            ),
          ],
        ),
      ),
    );
  }
  Future<void>saveAddressPopup(double lat,double lng) async{
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext constant){
          return AlertDialog(
            title: Text('Do You Want To Save This Addredd'),
            content: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ListBody(
                children: [
                  Text(''),
                  Text(''),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text('Cancel')),

              TextButton(onPressed: (){
                StorageHelper().setUserLat(lat);
                StorageHelper().setUserLng(lng);
                Navigator.of(context).pop();
              }, child: Text('Save'))
            ],
          );
        }
    );
  }
}
