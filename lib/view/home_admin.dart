import 'package:animal_love/util/constants.dart';
import 'package:animal_love/view/pets_admin.dart';
import 'package:animal_love/view/story_admin.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'category_admin.dart';

class Home_Adm extends StatefulWidget {
  const Home_Adm({Key? key}) : super(key: key);

  @override
  State<Home_Adm> createState() => _Home_AdmState();
}

class _Home_AdmState extends State<Home_Adm> {
  bool _obscureText = false;

  @override
  void initState() {
    _obscureText = true;
    super.initState();
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
                opacity: 0.1,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hola",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      "Admon",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                        color: const Color(0xFFF87D28),
                      ),
                    ),
                  ],
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: AssetImage("assets/perfil.jpg"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10.0, 340.0, 10.0, 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Icono 1
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Story_Adm()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(40.0, 30.0, 40.0, 30.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          offset: Offset(4, 8),
                        ),
                      ],
                      border: Border.all(
                        color: const Color(0xFFF87D28),
                        width: 2.0,
                      ),
                    ),
                    child: const Icon(
                      Icons.auto_stories,
                      size: 40.0,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
                // Icono 2
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Pets()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(40.0, 30.0, 40.0, 30.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          offset: Offset(4, 8),
                        ),
                      ],
                      border: Border.all(
                        color: const Color(0xFFF87D28),
                        width: 2.0,
                      ),
                    ),
                    child: const Icon(
                      Icons.pets,
                      size: 40.0,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10.0, 490.0, 10.0, 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Icono
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Category_Adm()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(40.0, 30.0, 40.0, 30.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          offset: Offset(4, 8),
                        ),
                      ],
                      border: Border.all(
                        color: const Color(0xFFF87D28),
                        width: 2.0,
                      ),
                    ),
                    child: const Icon(
                      Icons.category,
                      size: 40.0,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
