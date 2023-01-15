import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ope_mugclub/src/utils/firebase_methods.dart';
import '../components/styles/global_styles.dart';
// import './homepage.dart';

class ReturnMemberPage extends StatefulWidget {
  final String? qrCode;
  final DatabaseReference database;
  const ReturnMemberPage(
      {super.key, required this.qrCode, required this.database});

  @override
  State<ReturnMemberPage> createState() => _ReturnMemberPageState();
}

class _ReturnMemberPageState extends State<ReturnMemberPage> {
  final String pageTitle = 'Returning Member';
  String name = 'First Last';
  String email = 'me@website.com';
  String phone = '555-555-5555';
  int visits = 0;
  bool hasGrabed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.list,
              color: Colors.white,
            ),
            tooltip: 'navigation',
          ),
        ],
      ),
      body: _buldPage(),
    );
  }

  Widget _buldPage() {
    if (!hasGrabed) {
      _grabInformation();
    }
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            alignment: Alignment.center,
            child: Text(
              'Visits',
              style: Styles.primaryHeader,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            alignment: Alignment.center,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              width: 100,
              child: Text(
                '$visits',
                style: Styles.displayVisits,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            padding: const EdgeInsets.symmetric(
              vertical: 25,
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              name,
              style: Styles.primaryHeader,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            alignment: Alignment.centerRight,
            child: Text(
              email,
              style: Styles.secondaryHeader,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            alignment: Alignment.centerRight,
            child: Text(
              phone,
              style: Styles.secondaryHeader,
            ),
          ),
        ],
      ),
    );
  }

  void _grabInformation() {
    widget.database.child('${widget.qrCode}').get().then((snapshot) {
      final userData =
          Map<String, dynamic>.from(snapshot.value! as Map<Object?, Object?>);
      final String name = '${userData['first']} ${userData['last']}';
      final String email = '${userData['email']}';
      final String phone = '${userData['phone']}';
      final int visits = int.parse('${userData['visits']}') + 1;

      FireMethods.updateVisits(
          qrCode: '${widget.qrCode}',
          visits: visits,
          database: widget.database);

      setState(() {
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.visits = visits;
        hasGrabed = true;
      });
    });
  }
}
