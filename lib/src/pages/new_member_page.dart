import 'package:flutter/material.dart';

import './member_info_confirm_page.dart';
// import './homepage.dart';

class NewMemberPage extends StatefulWidget {
  final String? qrCode;

  const NewMemberPage({super.key, this.qrCode});

  @override
  State<NewMemberPage> createState() => _NewMemberPageState();
}

class _NewMemberPageState extends State<NewMemberPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String pageTitle = 'New Member';
  String? first;
  String? last;
  String? email;
  String? phone;
  int state = 1;

  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 18),
    fixedSize: const Size.fromWidth(200),
    elevation: 2.0,
  );

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
    return Center(
      child: FocusTraversalGroup(
        child: Form(
          key: _formKey,
          onChanged: () {
            Form.of(primaryFocus!.context!).save();
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(
                  bottom: 25,
                  left: 25,
                  right: 25,
                ),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Enter Member Info',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              Container(
                width: 350,
                margin: const EdgeInsets.symmetric(
                  vertical: 25,
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "First Name",
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: const BorderSide(),
                          ),
                        ),
                        validator: (String? val) {
                          if (val == null || val.isEmpty) {
                            return 'Please Enter a Name';
                          } else {
                            first = val;
                            return null;
                          }
                        },
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    Container(
                      width: 150,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Last Name",
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: const BorderSide(),
                          ),
                        ),
                        validator: (String? val) {
                          if (val == null || val.isEmpty) {
                            return 'Please Enter a Name';
                          } else {
                            last = val;
                            return null;
                          }
                        },
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 350,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Email",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(),
                    ),
                  ),
                  validator: (String? val) {
                    if (val == null || val.isEmpty || !val.contains('@')) {
                      return 'Please Enter a Email Address';
                    } else {
                      email = val;
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                ),
              ),
              Container(
                width: 350,
                margin: const EdgeInsets.symmetric(
                  vertical: 25,
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Phone",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(),
                    ),
                  ),
                  validator: (String? val) {
                    if (val == null || val.isEmpty || val.length != 10) {
                      return 'Please Enter a Phone Number';
                    } else {
                      phone = val;
                      return null;
                    }
                  },
                  keyboardType: TextInputType.number,
                ),
              ),
              Container(
                width: 350,
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: buttonStyle,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MemberInfoConfirmPage(
                              first: first,
                              last: last,
                              email: email,
                              phone: phone,
                              qrCode: widget.qrCode),
                        ),
                      );
                    }
                  },
                  child: const Text('Continue'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Member Info'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('First: $first'),
          Text('Last: $last'),
          Text('Email: $email'),
          Text('Phone: $phone'),
        ],
      ),
      actions: <Widget>[
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
