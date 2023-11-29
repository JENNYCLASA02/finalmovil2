import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Provider/storyProvider.dart';
import '../Screens/add_story.dart';
import '../model/Stories.dart';
import 'home_admin.dart';

class Story_Adm extends StatefulWidget {
  const Story_Adm({Key? key}) : super(key: key);

  @override
  State<Story_Adm> createState() => _Story_AdmState();
}

class _Story_AdmState extends State<Story_Adm> {
  final StoryProviders storyProviders = StoryProviders();

  @override
  void initState() {
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
          Column(
            children: [
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
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Home_Adm(),
                              ),
                            );
                          },
                          child: Text(
                            "Admon",
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                              color: const Color(0xFFF87D28),
                            ),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(40),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 4,
                                  )
                                ]),
                            child: CircleAvatar(
                              radius: 30.0,
                              backgroundImage: AssetImage("assets/perfil.jpg"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 128,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    'Historias',
                    style: GoogleFonts.roboto(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: StoryAdminState(storyProviders: storyProviders)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                child: Container(
                  width: 200.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFF87D28),
                        Color(0xFFA4593C),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Add_story()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      elevation: 0.0, // Sin sombra
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        side: const BorderSide(color: Colors.white),
                      ),
                    ),
                    child: const Text(
                      'Agregar',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Resto del contenido
        ],
      ),
    );
  }
}

class StoryAdminState extends StatefulWidget {
  final StoryProviders storyProviders;
  const StoryAdminState({Key? key, required this.storyProviders})
      : super(key: key);

  @override
  State<StoryAdminState> createState() => _StoryAdminStateState();
}

class _StoryAdminStateState extends State<StoryAdminState> {
  late Future<List<Stories>> _listStories;

  @override
  void initState() {
    super.initState();
    _listStories = widget.storyProviders.fetchStories();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _listStories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error ${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          return GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: (snapshot.data as List<Stories>).length,
            itemBuilder: (context, index) {
              return _listStory(snapshot.data as List<Stories>)[index];
            },
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }

  List<Widget> _listStory(List<Stories> data) {
    return List.generate(data.length, (index) {
      var story = data[index];
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
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 1.5,
                          child: Image(
                            image: NetworkImage(story.image_url),
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          story.tittle,
                          style: GoogleFonts.poppins(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
