import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ope_mugclub/src/utils/firebase_methods.dart';
import 'package:ope_mugclub/src/backend/server.dart';
import '../components/styles/global_styles.dart';
import '../backend/server.dart';

class ReturnMemberPage extends StatelessWidget {
  final String? qrCode;
  const ReturnMemberPage(
      {super.key, required this.qrCode});

  final String pageTitle = 'Returning Member';

//  int visits = 0;
//  String name = 'First Last';
//  bool hasGrabed = false;
  
//    void initState() async{ 
//       final visits = await Server.database.child('$qrCode').get();
//       if (visits.exists) {
//           final map = visits.value as Map<String, String>;
//           Server.database.child('$qrCode').update({'visits' : '${int.parse('${map['visits']}') + 1}'});
//       }
//    }

  @override
  Widget build(BuildContext context) {
  Future _data = Server.database.child('$qrCode').get();
      
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
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
                        final info =
                                snapshot.data!.snapshot.value as Map<Object?, dynamic>;
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
