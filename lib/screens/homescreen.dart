// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class homeScreen extends StatefulWidget {
  Color? color;
  String? city;
  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'data',
                textScaleFactor: 2,
              ),
              ElevatedButton(
                  onPressed: () async {
                    cityChecker();
                  },
                  child: Text('check')),
              widget.city == 'Karachi'
                  ? ElevatedButton(onPressed: () {}, child: Text('good to go'))
                  : widget.city == null
                      ? Container(
                          child: Text('check First'),
                        )
                      : Text('not good to go')
            ],
          )),
    );
  }

  Future<void> cityChecker() async {
    if (LocationPermission != LocationPermission.denied) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks[0].locality == 'Delhi') {}
      setState(() {
        widget.city = 'Delhi';
      });
    } else {
      Geolocator.requestPermission();
    }
  }
}
