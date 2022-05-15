import 'dart:convert';

import 'package:sudo_jwt/src/body.dart';
import 'package:sudo_jwt/src/header.dart';
import 'package:sudo_jwt/src/util.dart';

class JWTToken {
  late final String raw;
  late final JWTHeader header;
  late final JWTBody body;
  late final String signature;

  JWTToken({
    required this.raw,
    required this.header,
    required this.body,
    required this.signature,
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

  bool verifyNotBefore(DateTime currentTime) {
    return this.header.verifyNotBefore(currentTime);
  }

  bool verifyNotBeforeWithCurrentTime() {
    return this.verifyNotBefore(DateTime.now());
  }

  bool verifyIssueDate(DateTime currentTime) {
    return this.header.verifyIssueDate(currentTime);
  }

  bool verifyIssueDateWithCurrentTime() {
    return this.verifyIssueDate(DateTime.now());
  }

  bool verifyExpiration(DateTime currentTime) {
    return this.header.verifyExpiration(currentTime);
  }

  bool verifyExpirationWithCurrentTime() {
    return this.verifyExpiration(DateTime.now());
  }

  bool verifyTime(DateTime currentTime) {
    return this.verifyNotBefore(currentTime) &&
        this.verifyIssueDate(currentTime) &&
        this.verifyExpiration(currentTime);
  }

  bool verifyTimeWithCurrentTime() {
    return this.verifyTime(DateTime.now());
  }
}
