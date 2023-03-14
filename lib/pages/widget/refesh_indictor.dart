
import 'package:flutter/material.dart';

class RefreshIndicatorPage extends StatefulWidget {
  @override
  RefreshIndicatorPageState createState() => RefreshIndicatorPageState();
}

class RefreshIndicatorPageState extends State<RefreshIndicatorPage> {

  GlobalKey<ScaffoldState>? _scaffoldKey;

  List<String>? _demoData;

  @override
  void initState() {
    _demoData = [
      "Flutter",
      "React Native",
      "Cordova/ PhoneGap",
      "Native Script"
    ];
    _scaffoldKey = GlobalKey();
    super.initState();
  }

  @override
  void dispose() {
    // disposing states
    _scaffoldKey?.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('Refresh Indicator'),
        ),
        // Widget to show RefreshIndicator
        body: RefreshIndicator(
          child: ListView.builder(
            itemBuilder: (ctx, idx) {
              return Card(
                child: ListTile(
                  title: Text(_demoData![idx]),
                ),
              );
            },
            itemCount: _demoData?.length,
            physics: const AlwaysScrollableScrollPhysics(),
          ),
          onRefresh: () {
            return Future.delayed(
              const Duration(seconds: 1),
                  () {

                setState(() {
                  _demoData?.addAll(["Ionic", "Xamarin"]);
                });

                // showing snackbar
                _scaffoldKey?.currentState?.showSnackBar(
                  const SnackBar(
                    content: Text('Page Refreshed'),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
