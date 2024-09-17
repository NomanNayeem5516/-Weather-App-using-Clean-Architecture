import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_eith_clean_arc/cubit/currentLocation/current_location_cubit.dart';
import 'package:weather_app_eith_clean_arc/helper/dimensn_helper.dart';
import 'package:weather_app_eith_clean_arc/helper/storage_helper.dart';
import 'package:weather_app_eith_clean_arc/screens/home_screen.dart';
import 'package:weather_app_eith_clean_arc/utiles/loading_indicator.dart';

import '../components/location_button.dart';
import '../cubit/AutoCompletePlaces/auto_complete_places_cubit.dart';
import '../helper/colors_helper.dart';
import '../helper/string_helper.dart';

class HomePage extends StatefulWidget {
  final bool isPreviousScreen;
  const HomePage({super.key, required this.isPreviousScreen});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsHelper.primaryColor,
        title: const Text(StringHelper.location),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration:
                        InputDecoration(hintText: StringHelper.enterPlace),
                    onChanged: (String value) {
                      context
                          .read<AutoCompletePlacesCubit>()
                          .autoCompletePlaces(value);
                    },
                  ),
                ),
                LocationButton(isPreviousScreen: widget.isPreviousScreen,)
              ],
            ),
            BlocConsumer<AutoCompletePlacesCubit, AutoCompletePlacesState>(
              listener: (context, state) {
                if (state is AutoCompletePlacesLoaded) {}
              },
              builder: (context, state) {
                if (state is AutoCompletePlacesLoaded) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.autoCompletePlaces.results?.length ?? 0,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          if(widget.isPreviousScreen){
                            Map prams= {
                              'lat': state.autoCompletePlaces.results?[index].latitude ??0.0,
                              'lng':state.autoCompletePlaces.results?[index].longitude ??0.0,};
                            Navigator.pop(context,prams);
                          }else{
                            StorageHelper().setUserLat(
                              state.autoCompletePlaces.results?[index].latitude ??
                                  0.0,
                            );
                            StorageHelper().setUserLng(
                              state.autoCompletePlaces.results?[index]
                                  .longitude ??
                                  0.0,
                            );

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()));


                          }

                          },
                        leading: Icon(Icons.location_on),
                        title: Text(
                          state.autoCompletePlaces.results?[index].name ?? "",
                        ),
                        subtitle: Text(
                          state.autoCompletePlaces.results?[index].country ??
                              "",
                        ),
                      );
                    },
                  );
                } else {
                  return const SizedBox();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
