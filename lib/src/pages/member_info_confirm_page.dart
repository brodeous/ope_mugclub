import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/user.dart';

class MemberInfoConfirmPage extends StatefulWidget {
  final String? first;
  final String? last;
  final String? email;
  final String? phone;
  final String? qrCode;

  const MemberInfoConfirmPage(
      {super.key, this.first, this.last, this.email, this.phone, this.qrCode});

  @override
  State<MemberInfoConfirmPage> createState() => _MemberInfoConfirmPageState();
}

class _MemberInfoConfirmPageState extends State<MemberInfoConfirmPage> {
  final database = FirebaseDatabase.instance.ref();
  String first = 'first';
  String last = 'last';
  String email = 'email';
  String phone = 'phone';
  bool stringFixed = false;
  @override
  Widget build(BuildContext context) {
    final memberInfoRef = database.child('memberData/');

    if (!stringFixed) {
      _fixString();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Info'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('Name:  $first $last'),
            Text('Email: $email'),
            Text('Phone: $phone'),
            Text('QR Code: ${widget.qrCode}'),
            ElevatedButton(
              onPressed: () {
                User newUser = User(
                    first: first,
                    last: last,
                    email: email,
                    phone: phone,
                    qrCode: '${widget.qrCode}');
                memberInfoRef
                    .child('${widget.qrCode}/')
                    .set(newUser.toDict())
                    .then((_) => debugPrint('Member\'s info written'))
                    .catchError((error) =>
                        debugPrint('Error writting to Database! $error'));
              },
              child: const Text('Confirm Member\'s Info'),
            ),
          ],
        ),
      ),
    );
  }

  void _fixString() {
    String phoneTMP = '${widget.phone}';

    String first =
        '${widget.first?[0].toUpperCase()}${widget.first?.substring(1, widget.first?.length)}';
    String last =
        '${widget.last?[0].toUpperCase()}${widget.last?.substring(1, widget.last?.length)}';
    String email = '${widget.email}';
    String phone =
        '${phoneTMP.substring(0, 3)}-${phoneTMP.substring(3, 6)}-${phoneTMP.substring(6, 10)}';

    setState(() {
      this.first = first;
      this.last = last;
      this.email = email;
      this.phone = phone;
      this.stringFixed = true;
    });
  }
}
