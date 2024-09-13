import 'package:flutter/material.dart';
import 'package:weather_app_eith_clean_arc/helper/storage_helper.dart';

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
        backgroundColor: ColorsHelper.primaryColor,
        title: const Text(StringHelper.homeScreen),
        actions: [
          IconButton(onPressed: (){
            StorageHelper().clean();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
          }, icon: const Icon(Icons.logout))
        ],
      ),
    );
  }
}
