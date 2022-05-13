class JWTBody {
  final Map<String, dynamic>? map;

  JWTBody({
    this.map,
  });

  factory JWTBody.fromMap(Map<String, dynamic>? map) {
    return JWTBody(
      map: map,
    );
  }

  dynamic getValue(String key) {
    return this.map![key];
  }
}
