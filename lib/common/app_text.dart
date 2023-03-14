import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final TextAlign? textAlign;
  final double? height;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextDecoration? decoration;
  final TextStyle? textStyle;

  const AppText({
    Key? key,
    this.text,
    this.fontSize=13,
    this.textAlign,
    this.height,
    this.maxLines,
    this.overflow,
    this.decoration = TextDecoration.none, this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '$text',
      textAlign: textAlign,
      maxLines: maxLines,
      style: textStyle
    );
  }
}

