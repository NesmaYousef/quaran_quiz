class Ayah {
  int? id;
  int? jozz;
  int? page;
  int? suraNo;
  String? suraNameEn;
  String? suraNameAr;
  int? lineStart;
  int? lineEnd;
  int? ayaNo;
  String? ayaText;
  String? ayaTextEmlaey;

  Ayah(
      {this.id,
      this.jozz,
      this.page,
      this.suraNo,
      this.suraNameEn,
      this.suraNameAr,
      this.lineStart,
      this.lineEnd,
      this.ayaNo,
      this.ayaText,
      this.ayaTextEmlaey});

  Ayah.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jozz = json['jozz'];
    page = json['page'];
    suraNo = json['sura_no'];
    suraNameEn = json['sura_name_en'];
    suraNameAr = json['sura_name_ar'];
    lineStart = json['line_start'];
    lineEnd = json['line_end'];
    ayaNo = json['aya_no'];
    ayaText = json['aya_text'];
    ayaTextEmlaey = json['aya_text_emlaey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['jozz'] = this.jozz;
    data['page'] = this.page;
    data['sura_no'] = this.suraNo;
    data['sura_name_en'] = this.suraNameEn;
    data['sura_name_ar'] = this.suraNameAr;
    data['line_start'] = this.lineStart;
    data['line_end'] = this.lineEnd;
    data['aya_no'] = this.ayaNo;
    data['aya_text'] = this.ayaText;
    data['aya_text_emlaey'] = this.ayaTextEmlaey;
    return data;
  }
}
