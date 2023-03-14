import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final String? hint;
  final List<TextInputFormatter>? inputFormatters;

  const AppTextField({
    Key? key,
    this.controller,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.name,
    @required this.hint,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: TextFormField(
        controller: controller,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        cursorColor: Colors.black,
        cursorWidth: 1,
        inputFormatters: inputFormatters,
        style: Theme.of(context).textTheme.headline3!.copyWith(
              fontSize: 14,
              color: Colors.black,
            ),
        decoration: InputDecoration(
          hintText: hint!,
          hintStyle: Theme.of(context).textTheme.subtitle2!.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          border: appOutlineInputBorder(),
          disabledBorder: appOutlineInputBorder(),
          enabledBorder: appOutlineInputBorder(),
          errorBorder: appOutlineInputBorder(color: Colors.red),
          focusedBorder: appOutlineInputBorder(color: Colors.red),
        ),
      ),
    );
  }
}

OutlineInputBorder appOutlineInputBorder({Color? color}) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide:
          BorderSide(color: color ?? Colors.grey.withOpacity(0.5), width: 0.7),
    );
