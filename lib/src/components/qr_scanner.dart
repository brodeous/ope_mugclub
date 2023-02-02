import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ope_mugclub/src/pages/new_member_page.dart';
import 'package:ope_mugclub/src/pages/return_member_page.dart';
import 'package:ope_mugclub/src/utils/firebase_methods.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:firebase_database/firebase_database.dart';

class QRScanner extends StatefulWidget {
  final DatabaseReference database;
  final int version;
  const QRScanner({super.key, required this.database, required this.version});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  bool newMember = false;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Scan QRCode',
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
              flex: 1,
              child: Center(
                child: _displayResult(widget.version),
              )),
        ],
      ),
    );
  }

  Widget _displayResult(int version) {
      // New Member
      if (result != null) {
        if (newMember) {
          return ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NewMemberPage(qrCode: result!.code),
                ),
              );
            },
            child: const Text('Add Member'),
          );
        } else {
          return ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ReturnMemberPage(
                      qrCode: result!.code),
                ),
              );
            },
            child: const Text('Check In Member'),
          );
        }
      } else {
        return const Text('Scan QR Code');
      }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        _checkDuplicate();
      });
    });
  }

  void _checkDuplicate() {
    widget.database.get().then((snapshot) {
      bool exists = FireMethods.checkMemberExists(
          qrCode: result!.code as String, data: snapshot);
      setState(() {
        newMember = !exists;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
