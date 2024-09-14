import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_eith_clean_arc/cubit/userProfile/user_profile_cubit.dart';
import 'package:weather_app_eith_clean_arc/helper/dimensn_helper.dart';
import 'package:weather_app_eith_clean_arc/models/user_profile_model.dart';
import 'package:weather_app_eith_clean_arc/utiles/loading_indicator.dart';

import '../../helper/colors_helper.dart';
import '../../helper/font_helper.dart';
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
  void initState() {
    context.read<UserProfileCubit>().userProfile();
    // TODO: implement initState
    super.initState();
  }
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
      body:BlocBuilder<UserProfileCubit,UserProfileState>(
        builder: (context,state){
          if(state is UserProfileLoading){
            return Center(child: loadingIndicator(),);
          }else if(state is UserProfileError){
            return Center(child: Text('something went wrong'),);
          }else if(state is UserProfileLoaded){
            return content(state.userProfile);
          } return const SizedBox();
        },
      ) ,
    );
  }

  Widget content(UserProfile userProfile){
    return Center(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical:DimensnHelper.dimensn_20 ),
            height: DimensnHelper.dimensn_150,
            width:DimensnHelper.dimensn_150 ,
            decoration:  BoxDecoration(
                color: ColorsHelper.primaryColor,
                shape: BoxShape.circle,
              image: DecorationImage(image: NetworkImage(userProfile.avatar))
            ),

          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text('Name:',style: TextStyle(
                  fontSize: FontHelper.dimensn_20
              ),),
              Text(userProfile.name,style: TextStyle(
                  fontSize: FontHelper.dimensn_20
              ),)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text('Email:',style: TextStyle(
                  fontSize: FontHelper.dimensn_20
              ),),
              Text(userProfile.email,style: TextStyle(
                  fontSize: FontHelper.dimensn_20
              ),)
            ],
          ),

        ],
      ),
    );
  }

}
