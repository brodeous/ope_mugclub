import 'package:flutter/material.dart';
import 'package:ope_mugclub/src/utils/firebase_methods.dart';
import '../components/styles/global_styles.dart';
import '../backend/server.dart';

class ReturnMemberPage extends StatefulWidget {
  final String qrCode;
  final bool checkIn;
  const ReturnMemberPage(
      {super.key, required this.qrCode, required this.checkIn});

  final String pageTitle = 'Returning Member';
  @override
  State<ReturnMemberPage> createState() => _ReturnPageState();
}

class _ReturnPageState extends State<ReturnMemberPage> {
    Future? _data;
    bool? check;

  @override
  void initState() {
      super.initState();
      _data = Server.database.child(widget.qrCode).get();
      check = widget.checkIn;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pageTitle),
        actions: const [
        ],
      ),

        body: Center(
            child: FutureBuilder(
                future: _data,
                builder: (context, snapshot) {
                    if (snapshot.hasError) {
                        return Text('Something went wrong! ${snapshot.error.toString()}');
                    } else if (snapshot.hasData) {
                        final info = snapshot.data.value as Map<Object?, dynamic>;
                        if (check) {
                            int visits = int.parse(info['visits']) + 1;
                            updateVisits(
                                visits: visits,
                                qrCode: qrCode,
                                database: Server.database.child(qrCode),
                            );
                            check = false;
                        }

                        return _children(info, context);
                    } else {
                        return const Center(
                            child: CircularProgressIndicator(),
                        );
                    }
                },
            )
        ),
  );
}


   Widget _children(snapshot, BuildContext context) {
           return Column(
             mainAxisSize: MainAxisSize.min,
               children: <Widget> [
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
                         snapshot['visits'],
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
                       '${snapshot['first']} ${snapshot['last']}',
                       style: Styles.primaryHeader,
                     ),
                   ),
                   Container(
                     width: MediaQuery.of(context).size.width * 0.85,
                     alignment: Alignment.centerRight,
                     child: Text(
                       snapshot['email'],
                       style: Styles.secondaryHeader,
                     ),
                   ),
                   Container(
                     width: MediaQuery.of(context).size.width * 0.85,
                     alignment: Alignment.centerRight,
                     child: Text(
                       snapshot['phone'],
                       style: Styles.secondaryHeader,
                     ),
                   ),
                 ]
             );
  }
}
