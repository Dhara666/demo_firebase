import 'dart:math';
import 'package:demofirebase/pages/geolocation_pages/place_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import 'address_dialog_page.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({Key? key}) : super(key: key);

  @override
  _GoogleMapPageState createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {

  final CameraPosition _initialLocation = const CameraPosition(target: LatLng(0.0, 0.0));
  GoogleMapController? mapController;

  Position? _currentPosition;
  String? _currentAddress;

  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();

  final startAddressFocusNode = FocusNode();
  final destinationAddressFocusNode = FocusNode();

  String _startAddress = '';
  String _destinationAddress = '';
  String _placeDistance = '';

  late PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polyLines = {};
  List<LatLng> polylineCoordinates = [];
  final sessionToken = const Uuid().v4();

  late Position destinationCoordinates;
  late Position startCoordinates;

  Set<Marker>? markers = {};
  late Marker destinationMarker;
  late Marker startMarker;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestPermissionGoogleMap();
    // apiProvider = PlaceApiProvider(sessionToken);
    getCurrentLocation();
    // setState(() {});
  }

  requestPermissionGoogleMap() async {
    await Geolocator.requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Map"),
      ),
      body: Stack(
        children: [
          GoogleMap(
            polylines: Set<Polyline>.of(polyLines.values),
            initialCameraPosition: _initialLocation,
            myLocationEnabled: true,
            markers: Set<Marker>.from(markers!),
            // trafficEnabled: true,
            //zoomGesturesEnabled: true,
            compassEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    commonMapTextFormFiled(
                      labelText: GoogleMapString.sourceLocation,
                      icon: (Icons.adjust_rounded),
                      iconColor: Colors.blueAccent,
                      controller: startAddressController,
                      focusNode: startAddressFocusNode,
                      function: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        openPlacePicker();
                      },
                      onSaved: (str) {
                        setState(() {
                          _startAddress = str!;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    commonMapTextFormFiled(
                        labelText: GoogleMapString.destination,
                        icon: (Icons.location_on),
                        iconColor: Colors.red,
                        controller: destinationAddressController,
                        focusNode: destinationAddressFocusNode,
                        function: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          openPlacePicker2();
                        },
                        onSaved: (str) {
                          setState(() {
                            _destinationAddress = str!;
                          });
                        },
                        ),
                    const SizedBox(height: 10),
                    _placeDistance.isNotEmpty
                        ? Text(
                            '${GoogleMapString.distance} : $_placeDistance km',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Container(),
                    const SizedBox(height: 5),
                    Container(
                      height: 35,
                      width: 80,
                      decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                  padding: const EdgeInsets.only(left: 7),
                                  child: const Icon(
                                    Icons.navigation_outlined,
                                    color: Colors.white,
                                    size: 20,
                                  ))),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 3,
                            child: MaterialButton(
                              padding: const EdgeInsets.only(right: 10),
                              onPressed: (_startAddress != '' &&
                                      _destinationAddress != '')
                                   ? () async {
                                      startAddressFocusNode.unfocus();
                                      destinationAddressFocusNode.unfocus();
                                      setState(() {
                                        if (markers!.isNotEmpty) {
                                          markers!.clear();
                                        }
                                        if (polyLines.isNotEmpty) {
                                          polyLines.clear();
                                        }
                                        if (polylineCoordinates.isNotEmpty) {
                                          polylineCoordinates.clear();
                                        }
                                        _placeDistance = '';
                                      });
                                      _calculateDistance();
                                    }
                                  : () {
                                      print("null receive");
                                    },
                              child: const Text(
                                GoogleMapString.start,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget commonMapTextFormFiled(
      {TextEditingController? controller,
      String? labelText,
      IconData? icon,
      Color? iconColor,
      FocusNode? focusNode,
      FormFieldSetter<String>? onSaved,
      Function? function}) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: TextFormField(
        onTap: () {
          function!();
        },
        enableInteractiveSelection: false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          labelText: labelText,
          labelStyle: const TextStyle(fontSize: 12),
          prefixIcon: Icon(
            icon,
            color: iconColor,
            size: 20,
          ),
        ),
        controller: controller,
        focusNode: focusNode,
        onSaved: onSaved,
      ),
    );
  }

  openPlacePicker() async {
    final sessionToken = const Uuid().v4();

    print("my session Token :- $sessionToken");
    final Suggestion result = await showDialog(
      context: context,
      builder: (BuildContext context) => AddressDialogPage(
        sessionToken: sessionToken,
      ),
    );
    if (result != null) {
      print("Our Result:--$result");
      setState(() {
        startAddressController.text = result.description;
        _startAddress = result.description;
      });
    }
  }

  openPlacePicker2() async {
    final sessionToken = Uuid().v4();

    print("my session Token :- $sessionToken");
    final Suggestion result = await showDialog(
      context: context,
      builder: (BuildContext context) => AddressDialogPage(
        sessionToken: sessionToken,
      ),
    );
    if (result != null) {
      print("Our Result2:--$result");
      setState(() {
        destinationAddressController.text = result.description;
        _destinationAddress = result.description;
      });
    }
  }

  getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        print('CURRENT POS: $_currentPosition');
        mapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 14.0,
            ),
          ),
        );
      });
      _getAddress();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddress() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
        startAddressController.text = _currentAddress!;
        _startAddress = _currentAddress!;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<bool> _calculateDistance() async {
    try {
      List<Location> startPlacemark = await locationFromAddress(_startAddress);
      List<Location> destinationPlacemark =
          await locationFromAddress(_destinationAddress);

      if (startPlacemark != null && destinationPlacemark != null) {
        Position startCoordinates = _startAddress == _currentAddress
            ? Position(
                speed: 0,
                accuracy: 0,
                altitude: 0,
                heading: 0,
                speedAccuracy: 0,
                timestamp: null,
                latitude: _currentPosition!.latitude,
                longitude: _currentPosition!.longitude)
            : Position(
                speed: 0,
                accuracy: 0,
                altitude: 0,
                heading: 0,
                speedAccuracy: 0,
                timestamp: null,
                latitude: startPlacemark[0].latitude,
                longitude: startPlacemark[0].longitude);
        Position destinationCoordinates = Position(
            speed: 0,
            accuracy: 0,
            altitude: 0,
            heading: 0,
            speedAccuracy: 0,
            timestamp: null,
            latitude: destinationPlacemark[0].latitude,
            longitude: destinationPlacemark[0].longitude);

        // Start Location Marker
        startMarker = Marker(
          markerId: MarkerId('$startCoordinates'),
          position: LatLng(
            startCoordinates.latitude,
            startCoordinates.longitude,
          ),
          infoWindow: InfoWindow(
            title: 'Start Point',
            snippet: _startAddress,
          ),
          // icon: await BitmapDescriptor.fromAssetImage(
          //     ImageConfiguration(devicePixelRatio: 2.5, size: const Size(5, 5)),
          //     'assets/images/des.png')
        );

        // Destination Location Marker
        destinationMarker = Marker(
          markerId: MarkerId('$destinationCoordinates'),
          position: LatLng(
            destinationCoordinates.latitude,
            destinationCoordinates.longitude,
          ),
          infoWindow: InfoWindow(
            title: 'Destination Point',
            snippet: _destinationAddress,
          ),
          // icon: await BitmapDescriptor.fromAssetImage(
          //     const ImageConfiguration(devicePixelRatio: 3.5, size: Size(5, 5)),
          //     'assets/images/des.png'),
        );

        // Adding the markers to the list
        markers?.add(startMarker);
        markers?.add(destinationMarker);

        print('START COORDINATES: $startCoordinates');
        print('DESTINATION COORDINATES: $destinationCoordinates');

        Position _northeastCoordinates;
        Position _southwestCoordinates;

        // Calculating to check that the position relative
        // to the frame, and pan & zoom the camera accordingly.
        double miny =
            (startCoordinates.latitude <= destinationCoordinates.latitude)
                ? startCoordinates.latitude
                : destinationCoordinates.latitude;
        double minx =
            (startCoordinates.longitude <= destinationCoordinates.longitude)
                ? startCoordinates.longitude
                : destinationCoordinates.longitude;
        double maxy =
            (startCoordinates.latitude <= destinationCoordinates.latitude)
                ? destinationCoordinates.latitude
                : startCoordinates.latitude;
        double maxx =
            (startCoordinates.longitude <= destinationCoordinates.longitude)
                ? destinationCoordinates.longitude
                : startCoordinates.longitude;

        _southwestCoordinates = Position(
            speed: 0,
            accuracy: 0,
            altitude: 0,
            heading: 0,
            speedAccuracy: 0,
            timestamp: null,
            latitude: miny,
            longitude: minx);
        _northeastCoordinates = Position(
            speed: 0,
            accuracy: 0,
            altitude: 0,
            heading: 0,
            speedAccuracy: 0,
            timestamp: null,
            latitude: maxy,
            longitude: maxx);

        mapController!.animateCamera(
          CameraUpdate.newLatLngBounds(
            LatLngBounds(
              northeast: LatLng(
                _northeastCoordinates.latitude,
                _northeastCoordinates.longitude,
              ),
              southwest: LatLng(
                _southwestCoordinates.latitude,
                _southwestCoordinates.longitude,
              ),
            ),
            100.0,
          ),
        );
        await _createPolylines(startCoordinates, destinationCoordinates);

        double totalDistance = 0.0;

        for (int i = 0; i < polylineCoordinates.length - 1; i++) {
          totalDistance += _coordinateDistance(
            polylineCoordinates[i].latitude,
            polylineCoordinates[i].longitude,
            polylineCoordinates[i + 1].latitude,
            polylineCoordinates[i + 1].longitude,
          );
        }

        setState(() {
          _placeDistance = totalDistance.toStringAsFixed(2);
          print('DISTANCE: $_placeDistance km');
        });

        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  _createPolylines(Position start, Position destination) async {
    polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyB_kIX5UrOzY9KC14LVNRAIsZCkx3xBXeA', // Google Maps API Key
      PointLatLng(start.latitude, start.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.driving,
    );
    print("Result:- ${result.status}");
    print("Result:- ${result.points}");
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    PolylineId id = const PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      visible: true,
      points: polylineCoordinates,
      width: 5,
    );
    polyLines[id] = polyline;
  }
}
