import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;

import 'Sabitler.dart';
import 'datalar.dart';

class GuncelBildirimDetay extends StatefulWidget {
  int index;
  int bildirim_state = 0;
  String bildirim = '';
  GuncelBildirimDetay(this.index, this.bildirim_state, this.bildirim);

  @override
  State<GuncelBildirimDetay> createState() => _GuncelBildirimDetayState();
}

class _GuncelBildirimDetayState extends State<GuncelBildirimDetay> {
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  Future<List<Gunceldata>> fetchGunceller() async {
    var url =
        Uri.parse('https://www.guncelkpssbilgi.com/flutter/Gunceller.php');

    var response =
        await http.get(url, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<Gunceldata> guncelList = items.map<Gunceldata>((json) {
        return Gunceldata.fromJson(json);
      }).toList();
      //    print(guncelList);
      return guncelList;
    } else {
      throw Exception('Failed to load data from Server.');
    }
  }

  void loadBanneAds() {
    _bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: guncelbildirimdetaybanner,
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
    // detaybilgisi dtb =
    //     ModalRoute.of(context)?.settings.arguments as detaybilgisi;

    // print('DERAY YAZDIRILIYORRRR');
    // print(dtb.title);
    // print(dtb.body);
    // print(dtb.id);
    // print('BİLDİRİM STATE:' + widget.bildirim_state.toString());

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(title: Text('Detay')),
          body: FutureBuilder<List<Gunceldata>>(
              future: fetchGunceller(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        child: Center(
                          child: Text(
                            (widget.bildirim_state == 1)
                                ? widget.bildirim
                                : snapshot.data![widget.index].baslik,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 6,
                      child: Container(
                        width: double.infinity,
                        color: Colors.yellow[100],
                        padding: EdgeInsets.all(4),
                        child: SingleChildScrollView(
                            child: Text(
                          (widget.bildirim_state == 1)
                              ? widget.bildirim
                              : snapshot.data![widget.index].aciklama,
                          style: TextStyle(fontSize: 16),
                        )),
                      ),
                    ),
                    if (_isBannerAdReady)
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: _bannerAd.size.height.toDouble(),
//  width: _bannerAd.size.width.toDouble(),
                          width: double.infinity,
                          child: AdWidget(
                            ad: _bannerAd,
                          ),
//  child: Text(_isBannerAdReady.toString() +
//      'BANNER REKLAM BURADA OLACAK'),
                        ),
                      ),
                    Divider(
                      height: 10,
                      color: Colors.deepPurple,
                      thickness: 3,
                    ),
//getDetailedData(data, widget.index),
//     Text(widget.index.toString()),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.navigate_before,
                                size: 30,
                              ),
                              onPressed: () {
                                setState(() {
                                  widget.bildirim_state = 0;
                                  widget.index > 0
                                      ? widget.index--
                                      : widget.index;
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.navigate_next_outlined,
                                size: 30,
                              ),
                              onPressed: () {
                                setState(() {
                                  widget.bildirim_state = 0;
                                  widget.index < snapshot.data!.length + -1
                                      ? widget.index++
                                      : widget.index;
                                });
                              },
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'LİSTE',
                                  style: TextStyle(fontSize: 20),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              })),
    );
  }
}
