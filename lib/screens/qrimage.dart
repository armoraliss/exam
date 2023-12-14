import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRImage extends StatelessWidget {
  const QRImage({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code'),
        backgroundColor: const Color(0xFF151026),
        centerTitle: true,
      ),
      body: Center(
        child: QrImage(
          data: controller.text,
          size: 200,
          embeddedImageStyle: QrEmbeddedImageStyle(
            size: Size(100, 100),
          ),
        ),
      ),
    );
  }
}
