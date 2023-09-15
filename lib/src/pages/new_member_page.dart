import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/user.dart';
import '../backend/server.dart';

class NewMemberPage extends StatefulWidget {
  final String qrCode;

  const NewMemberPage({super.key, required this.qrCode});

  @override
  State<NewMemberPage> createState() => _NewMemberPageState();
}

class _NewMemberPageState extends State<NewMemberPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String pageTitle = 'New Member';
  final Uri _url = Uri.parse('https://app.termly.io/document/privacy-policy/df56a474-b295-4655-8c50-6332ed8dfde1');
  User user = User();
  int state = 1;
  bool confirm = false;
  bool loading = false;

  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 18),
    fixedSize: const Size.fromWidth(200),
    elevation: 2.0,
  );

  @override
  void initState() {
      super.initState();
      user = User(qrCode: widget.qrCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: Center(
          child: _buldPage(),
      ),
    );
  }

  Widget _buldPage() {
      if (!confirm) {
      return FocusTraversalGroup(
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
                            user.setFirst(
                                first: val);
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
                            user.setLast(
                                last: val);
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
                    if (val == null || val.isEmpty || RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) == false) {
                      return 'Please Enter an Email Address';
                    } else {
                      user.setEmail(
                          email: val);
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
                      user.setPhone(
                          phone: val.substring(0, 3) + '-' + val.substring(3, 6) + '-' + val.substring(6, 10));
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
                  onPressed: () async {
                      bool userConfirm = false;
                      bool isLoading = true;

                      if (_formKey.currentState!.validate()) {
                      userConfirm = await _buildPopupDialog(context);
                      }

                      // TODO: update server upon user confirmation
                      setState(() {
                          confirm = userConfirm;
                          loading = isLoading;
                      });

                      isLoading = !(await _addUser(user));

                      setState(() {
                          loading = isLoading;
                      }
                      );
                  },
                  child: const Text('Continue'),
                ),
              ),
            ],
          ),
          ),
        );
      } else if (loading) {
            return const CircularProgressIndicator();
      } else {
          return const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 250,
          );
      }
  }

  Future _buildPopupDialog (BuildContext context) {
      TextStyle infoStyle = const TextStyle(fontSize: 20.0);
      return showDialog<bool> (
          context: context,
          builder: (BuildContext context) => AlertDialog(
              title: const Text('Member Info'),
              content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                      Text('First: ${user.getFirst()}', style: infoStyle,),
                      Text('Last: ${user.getLast()}', style: infoStyle,),
                      Text('Email: ${user.getEmail()}', style: infoStyle,),
                      Text('Phone: ${user.getPhone()}', style: infoStyle,),
                      _buildTerms(),
                  ],
              ),
              actions: <Widget>[
                  OutlinedButton(
                      onPressed: () {
                          Navigator.of(context).pop(true);
                      },
                      child: const Text('Confirm'),
                  ),
              ],
              )
        );
  }

  Future _addUser(User user) {
      bool added = false;
    Server.database.child(widget.qrCode).set(user.toDict())
            .then((_) {
                added = true;
            });
    return Future.value(!added);
  }

  Widget _buildTerms() {
      TextStyle defaultStyle = const TextStyle(color: Colors.grey, fontSize: 10.0);
      TextStyle linkStyle = const TextStyle(color: Colors.blue, fontSize: 12.0);
      return RichText(
          text: TextSpan(
              style: defaultStyle,
              children: <TextSpan>[
                  const TextSpan(text: 'By clicking Sign Up, you agree to our '),
                  TextSpan(
                      text: 'Privacy Policy',
                      style: linkStyle,
                      recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        if (!await launchUrl(_url)) {
                            throw Exception('Could not launch $_url');
                        }
                      }),
              ],
          ),
          );
  }

  void _update(bool update) {
    
    setState(() {
        confirm = update;
    }
    );
  }

}
