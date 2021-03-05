import 'package:flutter_test/flutter_test.dart';

import 'package:sudo_jwt/sudo_jwt.dart';

void main() {
  test('decode base64 text', () {
    final String text = "VGVzdA==";
    final String pasrsed = decodeBase64(text);

    expect(pasrsed, "Test");
  });
}
