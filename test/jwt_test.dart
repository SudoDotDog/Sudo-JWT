import 'package:flutter_test/flutter_test.dart';

import 'package:sudo_jwt/sudo_jwt.dart';

import 'mock/token.dart';

void main() {
  test('instantiate token by jwt', () {
    final JWTToken token = JWTToken.fromToken(mockToken);

    expect(token.header.algorithm, "HS256");
    expect(token.header.type, "JWT");

    expect(token.getBody('name'), "John Doe");
    expect(token.verifyTimeWithCurrentTime(), true);
  });

  test('verify expire date - happy path', () {
    final JWTToken token = JWTToken.fromToken(mockTokenExpiration100YearsLater);

    expect(token.verifyNotBeforeWithCurrentTime(), true);
    expect(token.verifyIssueDateWithCurrentTime(), true);
    expect(token.verifyExpirationWithCurrentTime(), true);
    expect(token.verifyTimeWithCurrentTime(), true);
  });

  test('verify expire date - sad path', () {
    final JWTToken token =
        JWTToken.fromToken(mockTokenExpiration100YearsEarlier);

    expect(token.verifyNotBeforeWithCurrentTime(), true);
    expect(token.verifyIssueDateWithCurrentTime(), true);
    expect(token.verifyExpirationWithCurrentTime(), false);
    expect(token.verifyTimeWithCurrentTime(), false);
  });

  test('verify not before date - happy path', () {
    final JWTToken token =
        JWTToken.fromToken(mockTokenNotBefore100YearsEarlier);

    expect(token.verifyNotBeforeWithCurrentTime(), true);
    expect(token.verifyIssueDateWithCurrentTime(), true);
    expect(token.verifyExpirationWithCurrentTime(), true);
    expect(token.verifyTimeWithCurrentTime(), true);
  });

  test('verify not before date - sad path', () {
    final JWTToken token = JWTToken.fromToken(mockTokenNotBefore100YearsLater);

    expect(token.verifyNotBeforeWithCurrentTime(), false);
    expect(token.verifyIssueDateWithCurrentTime(), true);
    expect(token.verifyExpirationWithCurrentTime(), true);
    expect(token.verifyTimeWithCurrentTime(), false);
  });
}
