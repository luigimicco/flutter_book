import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String myPosition = '';

  @override
  void initState() {
    getPosition().then((Position myPos) {
      myPosition =
          'Latitude: ${myPos.latitude.toString()} - Longitude: ${myPos..toString()}';
      setState(() {});
    }).catchError((onError) {
      myPosition = onError.toString();
      setState(() {});
    }).whenComplete(() {
      print('complete');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('current location')),
        body: Center(
          child: Text(myPosition),
        ));
  }

  Future<Position> getPosition() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    await Geolocator.isLocationServiceEnabled();
    await Future.delayed(const Duration(seconds: 3));

    Position? position = await Geolocator.getLastKnownPosition();
    return position!;
  }
}
