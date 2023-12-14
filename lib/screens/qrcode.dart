import 'package:exam/screens/qrimage.dart';
import 'package:exam/screens/qrscanner.dart';
import 'package:flutter/material.dart';

class Qrcode extends StatefulWidget {
  Qrcode({super.key});

  @override
  State<Qrcode> createState() => _QrcodeState();
}

class _QrcodeState extends State<Qrcode> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {а
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR code'),
        backgroundColor: const Color(0xFF151026),
        centerTitle: true,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
          margin: const EdgeInsets.all(20),
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: 'Enter you URl'),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QRImage(controller: controller),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF151026),
          ),
          child: const Text('GENERATE QR CODE'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const QRScaner(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF151026),
          ),
          child: const Text('SCAN QR CODE'),
        ),
      ]),
    );
  }
}
