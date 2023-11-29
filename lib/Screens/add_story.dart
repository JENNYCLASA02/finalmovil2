import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../view/story_admin.dart';

class Add_story extends StatefulWidget {
  const Add_story({Key? key}) : super(key: key);

  @override
  State<Add_story> createState() => _Add_storyState();
}

class _Add_storyState extends State<Add_story> {
  bool _obscureText = false;
  File? _image;
  FocusNode _nameFocus = FocusNode();
  FocusNode _locationFocus = FocusNode();
  FocusNode _ageFocus = FocusNode();

  @override
  void initState() {
    _obscureText = true;
    super.initState();
  }

  Future<void> _pickImage() async {
    print("Clic en el contenedor para agregar foto");

    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      } else {
        print("No se seleccionó ninguna imagen");
      }
    } catch (e) {
      print("Error al seleccionar una imagen: $e");
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          contentPadding: EdgeInsets.zero,
          content: Container(
            width: double.infinity,
            height: 100.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.pets,
                  size: 45.0,
                  color: Color(0xFFF87D28),
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'La Historia ha sido guardada con éxito.',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cerrar',
                style: TextStyle(color: Color(0xFFF87D28)),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          // Fondo blanco
          Container(
            color: Colors.white,
          ),
          // Contenedor superior simulando una barra de título personalizada
          Container(
            padding: const EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Flecha para regresar
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    // Acción al presionar la flecha de regreso
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Story_Adm()), // Reemplaza "Pantalla2" con el nombre de tu pantalla
                    );
                  },
                ),
                // Título central
                Text(
                  'Registrar Historia',
                  style: GoogleFonts.roboto(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Espaciador
                const SizedBox(width: 40.0),
              ],
            ),
          ),
          // Contenedor para agregar foto
          Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 25.0, 30.0, 8.0),
            child: Center(
              child: InkWell(
                onTap: _pickImage,
                child: Container(
                  width: 290.0,
                  height: 200.0,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: _image != null
                      ? Image.file(
                          _image!,
                          width: 290.0,
                          height: 200.0,
                          fit: BoxFit.cover,
                        )
                      : const Icon(
                          Icons.add_a_photo,
                          size: 80.0,
                          color: Color(0xFFF87D28),
                        ),
                ),
              ),
            ),
          ),
          // Contenedor para agregar nombre
          Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 5.0),
            child: Center(
              child: Container(
                width: 330.0,
                height: 60.0,
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(
                    color: const Color(0xFFF87D28),
                    width: 1.0,
                  ),
                ),
                child: Row(
                  children: [
                    const Padding(padding: EdgeInsets.all(5.0)),
                    const Icon(
                      Icons.text_fields,
                      size: 20.0,
                      color: Color(0xFFF87D28),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: TextField(
                        focusNode: _nameFocus,
                        decoration: const InputDecoration(
                          hintText: 'Nombre',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Contenedor para la descripción
          Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 5.0),
            child: Center(
              child: Container(
                width: 330.0,
                height: 230.0,
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.0),
                  border: Border.all(
                    color: const Color(0xFFF87D28),
                    width: 1.0,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment
                      .start, // Alineación en la parte superior
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Icon(
                        Icons.description,
                        size: 20.0,
                        color: Color(0xFFF87D28),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          focusNode: _nameFocus,
                          decoration: const InputDecoration(
                            hintText: 'Descripcion',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Botón central en la parte inferior
          Container(
            child: Padding(
              padding: const EdgeInsets.all(55.0),
              child: Positioned(
                child: Center(
                  child: Container(
                    width: 200.0, // Ancho del botón
                    height: 50.0, // Altura del botón
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(25.0), // Borde redondeado
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFF87D28), // Color inicial
                          Color(0xFFA4593C), // Color final
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        // Mostrar el diálogo de éxito
                        _showSuccessDialog();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent, // Color transparente
                        elevation: 0.0, // Sin sombra
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: const BorderSide(
                              color: Colors.white), // Borde blanco
                        ),
                      ),
                      child: const Text(
                        'Guardar',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
