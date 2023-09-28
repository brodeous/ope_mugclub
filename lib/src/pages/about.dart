import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {

    const AboutPage({super.key});

    @override
    State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
    final Uri _url = Uri.parse('https://app.termly.io/document/privacy-policy/df56a474-b295-4655-8c50-6332ed8dfde1');
    final TextStyle linkStyle = const TextStyle(color: Colors.blue, fontSize: 24.0);

    @override
    Widget build(BuildContext context) {

        return Scaffold(
            appBar: AppBar(
                title: const Text('About'),
            ),
            body: _buildPage(),
        );
    }

    Widget _buildPage() {
        return Container(
            margin: const EdgeInsets.all(50),
            child: Column(
                children: <Widget> [
                    const Center(
                        child: Image(
                            image: AssetImage('assets/beer_mugs.png'),
                            height: 200,
                            width: 200,
                        ),
                    ),
                    const SizedBox(
                        height: 50,
                    ),
                    RichText(text: 
                        TextSpan(
                            text: 'Privacy Policy',
                            style: linkStyle,
                            recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                                if (!await launchUrl(_url)) {
                                    throw Exception('Could not launch $_url');
                                }
                            }),
                    ),
                ],
        )
        );

    }

}
