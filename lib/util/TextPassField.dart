import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'constants.dart';

class TextPassField extends StatelessWidget {
  final IconData icons;
  final VoidCallback press;
  static late TextEditingController controller;
  final String label;
  final bool obscureText;

  const TextPassField(
      {Key? key,
      required this.icons,
      required this.label,
      required this.press,
      required this.obscureText,
      required TextEditingController controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: TextFormField(
          obscureText: obscureText,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: kPrimaryColor),
                borderRadius: BorderRadius.circular(20.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: kPrimaryColor),
                borderRadius: BorderRadius.circular(20.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: kPrimaryColor),
                borderRadius: BorderRadius.circular(20.0),
              ),
              prefixIcon: Icon(
                icons,
                color: kPrimaryColor,
              ),
              suffixIcon: obscureText == true
                  ? IconButton(
                      icon: const Icon(Icons.visibility),
                      color: kPrimaryColor,
                      onPressed: press,
                    )
                  : IconButton(
                      icon: const Icon(Icons.visibility_off),
                      color: kPrimaryColor,
                      onPressed: press,
                    ),
              labelText: label,
              labelStyle: TextStyle(
                  fontSize: 15.sp,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w300
              )
          ),
        validator: (value){
          if(value!.isEmpty){
            return 'Porfavor digitar todos los datos';
          }
          return null;
        },
        onSaved: (value) => controller =
        value?.replaceAll(' ', '') as TextEditingController,
      ),
    );
  }
}
