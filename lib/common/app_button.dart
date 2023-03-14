import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String? buttonText;
  final GestureTapCallback? onTap;
  final Color? gradient1;
  final Color? gradient2;
  final EdgeInsets? padding;

  const AppButton(
      {Key? key,
      this.buttonText,
      this.gradient1,
      this.gradient2,
      this.onTap,
        this.padding
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        splashColor: Colors.white,
        child: Padding(
          padding: padding ?? const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20),
          child: Container(
            height: 52.0,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              gradient: LinearGradient(colors: [
                gradient1 ?? const Color(0xFF00bec8),
                gradient2 ?? const Color(0xFF10c078),
              ]),
            ),
            child: Center(
                child: Text(
              buttonText!,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w800,
                  // fontFamily: "Sofia",
                  letterSpacing: 0.9),
            )),
          ),
        ));
  }
}
