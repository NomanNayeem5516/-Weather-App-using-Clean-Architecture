import 'package:flutter/material.dart';

import '../../helper/colors_helper.dart';
import '../../helper/storage_helper.dart';
import '../../helper/string_helper.dart';
import '../authScreens/login_screen.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsHelper.primaryColor,
        title: const Text('profile'),
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
