import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanner extends StatefulWidget {
    final BuildContext context;
  const QRScanner({super.key, required this.context});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 18),
    fixedSize: const Size.fromWidth(100),
    elevation: 2.0,
  );

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
                  child:_button()),
          ),
        ],
      ),
    );
  }

  Widget _button() {
    if (result != null) {
        return ElevatedButton(
            style: buttonStyle,
            onPressed: () {
                Navigator.of(widget.context).pop<String>(result!.code);
            }, 
            child: Text('${result!.code}'),
        );
    } else {
        return const  Text('Scan QR Code');
    }
  }
        

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
        setState(() {
            result = scanData;
        });
    });
  }


  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
