import 'dart:convert';

import 'package:sudo_jwt/src/body.dart';
import 'package:sudo_jwt/src/header.dart';
import 'package:sudo_jwt/src/util.dart';

class JWT {
  final String raw;
  final JWTHeader header;
  final JWTBody body;
  final String signature;

  JWT({
    this.raw,
    this.header,
    this.body,
    this.signature,
  });

  factory JWT.fromToken(String raw) {
    final List<String> splited = raw.split('.');

    if (splited.length != 3) {
      throw "Invalid Token";
    }

    final String rawHeader = decodeBase64(splited[0]);
    final String rawBody = decodeBase64(splited[1]);
    final String signature = splited[2].toString();

    final JWTHeader header = JWTHeader.fromMap(jsonDecode(rawHeader));
    final JWTBody body = JWTBody.fromMap(jsonDecode(rawBody));

    return JWT(
      raw: raw,
      header: header,
      body: body,
      signature: signature,
    );
  }
}
