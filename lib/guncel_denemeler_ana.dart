import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Sabitler.dart';
import 'guncel_deneme_web_detay.dart';

class GuncelDenemelerAna extends StatefulWidget {
  @override
  State<GuncelDenemelerAna> createState() => _GuncelDenemelerAnaState();
}

class _GuncelDenemelerAnaState extends State<GuncelDenemelerAna> {
  // const TarihKonu({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Güncel Bilgiler Denemeleri'),
        ),
        body: ListView(
          children: [
            ListTile(
              title: (Text('SEÇİM YAPINIZ')),
              tileColor: Colors.black,
              textColor: Colors.white,
            ),
            GuncelDenemeListele(context, 1),
            GuncelDenemeListele(context, 2),
            GuncelDenemeListele(context, 3),
            GuncelDenemeListele(context, 4),
            GuncelDenemeListele(context, 5),
            GuncelDenemeListele(context, 6),
            GuncelDenemeListele(context, 7),
            GuncelDenemeListele(context, 8),
            GuncelDenemeListele(context, 9),
            GuncelDenemeListele(context, 10),
            GuncelDenemeListele(context, 11),
            GuncelDenemeListele(context, 12),
            GuncelDenemeListele(context, 13),
            GuncelDenemeListele(context, 14),
          ],
        ),
      ),
    );
  }

  ListTile GuncelDenemeListele(BuildContext context, int id) {
    return ListTile(
      title: (Text(gunceldenemeler[id])),
      onTap: () {
        nettenyukleniyor(context);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => GuncelDenemeWebDetay(id)));
      },
    );
  }
}
