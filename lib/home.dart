import 'dart:ffi';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:quaran_quiz/asset.dart';
import 'package:quaran_quiz/model/ayahs.dart';
import 'package:quaran_quiz/widgets/header.dart';
import 'package:quaran_quiz/widgets/page_ayahs.dart';
import 'package:quaran_quiz/widgets/surah_frame.dart';

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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
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
                                  child: SurahFrame(surah: surah),
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
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
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
                                          child: Column(
                                            children: [
                                              Text(
                                                '${ayah.ayaText}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                              ),
                                            ],
                                          ));
                                    });
                              },
                            text: '${ayah.ayaText}',
                            style: Theme.of(context).textTheme.bodyLarge,
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
                                    gradient: (index + 1) % 2 == 0
                                        ? LinearGradient(colors: [
                                            Color(0xfffdf5b7),
                                            Color(0xfffdf8ca),
                                            Color(0xfff6f2d3),
                                          ])
                                        : LinearGradient(colors: [
                                            Color(0xfff6f2d3),
                                            Color(0xfffdf8ca),
                                            Color(0xfffdf5b7),
                                          ])),
                                child: Column(
                                  children: [
                                    header(surah: surah, jozz: jozz),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    pageOfAyahs(
                                        listTextSpan: listTextSpan,
                                        scale: scale),
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
      ),
    );
  }
}
