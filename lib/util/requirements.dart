import 'package:flutter/material.dart';

class Requirements {
  show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          icon: const Icon(
            Icons.info_outline,
            size: 30,
            color: Colors.orangeAccent,
          ),
          title: const Text('Requisitos minimos para adoptar'),
          content: const SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "1. Edad mínima: La edad minima para adpotar una mascota es de 16 años o con un adulto responsable.",
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "2. Vivienda adecuada: Tener una vivienda adecuada para una mascota, como por ejemplo tamaño, acojedora etc...",
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "3. Tiempo y compromiso: Tener suficiente tiempo y estar dispuesto a comprometerse a cuidar y atender a la mascotas. Las mascotas requieren tiempo para alimentarlas, brindarles atención diaria, proporcionarles ejercicio y brindarles compañía.",
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "4. Estabilidad Financiera: Tener la capacidad financiera para cuidar adecuadamente a la mascota. Considera los gastos de alimentación, atención veterinaria, vacunas, esterilización/castración, suministros y otros cuidados necesarios.",
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "5. Experiencia previa con mascotas: tener experiencia previa en la crianza de mascotas o si ha investigado lo suficiente sobre las necesidades y cuidados de la especie en particular que desea adoptar.",
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "6. Condiciones de convivencia: Tener un entorno seguro y adecuado para la mascota, evitando situaciones de maltrato o negligencia.",
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Si cumples con los requisitos previamente dichos podra adoptar una mascota.",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.justify,
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                ShowD().show(context);
              },
              child: const Center(
                child: Text(
                  '¿Cumple con los requisitos?',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class ShowD {
  show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text(
              'Ponerse en contacto a este numero 3023145332 o al correo animallove@gmail.com para la adopcions'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Center(
                child: Text(
                  'Volver',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
