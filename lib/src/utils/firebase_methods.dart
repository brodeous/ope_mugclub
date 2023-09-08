import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import '../models/user.dart';
import 'package:ope_mugclub/src/backend/server.dart';


void updateVisitData({required int visits, required String qrCode, required DatabaseReference database}) {
    database.update({
        "$qrCode/visits" : '$visits',
    }).then((_) => debugPrint('visits updated'))
    .catchError((error) => debugPrint('visits update error! $error'));
}

Future<int> grabMemVisit({required String qrCode, required bool checkIn}) async {
    int visit = 0;

    await Server.database.child('$qrCode/visits').get().then((snapshot) {
        visit = int.parse('${snapshot.value}');
        if (checkIn) {
            visit = visit + 1;
            updateVisitData(visits: visit, qrCode: qrCode, database: Server.database);
        }
    });
     
    return Future.value(visit);
}
