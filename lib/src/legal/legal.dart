import 'package:flutter/material.dart';

Future Terms(BuildContext context) {

    return showDialog<String> (
        context: context,
        builder: (BuildContext context) => AlertDialog(
            title: const Text('Terms of Service'),
            actions: <Widget>[
                OutlinedButton(
                    onPressed: () {
                        Navigator.of(context).pop();
                    },
                    child: const Text('Close'),
                ),
            ],
            scrollable: true,
        )
    );
}

Future Privacy(BuildContext context) {

    return showDialog<String> (
        context: context,
        builder: (BuildContext context) => AlertDialog(
            title: const Text('Privacy Policy'),
            actions: <Widget>[
                OutlinedButton(
                    onPressed: () {
                        Navigator.of(context).pop();
                    },
                    child: const Text('Close'),
                ),
            ],
            scrollable: true,
        )
    );
}
