import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/services.dart';
import 'package:pointycastle/export.dart';

class EncryptData {
  Future<String> ecrypt(String data) async {

    final publicPem = await rootBundle.loadString('assets/images/publickey.pem');
    final parser = RSAKeyParser();
    final publicKey = parser.parse(publicPem) as RSAPublicKey;


    final oaepEncoding = OAEPEncoding(RSAEngine())
      ..init(
        true, 
        PublicKeyParameter<RSAPublicKey>(publicKey),
      );

    final inputBytes = utf8.encode(data);

    final maxPlaintextLength = (publicKey.modulus!.bitLength ~/ 8) - 42;
    if (inputBytes.length > maxPlaintextLength) {
      throw Exception("ข้อความยาวเกินไปสำหรับการเข้ารหัส");
    }

    final encryptedBytes = oaepEncoding.process(inputBytes);

    return base64.encode(encryptedBytes);
  }
}
