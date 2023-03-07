import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';

import 'Sabitler.dart';
import 'datalar.dart';
import 'guncelSorular.dart';

class DetaySayfamGuncel extends StatefulWidget {
  String secilitab = 'tum';
  DetaySayfamGuncel({required this.secilitab});

  @override
  State<DetaySayfamGuncel> createState() => _DetaySayfamGuncelState();
}

class _DetaySayfamGuncelState extends State<DetaySayfamGuncel> {
  Future<List<Gunceldata>> fetchGunceller() async {
    var url;

    switch (widget.secilitab) {
      case 'tum':
        {
          url = Uri.parse(
              'https://www.guncelkpssbilgi.com/flutter/Gunceller.php');
        }
        break;
      case 'guncel':
        {
          url = Uri.parse(
              'https://www.guncelkpssbilgi.com/flutter/SadeceGuncel.php');
        }
        break;

      case 'kultur':
        {
          url = Uri.parse('https://www.guncelkpssbilgi.com/flutter/Kultur.php');
        }
        break;
    }

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

  @override
  Widget build(BuildContext context) {
    List colors = [Colors.blue[100], Colors.white];
    return Scaffold(
      body: Container(
        child: FutureBuilder<List<Gunceldata>>(
          future: fetchGunceller(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());

            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext ctx, int index) {
                return ListTile(
                  tileColor: colors[index % colors.length],
                  title: Text((index + 1).toString() +
                      '- ' +
                      snapshot.data![index].baslik),
                  onTap: () {
                    navigateToDetail(snapshot, index, widget.secilitab);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  void navigateToDetail(
      AsyncSnapshot<List<Gunceldata>> data, int index, String secilitab) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailGuncel(data, index, secilitab)));
  }
}

class DetailGuncel extends StatefulWidget {
  int index;
  final AsyncSnapshot<List<Gunceldata>> data;
  String secilitab;
  DetailGuncel(this.data, this.index, this.secilitab);

  @override
  State<DetailGuncel> createState() => _DetailGuncelState();
}

class _DetailGuncelState extends State<DetailGuncel> {
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;
  InterstitialAd? _interstitialAd;
  int bilgindex = 1;
  void _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: guncelbilgilergecis,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          _interstitialAd = null;
          _createInterstitialAd();
        },
      ),
    );
  }

  void loadBanneAds() {
    _bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: gunceldetaybanner,
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
    _createInterstitialAd();
    super.initState();
  }

  void dispose() {
    // TODO: Dispose a BannerAd object
    _bannerAd.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }

  void _showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          ad.dispose();
          _createInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          ad.dispose();
          _createInterstitialAd();
        },
      );
      _interstitialAd!.show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Detay')),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.only(left: 10),
                child: Center(
                  child: Text(
                    widget.data.data![widget.index].baslik,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),

            Expanded(
              flex: 5,
              child: Container(
                width: double.infinity,
                color: Colors.yellow[100],
                padding: EdgeInsets.only(left: 10, top: 10),
                child: SingleChildScrollView(
                    child: Text(
                  widget.data.data![widget.index].aciklama,
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
                child: nabigationDetay(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row nabigationDetay(BuildContext context) {
    Random random = new Random();
    return Row(
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
              bilgindex--;
              widget.index > 0 ? widget.index-- : widget.index;
            });
          },
        ),
        IconButton(
          icon: Icon(
            Icons.navigate_next_outlined,
            size: 30,
          ),
          onPressed: () {
            if (bilgindex % 10 == 0) {
              _showInterstitialAd();
            }
            setState(() {
              bilgindex++;
              widget.index < widget.data.data!.length + -1
                  ? widget.index++
                  : widget.index;
            });
          },
        ),
        IconButton(
          icon: Icon(
            Icons.refresh,
            size: 30,
          ),
          onPressed: () {
            if (bilgindex % 10 == 0) {
              _showInterstitialAd();
            }
            setState(() {
              bilgindex++;

              widget.index < widget.data.data!.length + -1
                  ? widget.index = random.nextInt(widget.data.data!.length - 1)
                  : widget.index;
            });
          },
        ),
        IconButton(
          icon: Icon(
            Icons.question_mark,
            size: 30,
          ),
          onPressed: () {
            //   Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => GuncelSorular(secilitab: 'soru')));
          },
        ),
        IconButton(
          onPressed: () {
            final url = 'https://www.guncelkpssbilgi.com/';
            // await Share.share('${textdata.value.text} ${url}');

            Share.share('"' +
                widget.data.data![widget.index].aciklama +
                '"' +
                '  ' +
                '${url}');
          },
          icon: Icon(Icons.share),
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
    );
  }
}
