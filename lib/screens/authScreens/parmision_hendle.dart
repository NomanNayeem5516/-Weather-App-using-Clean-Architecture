import 'package:geolocator/geolocator.dart';

Future<Position> determinePosition() async {

  final GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;

  //await geolocatorPlatform.openAppSettings();
  await geolocatorPlatform.openLocationSettings();


  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await geolocatorPlatform.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await geolocatorPlatform.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await geolocatorPlatform.requestPermission();
    if (permission == LocationPermission.denied) {
      await geolocatorPlatform.openAppSettings();
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    await geolocatorPlatform.openAppSettings();
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await geolocatorPlatform.getCurrentPosition();
}
