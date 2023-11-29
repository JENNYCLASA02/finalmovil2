import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Provider/petsProvider.dart';
import '../Screens/information.dart';
import '../model/Animal.dart';

class PetsPageState extends StatefulWidget {
  final PetsProvider petsProvider;

  const PetsPageState({Key? key, required this.petsProvider}) : super(key: key);

  @override
  State<PetsPageState> createState() => _PetsPageStateState();
}

class _PetsPageStateState extends State<PetsPageState> {
  late Future<List<Pets>> _listPets;

  @override
  void initState() {
    super.initState();
    _listPets = widget.petsProvider.fetchPets();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _listPets,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Error ${snapshot.error}"),
          );
        } else if (snapshot.hasData) {
          List<Pets> shuffledList = List.from(snapshot.data as List<Pets>)
            ..shuffle();
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 1.2, mainAxisSpacing: 10),
            itemCount: shuffledList.length,
            itemBuilder: (context, index) {
              return _listPet(shuffledList)[index];
            },
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }

  List<Widget> _listPet(List<Pets> data) {
    return List.generate(
      data.length,
      (index) {
        var pet = data[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4,
                            offset: Offset(4, 8),
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        onDoubleTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InformationScreen(
                                      info: pet.toInformation())));
                        },
                        child: Column(
                          children: [
                            AspectRatio(
                              aspectRatio: 1.5,
                              child: Image(
                                image: NetworkImage(pet.image_url),
                                height: 90,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              pet.name,
                              style: GoogleFonts.poppins(),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
