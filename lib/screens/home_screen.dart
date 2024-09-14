import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_eith_clean_arc/cubit/userProfile/user_profile_cubit.dart';
import 'package:weather_app_eith_clean_arc/helper/storage_helper.dart';
import 'package:weather_app_eith_clean_arc/screens/profileScreen/profile_screen.dart';

import '../helper/colors_helper.dart';
import '../helper/string_helper.dart';
import 'authScreens/login_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          //StorageHelper().clean();
          Navigator.push(context, MaterialPageRoute(builder: (context)=>
          BlocProvider(
              create: (BuildContext context)=>UserProfileCubit(),
              child: const ProfileScreen())
          ));
        }, icon: const Icon(Icons.person)),
        backgroundColor: ColorsHelper.primaryColor,
        title: const Text(StringHelper.homeScreen),
        // actions: [
        //   IconButton(onPressed: (){
        //     //StorageHelper().clean();
        //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
        //   }, icon: const Icon(Icons.logout))
        // ],
      ),
    );
  }
}
