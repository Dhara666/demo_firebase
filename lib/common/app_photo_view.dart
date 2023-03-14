import 'dart:io';
import 'package:demofirebase/common/app_appbar.dart';
import 'package:demofirebase/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'app_loader.dart';

class AppPhotoView extends StatelessWidget {
  final String? url;
  final bool? isAssetImage;
  final bool? isAppbar;

  const AppPhotoView(
      {Key? key, this.url, this.isAssetImage = false, this.isAppbar = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isAppbar!
          ? AppAppBar(
              showDrawer: false,
              showUser: false,
             title: "PHOTO  VIEW",
            )
          : AppBar(
              toolbarHeight: 0,
              elevation: 0,
            ),
      body: PhotoView(
        minScale: PhotoViewComputedScale.contained * 0.8,
        maxScale: PhotoViewComputedScale.covered * 2,
        imageProvider: (url!.contains('https')|| url!.contains('http') )
            ? NetworkImage(url!)
            : !isAssetImage!
            ? FileImage(File(url!)) as ImageProvider
            : AssetImage(url!),
        loadingBuilder: (context, event) => const Center(
            child: AppLoader(
              loaderColor: ColorConstant.appBlue,
            )),
        backgroundDecoration: const BoxDecoration(
            color: ColorConstant.appWhite),
      )
    );
  }
}
