import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import '../models/user.dart';
import 'package:ope_mugclub/src/backend/server.dart';

class FireMethods {

    static void updateVisits({required int visits, required String qrCode, required DatabaseReference database}) {
        database.update({
            "$qrCode/visits" : '$visits',
        }).then((_) => debugPrint('visits updated'))
        .catchError((error) => debugPrint('visits update error! $error'));
    }
}
