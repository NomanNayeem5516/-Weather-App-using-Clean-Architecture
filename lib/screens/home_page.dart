import 'package:flutter/material.dart';
import 'package:weather_app_eith_clean_arc/helper/storage_helper.dart';

import '../helper/colors_helper.dart';
import '../helper/string_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsHelper.primaryColor,
          title: const Text(StringHelper.location),
        ),
      body:Column(
        children: [
          TextFormField(
            decoration: InputDecoration(hintText: StringHelper.enterPlace),
            onChanged: (String value){},
          )
        ],
      ),
    );
  }
}
