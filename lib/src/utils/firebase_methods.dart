import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import '../models/user.dart';

class FireMethods {

    static bool checkMemberExists({required String qrCode, required DataSnapshot data}) {
        
        return (data.hasChild(qrCode)) ? true : false;
    }

    static void updateVisits({required int visits, required String qrCode, required DatabaseReference database}) {
        database.update({
            "$qrCode/visits" : '$visits',
        }).then((_) => debugPrint('visits updated'))
        .catchError((error) => debugPrint('visits update error! $error'));
    }
}
