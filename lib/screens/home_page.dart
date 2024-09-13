import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_eith_clean_arc/cubit/currentLocation/current_location_cubit.dart';
import 'package:weather_app_eith_clean_arc/helper/dimensn_helper.dart';
import 'package:weather_app_eith_clean_arc/helper/storage_helper.dart';
import 'package:weather_app_eith_clean_arc/utiles/loading_indicator.dart';

import '../cubit/AutoCompletePlaces/auto_complete_places_cubit.dart';
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
                      context.read<AutoCompletePlacesCubit>().autoCompletePlaces(value);
                    },
                  ),
                ),
                BlocProvider(
                    create: (context) => CurrentLocationCubit(),
                    child: BlocBuilder<CurrentLocationCubit, CurrentLocationState>(
                                        builder: (context, state) {
                    return GestureDetector(
                      onTap: (){
                        context.read<CurrentLocationCubit>().grtGeoLocator(context);
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
                                      ))
              ],
            ),
            BlocConsumer<AutoCompletePlacesCubit,AutoCompletePlacesState>(
              listener: (context,state){
                if(state is AutoCompletePlacesLoaded){

                }
              },
              builder: (context,state){
                if(state is AutoCompletePlacesLoaded){
                  return ListView.builder(
                    shrinkWrap: true,

                    itemCount: state.autoCompletePlaces.results?.length??0,
                     itemBuilder: (context,index){
                       return ListTile(
                         leading: Icon(
                           Icons.location_on
                         ),
                           title: Text(state.autoCompletePlaces.results?[index].name??"",),
                         subtitle: Text(state.autoCompletePlaces.results?[index].country??"",),
                       );
                     },
                  );
                }else{
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
