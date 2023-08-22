import 'package:flutter/material.dart';
import 'package:ope_mugclub/src/components/qr_scanner.dart';
import 'package:ope_mugclub/src/components/styles/global_styles.dart';
import 'package:ope_mugclub/src/pages/member_list.dart';

import '../backend/server.dart';

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
                    builder: (context) =>
                        QRScanner(context: context),
                  ),
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Text(
                  'Add Member',
                  style: Styles.secondaryHeader,
                ),
              ),
            ),
          ),
          Card(
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              splashColor: Colors.teal.withAlpha(100),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        QRScanner(context: context),
                  ),
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Text(
                  'Scan Qrcode',
                  style: Styles.secondaryHeader,
                ),
              ),
            ),
          ),
          Card(
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              splashColor: Colors.teal.withAlpha(100),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MemberList(),
                  ),
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Text(
                  'Member List',
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
