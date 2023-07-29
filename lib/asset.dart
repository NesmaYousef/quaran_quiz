import 'dart:convert';

import 'package:flutter/services.dart';

import 'model/ayahs.dart';

class Asset {
  Future<List<List<Ayah>>> fetchData() async {
    List<List<Ayah>>? pagesAyah = [];
    String result = await rootBundle.loadString('assets/hafsData_v2-0.json');

    if (result.isNotEmpty) {
      List<dynamic> ayahs = jsonDecode(result);

      for (int i = 1; i <= 604; i++) {
        List<Ayah> temp = [];

        ayahs.forEach((element) {
          if (element['page'] == i) {
            temp.add(Ayah.fromJson(element));
          }
        });
        pagesAyah.add(temp);
      }
      return pagesAyah;
    }
    return Future.error('error');
  }
}
