import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weather_app_eith_clean_arc/components/common_button.dart';
import 'package:weather_app_eith_clean_arc/cubit/changeProfile/change_profile_cubit.dart';
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
  File? file;

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
          IconButton(
              onPressed: () {
                StorageHelper().clean();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: BlocBuilder<UserProfileCubit, UserProfileState>(
        builder: (context, state) {
          if (state is UserProfileLoading) {
            return Center(
              child: loadingIndicator(color: ColorsHelper.blueColor),
            );
          } else if (state is UserProfileError) {
            return const Center(
              child: Text('something went wrong'),
            );
          } else if (state is UserProfileLoaded) {
            return content(state.userProfile);
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget content(UserProfile userProfile) {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: DimensnHelper.dimensn_20),
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                ImagePicker imagePicker = ImagePicker();
                XFile? image =
                    await imagePicker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  setState(() {
                    print("Path ==>${image.path}");
                    file = File(image.path);
                  });
                }
              },
              child:file==null? Container(
                margin: const EdgeInsets.symmetric(
                    vertical: DimensnHelper.dimensn_20),
                height: DimensnHelper.dimensn_150,
                width: DimensnHelper.dimensn_150,
                alignment: Alignment.bottomRight,
                decoration: BoxDecoration(
                  color: ColorsHelper.primaryColor,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                      image: NetworkImage(StorageHelper().getUserProfile())),
                ),child: CircleAvatar(
                  backgroundColor: ColorsHelper.blueColor,
                  child: Icon(Icons.image)),
              ): Container(
                margin: const EdgeInsets.symmetric(
                    vertical: DimensnHelper.dimensn_20),
                height: DimensnHelper.dimensn_150,
                width: DimensnHelper.dimensn_150,
                decoration: BoxDecoration(
                  color: ColorsHelper.primaryColor,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(file!)),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Name:',
                  style: TextStyle(fontSize: FontHelper.dimensn_20),
                ),
                Text(
                  userProfile.name,
                  style: const TextStyle(fontSize: FontHelper.dimensn_20),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Email:',
                  style: TextStyle(fontSize: FontHelper.dimensn_20),
                ),
                Text(
                  userProfile.email,
                  style: const TextStyle(fontSize: FontHelper.dimensn_20),
                )
              ],
            ),
            const SizedBox(
              height: DimensnHelper.dimensn_20,
            ),
            Visibility(
              visible: file == null ? false : true,
              child: BlocProvider(
                create: (BuildContext context) => ChangeProfileCubit(),
                child: BlocConsumer<ChangeProfileCubit, ChangeProfileState>(
                  listener: (context, state) {
                    if (state is ChangeProfileLoaded) {
                      StorageHelper().setUserProfile(
                          state.changeProfileModel.location ?? "");
                      file=null;
                      setState(() {});
                    }
                  },
                  builder: (context, state) {
                    return CommonButton(
                        onPress: () {
                          if (state is ChangeProfileLoading) {
                          } else {
                            context
                                .read<ChangeProfileCubit>()
                                .changeProfile(file!);
                          }
                        },
                        child: state is ChangeProfileLoading
                            ? loadingIndicator()
                            : const Text(
                                'save',
                                style: TextStyle(
                                    fontSize: FontHelper.dimensn_20,
                                    color: ColorsHelper.whiteColor),
                              ));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
