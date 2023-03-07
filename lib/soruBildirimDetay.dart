import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'package:nsfkpssguncelbilgiler2022/datalar.dart';

import 'Sabitler.dart';

class SoruBildirimDetay extends StatefulWidget {
  int index;
  int bildirim_state = 0;

  SoruBildirimDetay(this.index, this.bildirim_state);
  @override
  State<SoruBildirimDetay> createState() => _SoruBildirimDetayState();
}

class _SoruBildirimDetayState extends State<SoruBildirimDetay> {
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  Future<List<Sorulardata>> fetchSorular() async {
    var url =
        Uri.parse('https://www.guncelkpssbilgi.com/flutter/GuncelSoru.php');

    var response =
        await http.get(url, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<Sorulardata> soruList = items.map<Sorulardata>((json) {
        return Gunceldata.fromJson(json);
      }).toList();
      //    print(guncelList);
      return soruList;
    } else {
      throw Exception('Failed to load data from Server.');
    }
  }

  void loadBanneAds() {
    _bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: sorubildirimdetaybanner,
        listener: BannerAdListener(onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        }, onAdFailedToLoad: (ad, error) {
          print('Failed to load Banner Ad${error.message}');
          _isBannerAdReady = false;
          ad.dispose();
        }),
        request: AdRequest())
      ..load();
  }

  void initState() {
    loadBanneAds();
    super.initState();
  }

  void dispose() {
    // TODO: Dispose a BannerAd object
    _bannerAd.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // detaybilgisisoru dtb =
    //     ModalRoute.of(context)?.settings.arguments as detaybilgisisoru;

    return Text('');
  }
}
