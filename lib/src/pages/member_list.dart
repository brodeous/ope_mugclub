import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ope_mugclub/src/components/styles/global_styles.dart';
import '../backend/server.dart';

class MemberList extends StatefulWidget {
  const MemberList({super.key});

  @override
  State<MemberList> createState() => _MemberListState();
}

class _MemberListState extends State<MemberList> {
  bool listBuilt = false;
  var qrCodes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Members'),
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return StreamBuilder(
      stream: Server.database.onValue,
      builder: (context, snapshot) {
        final tilesList = <ListTile>[];
        if (snapshot.hasData) {
          final qrCodes =
              snapshot.data!.snapshot.value as Map<Object?, dynamic>;
          qrCodes.forEach((key, value) {
            final memberInfo = Map<String, dynamic>.from(value);
            final memberTile = ListTile(
              minVerticalPadding: 5.0,
              title: Text(
                '${memberInfo['first']} ${memberInfo['last']}',
                style: Styles.secondaryHeader,
              ),
              trailing: Text(
                memberInfo['visits'],
                style: Styles.tileVisits,
              ),
            );
            tilesList.add(memberTile);
          });
        }
        return ListView(
          children: tilesList,
        );
      },
    );
  }
}
