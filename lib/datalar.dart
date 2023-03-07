class Gunceldata {
  int guncelId;
  String baslik;
  String aciklama;
  int tur;

  Gunceldata(
      {required this.guncelId,
      required this.baslik,
      required this.aciklama,
      required this.tur});

  factory Gunceldata.fromJson(Map<String, dynamic> json) {
    return Gunceldata(
      guncelId: json['id'],
      baslik: json['baslik'],
      aciklama: json['aciklama'],
      tur: json['tur'],
    );
  }
}

class Sorulardata {
  int soruId;
  String soru;
  String a;
  String b;
  String c;
  String d;
  String e;
  String dogrusik;
  String dogrucevap;

  Sorulardata(
      {required this.soruId,
      required this.soru,
      required this.a,
      required this.b,
      required this.c,
      required this.d,
      required this.e,
      required this.dogrusik,
      required this.dogrucevap});

  factory Sorulardata.fromJson(Map<String, dynamic> json) {
    return Sorulardata(
        soruId: json['id'],
        soru: json['soru'],
        a: json['a'],
        b: json['b'],
        c: json['c'],
        d: json['d'],
        e: json['e'],
        dogrusik: json['dogrusik'],
        dogrucevap: json['dogrucevap']);
  }
}
