import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _dersadi;
  int dersKredi = 1;
  double dersHarfDegeri = 4;
  List<Ders> tumDersler;
  double ortalama = 0;
  var formkey = GlobalKey<FormState>();
  static int sayac = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tumDersler = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Ortalama Hesapla"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (formkey.currentState.validate()) {
              formkey.currentState.save();
            }
          });
        },
        child: Icon(Icons.add),
      ),
      body: uygulamaGovdesi(),
    );
  }

  Widget uygulamaGovdesi() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            color: Colors.white,
            child: Form(
              key: formkey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Ders Adı",
                      hintText: "Ders Adını Girin",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          borderSide: BorderSide(color: Colors.blue, width: 2)),
                    ),
                    // ignore: missing_return
                    validator: (girilenDeger) {
                      if (girilenDeger.length > 0) {
                        return null;
                      } else
                        return "Ders Adı Giriniz";
                    },
                    onSaved: (kaydedilecekDeger) {
                      setState(() {
                        _dersadi = kaydedilecekDeger;
                        tumDersler
                            .add(Ders(_dersadi, dersHarfDegeri, dersKredi));
                        ortalama = 0;
                        ortalamaHesapla();
                      });
                    },
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        margin: EdgeInsets.only(top: 10),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                              items: dersKrediItems(),
                              value: dersKredi,
                              onChanged: (secilenKredi) {
                                setState(() {
                                  dersKredi = secilenKredi;
                                });
                              }),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<double>(
                              items: dersHarfDegerleriItems(),
                              value: dersHarfDegeri,
                              onChanged: (secilenHarf) {
                                setState(() {
                                  dersHarfDegeri = secilenHarf;
                                });
                              }),
                        ),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.blueAccent, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Container(
                            height: 55,
                            margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2),
                            child: Center(
                              child: Text(
                                "Ortalama: ${ortalama.toStringAsFixed(2)}",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                border:
                                    Border.all(color: Colors.blue, width: 2)),
                          ),
                        ),
                      )
                    ],
                  ),
                  Divider(
                    color: Colors.blue,
                    height: 20,
                    indent: 2,
                    thickness: 1,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey.shade300,
              child: ListView.builder(
                itemBuilder: _listeElemanlari,
                itemCount: tumDersler.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<int>> dersKrediItems() {
    List<DropdownMenuItem<int>> krediler = [];

    for (int i = 1; i <= 10; i++) {
      krediler.add(
        DropdownMenuItem<int>(
          value: i,
          child: Text(
            "$i Kredi",
            style: TextStyle(fontSize: 24),
          ),
        ),
      );
    }

    return krediler;
  }

  List<DropdownMenuItem<double>> dersHarfDegerleriItems() {
    List<DropdownMenuItem<double>> harfler = [];

    harfler.add(
      DropdownMenuItem(
        child: Text(
          "AA",
          style: TextStyle(fontSize: 24),
        ),
        value: 4,
      ),
    );
    harfler.add(
      DropdownMenuItem(
        child: Text(
          "BA",
          style: TextStyle(fontSize: 24),
        ),
        value: 3.5,
      ),
    );
    harfler.add(
      DropdownMenuItem(
        child: Text(
          "BB",
          style: TextStyle(fontSize: 24),
        ),
        value: 3,
      ),
    );
    harfler.add(
      DropdownMenuItem(
        child: Text(
          "CB",
          style: TextStyle(fontSize: 24),
        ),
        value: 2.5,
      ),
    );
    harfler.add(
      DropdownMenuItem(
        child: Text(
          "CC",
          style: TextStyle(fontSize: 24),
        ),
        value: 2,
      ),
    );
    harfler.add(
      DropdownMenuItem(
        child: Text(
          "DC",
          style: TextStyle(fontSize: 24),
        ),
        value: 1.5,
      ),
    );
    harfler.add(
      DropdownMenuItem(
        child: Text(
          "DD",
          style: TextStyle(fontSize: 24),
        ),
        value: 1,
      ),
    );
    harfler.add(
      DropdownMenuItem(
        child: Text(
          "FF",
          style: TextStyle(fontSize: 24),
        ),
        value: 0,
      ),
    );
    return harfler;
  }

  Widget _listeElemanlari(BuildContext context, int index) {
    sayac++;

    return Dismissible(
      key: Key(sayac.toString()),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        setState(() {
          tumDersler.removeAt(index);
          ortalamaHesapla();
        });
      },
      child: Card(
        color: Colors.white,
        child: ListTile(
          title: Text(tumDersler[index].ad.toUpperCase()),
          subtitle: Text("Harf Değeri: " +
              tumDersler[index].harfDegeri.toString() +
              "     " +
              "Kredi: " +
              tumDersler[index].kredi.toString().toUpperCase()),
        ),
        elevation: 2,
      ),
    );
  }

  double ortalamaHesapla() {
    double toplamNot = 0;
    double toplamKredi = 0;
    if (tumDersler.length > 0) {
      for (var anlikDers in tumDersler) {
        var kredi = anlikDers.kredi;
        var harfDegeri = anlikDers.harfDegeri;

        toplamNot = toplamNot + harfDegeri * kredi;
        toplamKredi = toplamKredi + kredi;
      }
    } else
      return ortalama = 0;

    ortalama = toplamNot / toplamKredi;
  }
}

class Ders {
  //MODEL
  String ad;
  double harfDegeri;
  int kredi;

  Ders(this.ad, this.harfDegeri, this.kredi);
}
