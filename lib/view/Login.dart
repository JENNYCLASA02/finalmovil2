import 'package:animal_love/util/ButtonLogin.dart';
import 'package:animal_love/view/Register.dart';
import 'package:animal_love/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/authentication_bloc.dart';
import '../util/AlreadyHaveAnAccountCheck.dart';
import '../util/constants.dart';
import 'home_admin.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = false;

  @override
  void initState() {
    _obscureText = true;
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AuthenticationBloc(),
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticatedState) {
              // Usuario autenticado, realizar acciones necesarias
              if (state.user.status == 'OK') {
                if (state.userDetails.typeuser == 'Adopter') {
                  return Home(
                    user: state.userDetails,
                  );
                } else {
                  //manda a la vista administrador
                  return const Home_Adm();
                }
              } else {
                return _buildLoginForm(context);
              }
            } else if (state is AuthenticationError) {
              return _buildLoginForm(context);
            } else {
              // Pantalla de inicio de sesión
              return _buildLoginForm(context);
            }
          },
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Stack(
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
                    height: 100.h,
                  ),
                  Image.asset(
                    "assets/logo.png",
                    height: 200.h,
                  ),
                  SizedBox(
                    height: 100.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      controller: userController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: Colors.orange),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: kPrimaryColor),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: kPrimaryColor),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: kPrimaryColor),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        prefixIcon: const Icon(
                          Icons.person,
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
                          final username = userController.text;
                          final password = passController.text;
                          BlocProvider.of<AuthenticationBloc>(context).add(
                              LoginEvent(
                                  username: username, password: password));
                        }
                      },
                      title: "Ingresar"),
                  AlreadyHaveAnAccountCheck(
                    press: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const Register();
                          },
                        ),
                      );
                    },
                    login: true,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
