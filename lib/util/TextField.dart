import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'constants.dart';

class TextFieldC extends StatelessWidget {
  final IconData icons;
  static late TextEditingController controller;
  final String label;

  const TextFieldC(
      {Key? key,
      required this.icons,
      required this.label,
      required TextEditingController controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: TextFormField(
          controller: controller,
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
              labelText: label,
              labelStyle: TextStyle(
                  fontSize: 15.sp,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w300)
          ),
        validator: (value){
            if(value!.isEmpty){
              return 'Porfavor digitar todos los datos';
            }
            /*if (option == "user") {
              if (value.length < 4) {
                return "Digitar el usuario correctamente";
              }
            }*/
            return null;
        },
        onSaved: (value) => controller =
        value?.replaceAll(' ', '') as TextEditingController,
      ),
    );
  }
}
