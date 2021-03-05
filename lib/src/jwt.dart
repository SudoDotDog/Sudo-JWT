import 'dart:convert';

import 'package:sudo_jwt/src/body.dart';
import 'package:sudo_jwt/src/header.dart';
import 'package:sudo_jwt/src/util.dart';

class JWTToken {
  final String raw;
  final JWTHeader header;
  final JWTBody body;
  final String signature;

  JWTToken({
    this.raw,
    this.header,
    this.body,
    this.signature,
  });

  factory JWTToken.fromToken(String raw) {
    final List<String> splited = raw.split('.');

    if (splited.length != 3) {
      throw "Invalid Token";
    }

    final String rawHeader = decodeBase64(splited[0]);
    final String rawBody = decodeBase64(splited[1]);
    final String signature = splited[2].toString();

    final JWTHeader header = JWTHeader.fromMap(jsonDecode(rawHeader));
    final JWTBody body = JWTBody.fromMap(jsonDecode(rawBody));

    return JWTToken(
      raw: raw,
      header: header,
      body: body,
      signature: signature,
    );
  }

  dynamic getHeader(String key) {
    return this.header.getValue(key);
  }

  dynamic getBody(String key) {
    return this.body.getValue(key);
  }
}
