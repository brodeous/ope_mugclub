import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import '../legal/legal.dart';
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
  Map<String, String> user = {'first' : '',
                                'last' : '',
                                'email' : '',
                                'phone' : ''};
  // String? first;
  // String? last;
  // String? email;
  // String? phone;
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
                            user['first'] = val;
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
                            user['last'] = val;
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
                      user['email'] = val;
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
                      user['phone'] = val;
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
                      _buildPopupDialog(context);
                      }
                    // if (_formKey.currentState!.validate()) {
                    //   Navigator.of(context).push(
                    //     MaterialPageRoute(
                    //       builder: (context) => MemberInfoConfirmPage(
                    //           first: first,
                    //           last: last,
                    //           email: email,
                    //           phone: phone,
                    //           qrCode: widget.qrCode),
                    //     ),
                    //   );
                    // }
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

  Future _buildPopupDialog(BuildContext context) {
      TextStyle infoStyle = const TextStyle(fontSize: 20.0);
      String phone = user['phone'] as String;
      return showDialog<String> (
          context: context,
          builder: (BuildContext context) => AlertDialog(
              title: const Text('Member Info'),
              content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                      Text('First: ${user['first']}', style: infoStyle,),
                      Text('Last: ${user['last']}', style: infoStyle,),
                      Text('Email: ${user['email']}', style: infoStyle,),
                      Text('Phone: ${phone.substring(0, 3)}-${phone.substring(3, 6)}-${phone.substring(6, 10)}', style: infoStyle,),
                      _buildTerms(),
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
              )
        );
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
                      text: 'Terms of Service',
                      style: linkStyle,
                      recognizer: TapGestureRecognizer()
                      ..onTap = () {
                          Terms(context);
                      }),
                  const TextSpan(text: ' and that you have read our '),
                  TextSpan(
                      text: 'Privacy Policy',
                      style: linkStyle,
                      recognizer: TapGestureRecognizer()
                      ..onTap = () {
                          Privacy(context);
                      }),
              ],
          ),
          );
  }
}
