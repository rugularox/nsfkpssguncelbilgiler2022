import 'dart:ui';

import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

var kpsshazirlikadres = Uri.parse(
    'https://play.google.com/store/apps/details?id=com.nsf.nsfkpsshazirlik2022');
var kpsstarihsoruadres = Uri.parse(
    'https://play.google.com/store/apps/details?id=com.nsf.nsfkpsstarihsorunsf');

Map<String, String> secili = {
  'tum': 'Tüm Güncel Bilgiler',
  'guncel': '2022 Güncel Bilgileri',
  'kultur': 'Genel Kültür Bilgileri',
  'guncelsoru': 'Güncel Bilgiler Soruları'
};

String gunceldetaybanner = 'ca-app-pub-3535745534592900/1033368113';
String guncelbanner = 'ca-app-pub-3535745534592900/8984479517';
//String kulturedetaybanner = 'ca-app-pub-3535745534592900/6826967889';
String guncelsorudetaybanner = 'ca-app-pub-3535745534592900/5130742831';
String guncelorulargecis = 'ca-app-pub-3535745534592900/4590265909';
String guncelbildirimdetaybanner = 'ca-app-pub-3535745534592900/2609317437';
String sorubildirimdetaybanner = 'ca-app-pub-3535745534592900/4682399705';
String guncelbilgilergecis = 'ca-app-pub-3535745534592900/6333219267';

class detaybilgisi {
  int? id;
  String? body;
  String? title;

  detaybilgisi({this.id, this.body, this.title});
}

class detaybilgisisoru {
  int? id;
  String? soru;
  String? a;
  String? b;
  String? c;
  String? d;
  String? e;
  String? dogrusik;

  detaybilgisisoru(
      {this.id,
      this.soru,
      this.a,
      this.b,
      this.c,
      this.d,
      this.e,
      this.dogrusik});
}

Map<String, Color> btnrenk = {
  "a": Colors.indigoAccent,
  "b": Colors.indigoAccent,
  "c": Colors.indigoAccent,
  "d": Colors.indigoAccent,
  "e": Colors.indigoAccent,
};

void snackgetir(BuildContext context, String mesaj) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(mesaj),
  ));
}

void nettenyukleniyor(BuildContext context) {
  snackgetir(context, 'VERİLER İNTERNETTEN YÜKLENİYOR, LÜTFEN BEKLEYİNİZ...');
}

List<String> gunceldenemeler = [
  'boş',
  'Güncel Bilgiler Deneme Sınavı- 1 Gezegenler',
  'Uluslararası Kuruluşlar Denemesi',
  'Güncel Bilgiler Deneme Sınavı- 2',
  'Güncel Bilgiler Deneme Sınavı- 3 ',
  'Güncel Bilgiler Deneme Sınavı – 4',
  'Güncel Bilgiler Deneme Sınavı – 5',
  'Güncel Bilgiler Deneme Sınavı – 6',
  'Güncel Bilgiler Deneme Sınavı – 7',
  'Güncel Bilgiler Deneme Sınavı – 8',
  'Güncel Bilgiler Deneme Sınavı – 9',
  'Güncel Bilgiler Deneme Sınavı – 10',
  'Güncel Bilgiler Deneme Sınavı – 11',
  'Güncel Bilgiler Deneme Sınavı – 12',
  'Güncel Bilgiler Deneme Sınavı – 13'
];

List<String> adreslergunceldeneme = [
  'boş',
  'https://www.kpssmobilensf.com/kpss-guncel-bilgiler-deneme-sinavi-7-gezegenler/',
  'https://www.kpssmobilensf.com/uluslararasi-kuruluslar-denemesi-no-1/',
  'https://www.kpssmobilensf.com/guncel-bilgiler-deneme-sinavi-2/',
  'https://www.kpssmobilensf.com/guncel-bilgiler-deneme-sinavi-3/',
  'https://www.kpssmobilensf.com/guncel-bilgiler-deneme-sinavi-4/',
  'https://www.kpssmobilensf.com/guncel-bilgiler-deneme-sinavi-5/',
  'https://www.kpssmobilensf.com/guncel-bilgiler-deneme-sinavi-6/',
  'https://www.kpssmobilensf.com/guncel-bilgiler-deneme-sinavi-7/',
  'https://www.kpssmobilensf.com/guncel-bilgiler-deneme-sinavi-8/',
  'https://www.kpssmobilensf.com/guncel-bilgiler-deneme-sinavi-9/',
  'https://www.kpssmobilensf.com/guncel-bilgiler-deneme-sinavi-10/',
  'https://www.kpssmobilensf.com/guncel-bilgiler-deneme-sinavi-11/',
  'https://www.kpssmobilensf.com/guncel-bilgiler-deneme-sinavi-12/',
  'https://www.kpssmobilensf.com/guncel-bilgiler-deneme-sinavi-13/'
];
