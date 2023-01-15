import 'package:flutter/material.dart';
import 'package:ope_mugclub/src/components/styles/global_styles.dart';
import '../models/user.dart';
import '../backend/server.dart';

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
  String first = 'first';
  String last = 'last';
  String email = 'email';
  String phone = 'phone';
  bool stringFixed = false;
  bool _infoConfirmed = false;
  @override
  Widget build(BuildContext context) {
    if (!stringFixed) {
      _fixString();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Info'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 100,
          ),
          child: ListView(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                ),
                alignment: Alignment.center,
                child: Text(
                  'Name:  $first $last',
                  style: Styles.secondaryHeader,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                ),
                alignment: Alignment.center,
                child: Text(
                  'Email: $email',
                  style: Styles.secondaryHeader,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                ),
                alignment: Alignment.center,
                child: Text(
                  'Phone: $phone',
                  style: Styles.secondaryHeader,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                ),
                alignment: Alignment.center,
                child: Text(
                  'QR Code: ${widget.qrCode}',
                  style: Styles.secondaryHeader,
                ),
              ),
              _response(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _response() {
    if (!_infoConfirmed) {
      return ElevatedButton(
        style: Styles.buttonStyle,
        onPressed: () {
          User newUser = User(
              first: first,
              last: last,
              email: email,
              phone: phone,
              qrCode: '${widget.qrCode}');
          Server.database
              .child('${widget.qrCode}/')
              .set(newUser.toDict())
              .then((_) {
            debugPrint('Member\'s info written');
            setState(() {
              _infoConfirmed = true;
            });
          }).catchError(
                  (error) => debugPrint('Error writting to Database! $error'));
        },
        child: const Text('Confirm Info'),
      );
    } else {
      return Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.green,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: const Text(
          'Member Added',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      );
    }
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
