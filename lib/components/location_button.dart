import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/currentLocation/current_location_cubit.dart';
import '../helper/colors_helper.dart';
import '../helper/dimensn_helper.dart';
import '../utiles/loading_indicator.dart';

class LocationButton extends StatelessWidget {
  final bool isPreviousScreen;
  const LocationButton({super.key, required this.isPreviousScreen});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
        create: (context) => CurrentLocationCubit(),
        child:
        BlocBuilder<CurrentLocationCubit, CurrentLocationState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                context
                    .read<CurrentLocationCubit>()
                    .grtGeoLocator(context,isPreviousScreen);
              },
              child: Container(
                margin: const EdgeInsets.only(
                    left: DimensnHelper.dimensn_10),
                height: DimensnHelper.dimensn_50,
                width: DimensnHelper.dimensn_50,
                decoration: const BoxDecoration(
                    color: ColorsHelper.blueColor,
                    shape: BoxShape.circle),
                child: state is CurrentLocationLoading
                    ? loadingIndicator()
                    : const Icon(
                  Icons.my_location,
                  color: ColorsHelper.whiteColor,
                ),
              ),
            );
          },
        ));
  }
}
