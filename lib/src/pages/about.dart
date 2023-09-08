import 'package:flutter/material.dart';
import 'package:ope_mugclub/src/components/navigator.dart';

class AboutPage extends StatelessWidget {

    const AboutPage({super.key});

    @override
    Widget build(BuildContext context) {

        return Scaffold(
            drawer: const NavBar(),
            appBar: AppBar(
                title: const Text('About'),
            ),
            body: _buildPage(),
        );
    }

    Widget _buildPage() {
        return Container(
            margin: const EdgeInsets.all(50),
            child: const Column(
                children: <Widget> [
                    Center(
                        child: Image(
                            image: AssetImage('assets/beer_mugs.png'),
                            height: 200,
                            width: 200,
                        ),
                    ),
                    Text('Bla bla bla bla bla'),
                ],
        )
        );

    }

}
