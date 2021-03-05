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
      expireationTime:
          rawEXP != null ? DateTime.fromMillisecondsSinceEpoch(rawEXP) : null,
      id: rawJTI != null ? rawJTI.toString() : null,
      issuedAt:
          rawIAT != null ? DateTime.fromMillisecondsSinceEpoch(rawIAT) : null,
      issuer: rawISS != null ? rawISS.toString() : null,
      notBefore:
          rawNBF != null ? DateTime.fromMillisecondsSinceEpoch(rawNBF) : null,
      subject: rawSUB != null ? rawSUB.toString() : null,
    );
  }
}
