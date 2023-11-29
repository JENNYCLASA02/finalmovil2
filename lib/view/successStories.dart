import 'package:animal_love/model/Stories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccessStories extends StatefulWidget {
  final List<Stories> stories;
  const SuccessStories({Key? key, required this.stories}) : super(key: key);

  @override
  State<SuccessStories> createState() => _SuccessStoriesState();
}

class _SuccessStoriesState extends State<SuccessStories> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Center(
            child: Text(
              "Historias de exitos",
              style: GoogleFonts.poppins(
                  fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              children: <Widget>[
                Container(
                  height: 400.h,
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
                        child: Image.network(
                          widget.stories[0].image_url,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(widget.stories[0].tittle,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 5.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.stories[0].description,
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.poppins(fontSize: 13.sp),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  height: 450.h,
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
                      SizedBox(
                        height: 200.h,
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: Image.network(
                              widget.stories[1].image_url,
                              fit: BoxFit.fill,
                            )),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(widget.stories[1].tittle,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 5.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.stories[1].description,
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.poppins(fontSize: 13.sp),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  height: 450.h,
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
                      SizedBox(
                        height: 200.h,
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: Image.network(
                              widget.stories[2].image_url,
                              fit: BoxFit.fill,
                            )),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(widget.stories[2].tittle,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 5.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.stories[2].description,
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.poppins(fontSize: 13.sp),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  height: 550.h,
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
                      SizedBox(
                        height: 200.h,
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: Image.network(
                              widget.stories[3].image_url,
                              fit: BoxFit.fill,
                            )),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(widget.stories[3].tittle,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 5.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.stories[3].description,
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.poppins(fontSize: 13.sp),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
