import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Model/User.dart';
import '../model/Animal.dart';
import '../util/ButtonLogin.dart';
import '../util/constants.dart';

class DetailAnimals extends StatefulWidget {
  final Pets animal;
  final User user;

  const DetailAnimals({Key? key, required this.animal, required this.user})
      : super(key: key);

  @override
  State<DetailAnimals> createState() => _DetailAnimalsState();
}

class _DetailAnimalsState extends State<DetailAnimals> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: kPrimary2Color,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Información",
          style: GoogleFonts.poppins(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () async {},
              icon: const Icon(
                Icons.favorite_outline_outlined,
                color: Colors.black,
              ))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          widget.animal.image_url,
                          fit: BoxFit.fill,
                        )),
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      widget.animal.name,
                      style: GoogleFonts.poppins(
                          fontSize: 20.sp, fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Text("Ubicacion: ${widget.animal.location}"),
                          Spacer(),
                          Text("Edad: ${widget.animal.age}")
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        widget.animal.description,
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          color: Colors.black54,
                        ),
                      ),
                    )
                  ],
                )),
            ButtonLogin(
                press: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        icon: const Icon(Icons.info_outline,
                            size: 30, color: Colors.orangeAccent),
                        title: const Text("Requisitos minimos para adoptar"),
                        content: SingleChildScrollView(
                          child: Column(
                            children: [
                              const Text(
                                "1. Edad mínima: La edad minima para adpotar una mascota es de 16 años o con un adulto responsable.",
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              const Text(
                                "2. Vivienda adecuada: Tener una vivienda adecuada para una mascota, como por ejemplo tamaño, acojedora etc...",
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              const Text(
                                "3. Tiempo y compromiso: Tener suficiente tiempo y estar dispuesto a comprometerse a cuidar y atender a la mascotas. Las mascotas requieren tiempo para alimentarlas, brindarles atención diaria, proporcionarles ejercicio y brindarles compañía.",
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              const Text(
                                "4. Estabilidad Financiera: Tener la capacidad financiera para cuidar adecuadamente a la mascota. Considera los gastos de alimentación, atención veterinaria, vacunas, esterilización/castración, suministros y otros cuidados necesarios.",
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              const Text(
                                "5. Experiencia previa con mascotas: tener experiencia previa en la crianza de mascotas o si ha investigado lo suficiente sobre las necesidades y cuidados de la especie en particular que desea adoptar.",
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              const Text(
                                "6. Condiciones de convivencia: Tener un entorno seguro y adecuado para la mascota, evitando situaciones de maltrato o negligencia.",
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              const Text(
                                "Si cumples con los requisitos previamente dichos podra adoptar una mascota, haz click aquí.",
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.justify,
                              )
                            ],
                          ),
                        ),
                        actionsAlignment: MainAxisAlignment.center,
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: const Text(
                                        "Ponerse en contacto a este numero 3023145332 o al correo animallove@gmail.com para completar la adopcion",
                                        textAlign: TextAlign.center,
                                      ),
                                      actionsAlignment:
                                          MainAxisAlignment.center,
                                      actions: <Widget>[
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              "Volver",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ))
                                      ],
                                    );
                                  });
                              //Navigator.pop(context);
                            },
                            child: Text('¿Cumple los requisitos?',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp)),
                          ),
                        ],
                      );
                    },
                  );

                  /*final favoriteAnimals =
                      await favorite.loadFavoriteAnimals(widget.user.user);
                  if (favoriteAnimals.isNotEmpty) {
                    print('Animales favoritos de ${favorite.user}:');
                    for (var animal in favoriteAnimals) {
                      print('Nombre: ${animal.name}, Edad: ${animal.age}');
                    }
                  } else {
                    print(
                        'No se encontraron animales favoritos para ${favorite.user}.');
                  }*/
                },
                title: "Adoptar"),
          ],
        ),
      ),
    );
  }
}
