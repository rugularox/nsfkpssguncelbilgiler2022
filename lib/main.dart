import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Sabitler.dart';
import 'StateData.dart';
import 'guncelBildirimDetay.dart';
import 'guncelBilgiler.dart';
import 'guncelSorular.dart';
import 'guncel_denemeler_ana.dart';
import 'notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  NotificationService().initNotification();

  runApp(ChangeNotifierProvider<StateData>(
      create: (BuildContext context) => StateData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AnaSayfam(),
        navigatorKey: navigatorKey,
      )));
}

class AnaSayfam extends StatefulWidget {
  @override
  State<AnaSayfam> createState() => _AnaSayfamState();
}

class _AnaSayfamState extends State<AnaSayfam> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  String notificationTitle = 'No Title';
  String notificationBody = 'No Body';
  String notificationData = 'No Data';

  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  _changeData(String msg) => setState(() => notificationData = msg);
  _changeBody(String msg) => setState(() => notificationBody = msg);
  _changeTitle(String msg) => setState(() => notificationTitle = msg);

  @override
  void initState() {
    NotificationService().showNotification(1, 'Bilgi', 'Body');
    loadBanneAds();
    super.initState();
  }

  void dispose() {
    // TODO: Dispose a BannerAd object
    _bannerAd.dispose();

    super.dispose();
  }

  Future<void> showntf() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GuncelBildirimDetay(1, 1, 'Bilgi')));
  }

  void loadBanneAds() {
    _bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: guncelbanner,
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

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  Widget build(BuildContext context) {
    String secilitap = Provider.of<StateData>(context).secilentab;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[800],
          title: Text(secili[secilitap].toString()),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                  child: Text('Seçenekler'),
                  decoration: BoxDecoration(color: Colors.lightBlue)),
              ListTile(
                leading: Icon(Icons.list),
                title: Text('Kpss 2023 Güncel Bilgiler'),
                onTap: () {
                  nettenyukleniyor(context);
                  Provider.of<StateData>(context, listen: false).yenitab('tum');
                  Navigator.pop(context);
                  ;
                },
              ),
/*              ListTile(
                leading: Icon(Icons.star),
                title: Text('2022-2023 Güncel Bilgiler'),
                onTap: () {
                  nettenyukleniyor(context);
                  Navigator.pop(context);
                  //     setState(() {
                  Provider.of<StateData>(context, listen: false)
                      .yenitab('guncel');
                },
              ),*/
              ListTile(
                //   tileColor: Colors.lightGreen,
                leading: Icon(Icons.question_mark),
                title: Text('Güncel Bilgiler Soruları'),
                onTap: () {
                  nettenyukleniyor(context);
                  Navigator.pop(context);
                  Provider.of<StateData>(context, listen: false)
                      .yenitab('guncelsoru');
                },
              ),
              ListTile(
                //   tileColor: Colors.lightGreen,
                leading: Icon(Icons.question_mark),
                title: Text('Güncel Bilgiler Denemeleri'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GuncelDenemelerAna()));
                  // Provider.of<StateData>(context, listen: false)
                  //     .yenitab('gunceldeneme');
                },
              ),
/*              ListTile(
                leading: Icon(Icons.filter_list_sharp),
                //   tileColor: Colors.lightGreen,
                title: Text('Genel Kültürel Bilgiler'),
                onTap: () {
                  Navigator.pop(context);
                  //     setState(() {
                  Provider.of<StateData>(context, listen: false)
                      .yenitab('kultur');
                },
              ),*/
              ListTile(
                leading: Icon(Icons.play_arrow),
                //   tileColor: Colors.lightGreen,
                title: Text('Kpss Tarih Soruları'),
                onTap: () {
                  //  Navigator.pop(context);
                  //     setState(() {
                  _launchInBrowser(kpsstarihsoruadres);
                  //  openlinkkpsshazirlik();
                },
              ),
              ListTile(
                leading: Icon(Icons.play_arrow),
                //   tileColor: Colors.lightGreen,
                title: Text('Kpss 2022 Hazırlık Seti'),
                onTap: () {
                  //  Navigator.pop(context);
                  //     setState(() {
                  _launchInBrowser(kpsshazirlikadres);
                  //  openlinkkpsshazirlik();
                },
              ),
            ],
          ),
        ),
        body: Column(
          //  mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // if (_isBannerAdReady)
            //   Container(
            //     height: _bannerAd.size.height.toDouble(),
            //     width: _bannerAd.size.width.toDouble(),
            //     child: AdWidget(
            //       ad: _bannerAd,
            //     ),
            //   ),
            Expanded(
              //      flex: 5,
              child: Container(
                  child: (secilitap == 'guncel' ||
                          secilitap == 'tum' ||
                          secilitap == 'kultur')
                      ? DetaySayfamGuncel(secilitab: secilitap)
                      : GuncelSorular(secilitab: secilitap)),
            )
          ],
        ),
        bottomNavigationBar: Container(
          height: _bannerAd.size.height.toDouble(),
          //  width: _bannerAd.size.width.toDouble(),
          width: double.infinity,
          child: _isBannerAdReady
              ? AdWidget(
                  ad: _bannerAd,
                )
              : Text(''),
          //  child: Text(_isBannerAdReady.toString() +
          //      'BANNER REKLAM BURADA OLACAK'),
        ),
      ),
    );
  }
}
