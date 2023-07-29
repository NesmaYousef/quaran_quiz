import 'dart:ffi';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:quaran_quiz/asset.dart';
import 'package:quaran_quiz/model/ayahs.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Asset asset = Asset();
  int pageNumber = 0;
  List<List<Ayah>>? pages;
  String basmla = '‏ ‏‏ ‏‏‏‏ ‏‏‏‏‏‏ ‏';
  double scale = 1;

  void getData() async {
    pages = await asset.fetchData();
    setState(() {});
  }

  @override
  void initState() {
    getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Quran',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.green),
        home: Scaffold(
          body: SafeArea(
            child: pages == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : GestureDetector(
                    onScaleUpdate: (d) {
                      setState(() {
                        scale = d.scale;
                      });
                    },
                    child: PageView.builder(
                        itemCount: 604,
                        itemBuilder: (context, index) {
                          List<InlineSpan> listTextSpan = [];
                          bool isBasmla = false;

                          Set<String?> surah = {};
                          Set<int?> jozz = {};

                          for (Ayah ayah in pages![index]) {
                            surah.add(ayah.suraNameAr);
                            jozz.add(ayah.jozz);

                            if (ayah.ayaNo == 1) {
                              listTextSpan.add(
                                WidgetSpan(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: double.infinity,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image:
                                              AssetImage('assets/images/1.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Text('${surah.first}'),
                                    ),
                                  ),
                                ),
                              );
                            }

                            if (ayah.suraNameAr != 'الفَاتِحة' &&
                                ayah.suraNameAr != 'التوبَة' &&
                                ayah.ayaNo == 1) {
                              listTextSpan.add(
                                WidgetSpan(
                                  child: Center(
                                    child: Text(
                                      basmla,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'uthmanic_hafs_v20'),
                                    ),
                                  ),
                                ),
                              );
                            }

                            listTextSpan.add(TextSpan(
                              recognizer: LongPressGestureRecognizer(
                                duration: Duration(milliseconds: 200),
                              )..onLongPress = () {
                                  showModalBottomSheet(
                                      context: context,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(15))),
                                      builder: (context) {
                                        return Container(
                                          height: 300,
                                          padding: const EdgeInsets.all(16),
                                          child: Text('${ayah.ayaText}'),
                                        );
                                      });
                                },
                              text: '${ayah.ayaText}',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'uthmanic_hafs_v20'),
                            ));
                          }
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            textDirection: (index + 1) % 2 == 0
                                ? TextDirection.rtl
                                : TextDirection.ltr,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 2),
                                width: 1,
                                color: Colors.grey,
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      gradient: pageNumber % 2 == 0
                                          ? LinearGradient(colors: [
                                              Color(0xff9d9766),
                                              Color(0xff9f9965),
                                              Color(0xffa6a06a),
                                              Color(0xffc4bd80),
                                              Color(0xffd9d28f),
                                              Color(0xfff6f2d3),
                                              Color(0xffd9d28f),
                                            ])
                                          : LinearGradient(colors: [
                                              Color(0xffd9d28f),
                                              Color(0xfff6f2d3),
                                              Color(0xffd9d28f),
                                              Color(0xffc4bd80),
                                              Color(0xffa6a06a),
                                              Color(0xff9f9965),
                                              Color(0xff9d9766),
                                            ])),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${surah.first}',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontFamily:
                                                      'uthmanic_hafs_v20'),
                                            ),
                                            Text(
                                              '${jozz.first}',
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: Text.rich(
                                          TextSpan(children: listTextSpan),
                                          textScaleFactor: scale,
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text((index + 1).toString()),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
          ),
        ));
  }
}
