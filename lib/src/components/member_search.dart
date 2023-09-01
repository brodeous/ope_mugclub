import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../pages/return_member_page.dart';
import '../components/styles/global_styles.dart';
import '../backend/server.dart';


class CustomSearchDelegate extends SearchDelegate {

  // first overwrite to
  // clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () async {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<DataSnapshot>(
        future: Server.database.get(),
        builder: (context, snapshot) {
            if (snapshot.hasData) {
                List<Map<dynamic, dynamic>> matchQuery = [];
                Map<dynamic, dynamic> members = Map<dynamic, dynamic>.from(snapshot.data?.value as Map<dynamic, dynamic>);
                members.forEach((key, value) {
                    final memberInfo = Map<dynamic, dynamic>.from(value);
                    String memberName = memberInfo['first'] + memberInfo['last'];
                    if (memberName.toLowerCase().contains(query.toLowerCase())) {
                        matchQuery.add(memberInfo);
                    }
                } );
                return ListView.builder(
                    itemCount: matchQuery.length,
                    itemBuilder: (context, index) {
                        var result = matchQuery[index];
                        return ListTile(
                            minVerticalPadding: 5.0,
                            title: Text(
                                '${result['first']} ${result['last']}',
                                style: Styles.secondaryHeader,
                            ),
                            trailing: Text(
                                result['visits'],
                                style: Styles.tileVisits,
                            ),
                            onTap: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder:(context) => ReturnMemberPage(qrCode: '${result['qrCode']}'),
                                    ),
                                );
                            }
                        );
                    },
                );
            } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
            } else {
                return const Center(
                    child: CircularProgressIndicator()
                );
            }
        });
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<DataSnapshot>(
        future: Server.database.get(),
        builder: (context, snapshot) {
            if (snapshot.hasData) {
                List<Map<dynamic, dynamic>> matchQuery = [];
                Map<dynamic, dynamic> members = Map<dynamic, dynamic>.from(snapshot.data?.value as Map<dynamic, dynamic>);
                members.forEach((key, value) {
                    final memberInfo = Map<dynamic, dynamic>.from(value);
                    String memberName = memberInfo['first'] + memberInfo['last'];
                    if (memberName.toLowerCase().contains(query.toLowerCase())) {
                        matchQuery.add(memberInfo);
                    }
                } );
                return ListView.builder(
                    itemCount: matchQuery.length,
                    itemBuilder: (context, index) {
                        var result = matchQuery[index];
                        return ListTile(
                            minVerticalPadding: 5.0,
                            title: Text(
                                '${result['first']} ${result['last']}',
                                style: Styles.secondaryHeader,
                            ),
                            trailing: Text(
                                result['visits'],
                                style: Styles.tileVisits,
                            ),
                            onTap: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder:(context) => ReturnMemberPage(qrCode: '${result['qrCode']}'),
                                    ),
                                );
                            }
                        );
                    },
                );
            } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
            } else {
                return const Center(
                    child: CircularProgressIndicator()
                );
            }
        });
  }
}
