import 'dart:convert';

import 'package:animal_love/util/AlreadyHaveAnAccountCheck.dart';
import 'package:animal_love/util/ButtonLogin.dart';
import 'package:animal_love/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../Model/User.dart';
import '../util/ShowDialog.dart';
import '../util/constants.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = true;
  }

  final String apiUrl = "http://jeyliss05.pythonanywhere.com/api/saveusuario";
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  var maskFormatter = MaskTextInputFormatter(
      mask: '(###) ###-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  Future<void> sendDataToApi(User user) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                Home(user: user),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      } else {
        showAlertDialog(
          context,
          Icons.close,
          "Error",
          "Error al enviar los datos. Código de respuesta: ${response.statusCode}",
          Colors.red,
          () {
            Navigator.pop(context);
          },
        );
      }
    } catch (e) {
      showAlertDialog(
        context,
        Icons.close,
        "Error",
        "Error al enviar los datos. Código de respuesta: ${e}",
        Colors.red,
        () {
          Navigator.pop(context);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/fondo.jpeg"),
                  fit: BoxFit.fill,
                  opacity: 0.5),
            ),
          ),
          SingleChildScrollView(
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50.h,
                    ),
                    Image.asset(
                      "assets/logo.png",
                      height: 200.h,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          prefixIcon: const Icon(
                            Icons.alternate_email,
                            color: kPrimaryColor,
                          ),
                          labelText: "E-Mail",
                          labelStyle: TextStyle(
                              fontSize: 15.sp,
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w300),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Porfavor digitar todos los datos';
                          }
                          if (!value.contains('@')) {
                            return 'El formato del correo no esta correcto';
                          }
                          return null;
                        },
                        onSaved: (value) => emailController =
                            value?.replaceAll(' ', '') as TextEditingController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: TextFormField(
                        inputFormatters: [maskFormatter],
                        keyboardType: TextInputType.phone,
                        controller: phoneController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          prefixIcon: const Icon(
                            Icons.phone_outlined,
                            color: kPrimaryColor,
                          ),
                          labelText: "Telefono",
                          labelStyle: TextStyle(
                              fontSize: 15.sp,
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w300),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Porfavor digitar todos los datos';
                          }
                          return null;
                        },
                        onSaved: (value) => phoneController =
                            value?.replaceAll(' ', '') as TextEditingController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        controller: userController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          prefixIcon: const Icon(
                            Icons.person_outline_rounded,
                            color: kPrimaryColor,
                          ),
                          labelText: "Usuario",
                          labelStyle: TextStyle(
                              fontSize: 15.sp,
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w300),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Porfavor digitar todos los datos';
                          }
                          return null;
                        },
                        onSaved: (value) => userController =
                            value?.replaceAll(' ', '') as TextEditingController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: TextFormField(
                        controller: passController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.orange),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: kPrimaryColor),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: kPrimaryColor),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: kPrimaryColor),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: kPrimaryColor,
                            ),
                            suffixIcon: _obscureText == true
                                ? IconButton(
                                    icon: const Icon(Icons.visibility),
                                    color: kPrimaryColor,
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                  )
                                : IconButton(
                                    icon: const Icon(Icons.visibility_off),
                                    color: kPrimaryColor,
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                  ),
                            labelText: "Contraseña",
                            labelStyle: TextStyle(
                                fontSize: 15.sp,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w300)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Porfavor digitar todos los datos';
                          }
                          return null;
                        },
                        onSaved: (value) => passController =
                            value?.replaceAll(' ', '') as TextEditingController,
                      ),
                    ),
                    ButtonLogin(
                        press: () async {
                          if (_formKey.currentState!.validate()) {
                            User user = User(
                                phone: phoneController.text,
                                password: passController.text,
                                email: emailController.text,
                                name: userController.text,
                                nameUser: userController.text,
                                state: true,
                                typeuser: 'Adopter',
                                id: 0);

                            sendDataToApi(user);
                          }
                        },
                        title: "Registrarse"),
                    AlreadyHaveAnAccountCheck(
                        login: false,
                        press: () {
                          Navigator.pop(context);
                        })
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
