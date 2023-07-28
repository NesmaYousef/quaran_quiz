import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quaran_quiz/network.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'asset.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Asset asset = Asset();
  int pageNumber = 1;
  List<dynamic> ayahs = [];

  Network network = Network();

  void getData() async {
    ayahs = await asset.fetchData(pageNumber);
  }

  @override
  void initState() {
    getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'My App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.green),
        home: Scaffold(
          body: SafeArea(
            child: PageView.builder(itemBuilder: (context, index) {
              pageNumber = index + 1;
              getData();
              return Row(
                textDirection:
                    pageNumber % 2 == 0 ? TextDirection.rtl : TextDirection.ltr,
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  for (int i = 0; i < ayahs.length; i++) ...{
                                    TextSpan(
                                      text: '${ayahs[i]['aya_text']}',
                                      style: TextStyle(
                                          fontSize: 18, fontFamily: 'Hafs'),
                                    ),
                                  }
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                          Text(pageNumber.toString())
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ));
  }
}
