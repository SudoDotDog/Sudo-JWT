import 'package:flutter_test/flutter_test.dart';

import 'package:sudo_jwt/sudo_jwt.dart';

import 'mock/token.dart';

void main() {
  test('instantiate token by jwt', () {
    final JWTToken token = JWTToken.fromToken(mockToken);

    expect(token.header.algorithm, "RS256");
    expect(token.header.type, "JWT");
    expect(token.header.issuedAt!.toIso8601String(), "2018-01-17T19:30:22.000");

    expect(token.getBody('name'), "John Doe");
    expect(token.getBody('admin'), true);
  });
}
