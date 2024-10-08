import 'package:flutter/material.dart';
import 'package:weather_app_eith_clean_arc/helper/assets_helper.dart';
import 'package:weather_app_eith_clean_arc/helper/dimensn_helper.dart';
import 'package:weather_app_eith_clean_arc/helper/storage_helper.dart';
import 'package:weather_app_eith_clean_arc/screens/authScreens/login_screen.dart';
import 'package:weather_app_eith_clean_arc/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3),(){
     if(StorageHelper().getUserLat()==0.0){
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
     }else{
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
     }
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: SizedBox(
          height: DimensnHelper.dimensn_200,
          width: DimensnHelper.dimensn_200,
          child: Image.asset(AssetsHelper.weatherIcon),
        ),
      ),
    );
  }
}
