import 'package:demofirebase/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppLoader extends StatelessWidget {
  final Color loaderColor;
  final double loaderSize;

  const AppLoader(
      {Key? key, this.loaderColor = ColorConstant.appRed, this.loaderSize = 40})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: ColorConstant.appWhite.withOpacity(0.8),
        child: SpinKitDoubleBounce(
          color: loaderColor,
          size: loaderSize,
        ),
      ),
    );
  }
}
