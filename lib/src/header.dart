DateTime _parseTime(int time) {
  final int millisecondsTime = time * 1000;
  return DateTime.fromMillisecondsSinceEpoch(millisecondsTime);
}

class JWTHeader {
  final String algorithm;
  final String type;

  final String audiance;
  final DateTime expireationTime;
  final String id;
  final DateTime issuedAt;
  final String issuer;
  final DateTime notBefore;
  final String subject;

  final Map<String, dynamic> map;

  JWTHeader({
    this.algorithm,
    this.type,
    this.audiance,
    this.expireationTime,
    this.id,
    this.issuedAt,
    this.issuer,
    this.notBefore,
    this.subject,
    this.map,
  });

  factory JWTHeader.fromMap(Map<String, dynamic> map) {
    final String rawALG = map['alg'];
    final String rawTYP = map['typ'];
    final String rawAUD = map['aud'];
    final int rawEXP = map['exp'];
    final String rawJTI = map['jti'];
    final int rawIAT = map['iat'];
    final String rawISS = map['iss'];
    final int rawNBF = map['nbf'];
    final String rawSUB = map['sub'];

    return JWTHeader(
      algorithm: rawALG != null ? rawALG.toString() : null,
      type: rawTYP != null ? rawTYP.toString() : null,
      audiance: rawAUD != null ? rawAUD.toString() : null,
      expireationTime: rawEXP != null ? _parseTime(rawEXP) : null,
      id: rawJTI != null ? rawJTI.toString() : null,
      issuedAt: rawIAT != null ? _parseTime(rawIAT) : null,
      issuer: rawISS != null ? rawISS.toString() : null,
      notBefore: rawNBF != null ? _parseTime(rawNBF) : null,
      subject: rawSUB != null ? rawSUB.toString() : null,
      map: map,
    );
  }

  dynamic getValue(String key) {
    return this.map[key];
  }
}
