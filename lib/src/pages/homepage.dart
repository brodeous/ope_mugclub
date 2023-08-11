import 'package:flutter/material.dart';
import 'package:ope_mugclub/src/components/qr_scanner.dart';
import 'package:ope_mugclub/src/components/styles/global_styles.dart';
import './new_member_page.dart';
import './return_member_page.dart';
import '../components/navigator.dart';
import '../backend/server.dart';

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
    String? qrCode;
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
                                    Map<dynamic, dynamic> map = snapshot.data.value as Map<dynamic, dynamic>;
                                  if (map.containsKey('$qrCode')) {

                                      // Set button for returning member
                                      Map<dynamic, dynamic> data = map[qrCode];
                                      String name = data['first'];
                                      return Column(
                                          children: [
                                              ElevatedButton(
                                                  style: buttonStyle,
                                                  onPressed:() {},
                                                  child: Text('Check In $name'),
                                              ),
                                              ElevatedButton(
                                                  style: buttonStyle,
                                                  onPressed: () async {
                                                      qrCode = await Navigator.of(context).push(
                                                          MaterialPageRoute<String>(
                                                              builder: (context) => const QRScanner(),
                                                          ),
                                                      );

                                                      // Update page state
                                                      _updateHome(qrCode);
                                                  },
                                                  child: const Text('Scan Again')
                                              ),
                                          ]);
                                  } else {

                                      // Set button for new member
                                      return Column(
                                          children: [
                                              ElevatedButton(
                                                  style: buttonStyle,
                                                      onPressed: () {}, 
                                                      child: Text('$qrCode'),
                                                  ),
                                              ElevatedButton(
                                                  style: buttonStyle,
                                                  onPressed: () async {
                                                      qrCode = await Navigator.of(context).push(
                                                          MaterialPageRoute<String>(
                                                              builder: (context) => const QRScanner(),
                                                          ),
                                                      );

                                                      // Update page state
                                                      _updateHome(qrCode);
                                                    },
                                                    child: const Text('Scan Again')
                                              ),
                                          ]);
                                  }
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
                        MaterialPageRoute<String>(
                            builder: (context) => const QRScanner(),
                        ),
                    );

                      // Update page state
                      _updateHome(qrCode);
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

  void _updateHome(String? bcode) {
    setState(() {
        scanned = true;
        qrCode = bcode;
    });
}

  //bool _checkDuplicate(Barcode? bcode) {
      //return exists;
  //}
}
