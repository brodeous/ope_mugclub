import 'package:flutter/material.dart';

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

    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 18), 
        fixedSize: const Size.fromWidth(200),
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
        appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text(widget.title),
            actions: const [
                IconButton(
                    onPressed: null,
                    icon: Icon(Icons.list, color: Colors.white,),
                    tooltip: 'navigation',
                ),
            ],
        ),
        body: buildButtons(),
    );
  }

    Widget buildButtons() {
        return Center(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget> [
                    Container(
                        margin: const EdgeInsets.only(bottom: 100),
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.teal,
                            ),
                        alignment: Alignment.center,
                        child: const Text('OPE',
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                ),
                            ),
                    ),
                    ElevatedButton(
                        style: buttonStyle,
                        onPressed: null, 
                        child: const Text('New Member'),
                    ),
                    const SizedBox(
                        height: 20,
                    ),
                    ElevatedButton(
                        style: buttonStyle,
                        onPressed: null,
                        child: const Text('Returning Member'),
                    ),
                ],
            ),
        );
    }
}
