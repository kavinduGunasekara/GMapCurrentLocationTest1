import 'dart:async';

//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Completer<GoogleMapController> _googleMapController =Completer();
CameraPosition? _cameraPosition;  
 Location? _location; 
 LocationData? _currentLocation;





@override
void initState(){
  _init();
  super.initState();

}

_init() async { 
   _location = Location();
   _cameraPosition = CameraPosition(
    target: LatLng(0,0),
    zoom: 15 
  );

   //moveToCurrentLocation();
   _initLocation();
}

  
   // the map will move to my current location
  
 _initLocation() {
    //use this to go to current location instead
    _location?.getLocation().then((location) {
      _currentLocation = location;
    });
    _location?.onLocationChanged.listen((newLocation) { 
      _currentLocation = newLocation;
      moveToPosition(LatLng(_currentLocation?.latitude ?? 0, _currentLocation?.longitude ?? 0));
    });
  }

     //umse this to get current location
moveToPosition(LatLng latLng) async {
  GoogleMapController mapController =await _googleMapController.future;
  mapController.animateCamera(
    CameraUpdate.newCameraPosition(
      CameraPosition(
        target: latLng,
        zoom: 15
      )
    )
  );

}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

Widget _buildBody(){
  return _getMap();

}
Widget _getMarker(){
  return Container(
    width: 40,
    height: 40,
    padding: EdgeInsets.all(2),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius:BorderRadius.circular(100),
      boxShadow: [ 
        BoxShadow(
        color: Colors.grey,
        offset: Offset(0,3),
        spreadRadius: 4,
        blurRadius: 6
        )
      ]
  ),
  child: ClipOval(child: Image.asset("assets/profile.png")),
  );
}

Widget _getMap(){
 
  return Stack(
    children: [
      GoogleMap(
        initialCameraPosition: _cameraPosition!,
        mapType:MapType.normal,
        onMapCreated: (GoogleMapController controller){
         // var _googleMapController;
         // var _googleMapController;
          if(!_googleMapController.isCompleted){
            _googleMapController.complete(controller);
          }

        },
      ),
      Positioned.fill(
        child:Align(
          alignment: Alignment.center,
          child: _getMarker()
          )
      )
    ],
  );
}
}


