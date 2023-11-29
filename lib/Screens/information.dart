import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/Animal.dart';
import '../util/adoptButtom.dart';
import '../util/requirements.dart';

class InformationScreen extends StatelessWidget {
  final Pets info;

  const InformationScreen({Key? key, required this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 15, 20),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                    color: const Color(0xFFF87D28),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 20, 30, 20),
                  child: Text(
                    'Informacion',
                    style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 20, 10, 20),
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border)),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 20, 50, 20),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white, width: 2)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: AspectRatio(
                  aspectRatio: 1.5,
                  child: Image(
                    image: NetworkImage(info.image_url),
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Text(
              info.name,
              style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 80, 2),
                  child: Text('Ubicacion: ${info.location}'),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(70, 0, 0, 0),
                  child: Text('Edad: ${info.age}'),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
            child: Text(
              info.description,
              style: GoogleFonts.poppins(
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
            child: Text(
              'Gracias a la aplicación de adopción, Marta encontró a Simba, un gatito juguetón y cariñoso. A través de la aplicación, pudo ver fotos, leer su historia y chatear con el refugio. Después de una visita exitosa, Marta adpotó a Simba, y la aplicación facilitó la comunicación y coordinación para que pudieran encontrar el uno al otro. ',
              style: GoogleFonts.poppins(
                  color: Colors.grey, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          AdoptButtom(
              press: () {
                Requirements().show(context);
              },
              title: 'Adoptar')
        ],
      ),
    );
  }
}
