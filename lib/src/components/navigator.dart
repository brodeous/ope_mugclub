import 'package:flutter/material.dart';
import 'package:ope_mugclub/src/components/styles/global_styles.dart';

import '../backend/server.dart';
import '../pages/about.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          Card(
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              splashColor: Colors.teal.withAlpha(100),
              onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder:(context) => AboutPage(),
                      ),
                  );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Text(
                  'About',
                  style: Styles.secondaryHeader,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
