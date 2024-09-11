import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_eith_clean_arc/components/common_button.dart';

import 'package:weather_app_eith_clean_arc/helper/colors_helper.dart';
import 'package:weather_app_eith_clean_arc/helper/dimensn_helper.dart';
import 'package:weather_app_eith_clean_arc/helper/font_helper.dart';
import 'package:weather_app_eith_clean_arc/helper/string_helper.dart';
import 'package:weather_app_eith_clean_arc/utiles/loading_indicator.dart';

import '../../cubit/logIn/log_in_cubit.dart';
import '../../cubit/logIn/log_in_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsHelper.primaryColor,
        title: const Text(StringHelper.logIn),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            top: DimensnHelper.dimensn_20,
            left: DimensnHelper.dimensn_20,
            right: DimensnHelper.dimensn_20),
        child: Column(
          children: [
            TextFormField(
              controller: emailController,
              decoration:
                  const InputDecoration(hintText: StringHelper.enterEmail),
            ),
            const SizedBox(
              height: DimensnHelper.dimensn_10,
            ),
            TextFormField(
              controller: passwordController,
              decoration:
                  const InputDecoration(hintText: StringHelper.enterPassword),
            ),
            const SizedBox(
              height: DimensnHelper.dimensn_20,
            ),
            BlocProvider(
              create: (BuildContext context) => LogInCubit(),
              child: BlocBuilder<LogInCubit, LogInState>(
                builder: (context, state) {

                  return CommonButton(
                    onPress: () {
                      context.read<LogInCubit>().userLogIn(
                          emailController.text.toString(),
                          passwordController.text.toString(),context);
                    },
                    child: state is LogInLoading? loadingIndicator():const Text(
                      StringHelper.logIn,
                      style: TextStyle(
                          color: ColorsHelper.whiteColor,
                          fontSize: FontHelper.dimensn_20),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
