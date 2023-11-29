import 'dart:convert';

import 'package:animal_love/model/BottomIcon.dart';
import 'package:animal_love/model/category.dart';
import 'package:animal_love/model/favorite.dart';
import 'package:animal_love/util/Linepainter.dart';
import 'package:animal_love/util/constants.dart';
import 'package:animal_love/view/Profile.dart';
import 'package:animal_love/view/successStories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../Model/User.dart';
import '../model/Animal.dart';
import '../model/Stories.dart';
import '../util/CategoryItem.dart';
import '../util/ShowDialog.dart';
import 'FavoritesView.dart';
import 'detailAnimal.dart';

class Home extends StatefulWidget {
  final User user;
  const Home({Key? key, required this.user}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

var idUser = 0;

class _HomeState extends State<Home> {
  int currentPage = 0;
  late List<Pets> pets = [];

  late List<Category> categorias = [];
  late List<Stories> story = [];
  late List<Favorite> favorite = [];

  Future<void> fetchData() async {
    String apiUrl = "http://jeyliss05.pythonanywhere.com/api/animales";
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          pets = data.map((item) => Pets.fromJson(item)).toList();
        });
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  final url = Uri.parse('http://jeyliss05.pythonanywhere.com/api/categorias');

  Future<void> fetchCategory() async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      List<Category> categories = [];
      for (var item in jsonData) {
        categories
            .add(Category(image_url: item['imagen_url'], name: item['nombre']));
      }
      categorias = categories;
    } else {
      throw Exception('Error en el provider');
    }
  }

  final urls = Uri.parse('http://jeyliss05.pythonanywhere.com/api/historias');

  Future<void> fetchStories() async {
    final response = await http.get(urls);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      List<Stories> stories = [];
      for (var item in jsonData) {
        stories.add(Stories(
            description: item['descripcion'],
            image_url: item['imagen_url'],
            tittle: item['titulo']));
      }
      story = stories;
    } else {
      throw Exception('Error en el provider');
    }
  }

  Future<void> fetchFav(int idUser) async {
    var urlfav = Uri.parse(
        'http://jeyliss05.pythonanywhere.com/api/favoritos_usuario/$idUser');

    final response = await http.get(urlfav);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      List<Favorite> favorites = [];
      for (var item in jsonData) {
        favorites
            .add(Favorite(animal: item['animal'], usuario: item['usuario']));
      }
      favorite = favorites;
    } else {
      throw Exception('Error en el provider');
    }
  }

  @override
  void initState() {
    super.initState();
    idUser = widget.user.id;
    fetchData();
    fetchCategory();
    fetchStories();
    fetchFav(idUser);
  }

  @override
  Widget build(BuildContext context) {
    Widget body() {
      switch (currentPage) {
        case 0:
          return HomePage(
              user: widget.user,
              pets: pets,
              category: categorias,
              favorite: favorite);

        case 1:
          return SuccessStories(
            stories: story,
          );

        case 2:
          return Profile(
            user: widget.user,
          );

        default:
          return Center(
            child: Text(
              'Hubo un error',
              style: GoogleFonts.roboto(),
            ),
          );
      }
    }

    return WillPopScope(
      onWillPop: () async {
        showAlertDialogExit(context, Icons.exit_to_app, "Salir",
            "¿Seguro que quieres salir?", Colors.red, () {
          Navigator.popUntil(context, (route) => route.isFirst);
        });

        return false;
      },
      child: Scaffold(
        backgroundColor: bgColor,
        body: body(),
        bottomNavigationBar: Container(
          height: 60.h,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...List.generate(
                  bottomIcons.length,
                  (index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            currentPage = index;
                          });
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              currentPage == index
                                  ? bottomIcons[index].select
                                  : bottomIcons[index].unselect,
                              color: currentPage == index
                                  ? kPrimary2Color
                                  : Colors.black,
                            ),
                            const SizedBox(height: 10),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              decoration: BoxDecoration(
                                  color: currentPage == index
                                      ? kPrimary2Color
                                      : Colors.black,
                                  shape: BoxShape.circle),
                              width: currentPage == index ? 7 : 0,
                              height: currentPage == index ? 7 : 0,
                            )
                          ],
                        ),
                      ))
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final User user;
  final List<Pets> pets;
  final List<Category> category;
  final List<Favorite> favorite;
  const HomePage(
      {Key? key,
      required this.user,
      required this.pets,
      required this.category,
      required this.favorite})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentCategory = 10;
  bool favorite = false;
  List<Pets> listOriginalAnimals = [];
  List<Pets> listFilterAnimals = [];
  static const List<String> listCity = <String>[
    'Todos',
    'Barranquilla',
    'Bogota',
    'Medellin',
    'Cali',
    'Valledupar',
    'Bucaramanga'
  ];
  String listSelect = listCity.first;

  @override
  void initState() {
    super.initState();
    listOriginalAnimals = widget.pets;
    listFilterAnimals.addAll(listOriginalAnimals);
    listFilterAnimals.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('Tu ubicación',
                              style: GoogleFonts.roboto(
                                  fontSize: 15.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: kPrimary2Color,
                            size: 20,
                          ),
                          const SizedBox(width: 5),
                          DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: listSelect,
                              icon:
                                  const Icon(Icons.keyboard_arrow_down_rounded),
                              style: const TextStyle(color: Colors.black),
                              onChanged: (String? value) {
                                setState(() {
                                  if (value == listCity[0]) {
                                    listSelect = value!;
                                    listFilterAnimals = listOriginalAnimals;
                                    listFilterAnimals.shuffle();
                                  } else {
                                    listSelect = value!;
                                    filterList(listSelect);
                                    listFilterAnimals.shuffle();
                                  }
                                });
                              },
                              items: listCity.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    print(widget.favorite);

                    /*final favorite = Favorite([], widget.user.name);
                    final favoriteAnimals =
                        await favorite.loadFavoriteAnimals(widget.user.user);*/
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return FavoriteView(
                            user: widget.user,
                            listFavorites: getFavoritePetsList(
                                widget.pets, widget.favorite),
                          );
                        },
                      ),
                    );
                  },
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.favorite_outline_outlined,
                          color: Colors.black)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.h),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          offset: Offset(4, 8))
                    ],
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Buscar Mascotas',
                      hintStyle: GoogleFonts.poppins(),
                      prefixIcon: const Icon(Icons.search),
                      prefixIconColor: kPrimary2Color),
                  onChanged: (value) {
                    currentCategory = 10;
                    filterList(value);
                    listFilterAnimals.shuffle();
                  },
                ),
              )),
          SizedBox(
            height: 30.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Mascotas",
                  style: GoogleFonts.roboto(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text(
                  "ver todos",
                  style: GoogleFonts.roboto(color: kPrimary2Color),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: SizedBox(
              height: 130,
              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.category.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 1.2,
                    mainAxisSpacing: 5),
                itemBuilder: (BuildContext context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (currentCategory == index) {
                            currentCategory = 10;
                            listFilterAnimals = listOriginalAnimals;
                            listFilterAnimals.shuffle();
                          } else {
                            currentCategory = index;
                            filterList(widget.category[index].name);
                            listFilterAnimals.shuffle();
                          }
                        });
                      },
                      child: CategoryItem(
                        selected: currentCategory == index,
                        category: widget.category[index],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Text('Result (${listFilterAnimals.length})',
                    style: GoogleFonts.roboto(
                        color: Colors.black.withOpacity(0.6))),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: CustomPaint(
                    painter: LinePainter(),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: GridView.builder(
                scrollDirection: Axis.vertical,
                itemCount: listFilterAnimals.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.2,
                    mainAxisSpacing: 10),
                itemBuilder: (BuildContext context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        /*
                        final favorite = Favorite([], widget.user.user);
                        final favoriteAnimals = await favorite
                            .loadFavoriteAnimals(widget.user.user);*/
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DetailAnimals(
                                user: widget.user,
                                animal: listFilterAnimals[index],
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 4,
                                offset: Offset(4, 8))
                          ],
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                color: Colors.transparent,
                                width: double.infinity,
                                child: Image.network(
                                  listFilterAnimals[index].image_url,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  listFilterAnimals[index].name,
                                  style: GoogleFonts.poppins(),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void filterList(String filter) {
    setState(() {
      listFilterAnimals = listOriginalAnimals
          .where((animals) =>
              animals.name.toLowerCase().contains(filter.toLowerCase()) ||
              animals.age.toString().contains(filter.toLowerCase()) ||
              animals.location == filter)
          .toList();
    });
  }

  List<Pets> getFavoritePetsList(
      List<Pets> allPets, List<Favorite> favoriteList) {
    List<Pets> favoritePets = [];

    for (Favorite favorite in favoriteList) {
      Pets? pet = allPets.firstWhere((pet) => pet.id == favorite.animal,
          orElse: () => Pets(
              description: '',
              age: 0,
              id: -1,
              image_url: '',
              location: '',
              name: '',
              state: true));

      if (pet.id != -1) {
        favoritePets.add(pet);
      }
    }

    return favoritePets;
  }
}
