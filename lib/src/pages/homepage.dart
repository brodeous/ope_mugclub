import 'package:flutter/material.dart';
import 'package:ope_mugclub/src/components/qr_scanner.dart';
import 'package:ope_mugclub/src/components/styles/global_styles.dart';
import './new_member_page.dart';
import './return_member_page.dart';
import '../components/navigator.dart';
import '../backend/server.dart';

class MyHomePage extends StatelessWidget {
    MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = 'OPE Mug Club';

  // final double buttonWidth = 200;

  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 18),
    fixedSize: const Size.fromWidth(200),
    elevation: 2.0,
  );

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
        title: Text(title),
      ),
      body:  Center(
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
              ElevatedButton(
                style: buttonStyle,
                onPressed: () {
                  _onPressed(context);
                },
                child: const Text('Scan Qrcode'),
              ),
            ],
          ),
        )
      );
  }

  Future<dynamic> _onPressed(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => QRScanner(database: Server.database, version: 0),
      ),
    );
  }

}
