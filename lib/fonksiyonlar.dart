import 'package:flutter/material.dart';

void snackgetir(BuildContext context, String mesaj) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(mesaj),
  ));
}

void nettenyukleniyor(BuildContext context) {
  snackgetir(context, 'VERİLER İNTERNETTEN YÜKLENİYOR, LÜTFEN BEKLEYİNİZ...');
}

void notlaryukleniyor(BuildContext context) {
  snackgetir(context, 'Tüm veriler yükleniyor, bu işlem biraz zaman alabilir');
}
