import 'package:flutter/material.dart';
import 'package:ope_mugclub/src/components/qr_scanner.dart';
import 'package:ope_mugclub/src/utils/firebase_methods.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:ope_mugclub/src/components/styles/global_styles.dart';
import './new_member_page.dart';
import './return_member_page.dart';
import '../components/navigator.dart';
import '../backend/server.dart';
import '../components/styles/global_styles.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = 'OPE Mug Club';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final double buttonWidth = 200;
    Future? _data;
    Barcode? qrCode;
    bool scanned = false;
    bool returnMember = false;

  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 18),
    fixedSize: const Size.fromWidth(200),
    elevation: 2.0,
  );

    @override
    void initState() {
        super.initState();
        _data = Server.database.get();
    }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.


    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: buildButtons(),
    );
  }

  Widget buildButtons() {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(
              top: 100,
              bottom: 50,
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: const Image(
                    image: AssetImage('assets/beer_mugs.png'),
                    width: 100,
                    height: 100,
                  ),
                ),
                Text(
                  'Mug Club',
                  style: Styles.homepageHeader,
                ),
              ],
            ),
          ),
          Builder(
              builder: (BuildContext context) {
                  if (scanned) {
                          return FutureBuilder(
                            future: _data,
                            builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data.containsKey(qrCode)) {
                                      String? name;
                                      snapshot.data.child(qrCode).forEach((child) {
                                          Map<dynamic, dynamic> data = child.value! as Map<dynamic, dynamic>;
                                          name = data["first"] as String?;
                                      });
                                      return ElevatedButton(
                                          style: buttonStyle,
                                          onPressed:() {},
                                          child: Text('Check In $name.'),);
                                  } else
                                } else {
                                    return const CircularProgressIndicator();
                                }
                            }
                            );
                      } else if (returnMember) {
                          return ElevatedButton(
                            style: buttonStyle,
                            onPressed:() {},
                            child: const Text('Returning Member'),);
                } else {
                  return ElevatedButton(
                    style: buttonStyle,
                    onPressed: () async {
                      qrCode = await Navigator.of(context).push(
                        MaterialPageRoute<Barcode>(
                            builder: (context) => const QRScanner(),
                        ),
                    );
                      _updateHome();
                    },
                    child: const Text('Scan QrCode'),
                  );
                  }
              },
              ),
        ],
      ),
    );
  }

  void _updateHome(Barcode? bcode) {
    setState(() {
        scanned = true;
    });
}

  bool _checkDuplicate(Barcode? bcode) {
      return exists;
  }
}
