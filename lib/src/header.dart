DateTime _parseTime(int time) {
  final int millisecondsTime = time * 1000;
  return DateTime.fromMillisecondsSinceEpoch(millisecondsTime);
}

class JWTHeader {
  final String? algorithm;
  final String? type;

  final String? audience;
  final DateTime? expirationTime;
  final String? id;
  final DateTime? issuedAt;
  final String? issuer;
  final DateTime? notBefore;
  final String? subject;

  final Map<String, dynamic> map;

  JWTHeader({
    this.algorithm,
    this.type,
    this.audience,
    this.expirationTime,
    this.id,
    this.issuedAt,
    this.issuer,
    this.notBefore,
    this.subject,
    required this.map,
  });

  factory JWTHeader.fromMap(Map<String, dynamic> map) {
    final String? rawALG = map['alg'];
    final String? rawTYP = map['typ'];
    final String? rawAUD = map['aud'];
    final int? rawEXP = map['exp'];
    final String? rawJTI = map['jti'];
    final int? rawIAT = map['iat'];
    final String? rawISS = map['iss'];
    final int? rawNBF = map['nbf'];
    final String? rawSUB = map['sub'];

    return JWTHeader(
      algorithm: rawALG != null ? rawALG.toString() : null,
      type: rawTYP != null ? rawTYP.toString() : null,
      audience: rawAUD != null ? rawAUD.toString() : null,
      expirationTime: rawEXP != null ? _parseTime(rawEXP) : null,
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

  bool verifyNotBefore(DateTime currentTime) {
    if (this.notBefore == null) {
      return true;
    }

    if (this.notBefore is DateTime) {
      return currentTime.millisecondsSinceEpoch >=
          this.notBefore!.millisecondsSinceEpoch;
    }

    return false;
  }

  bool verifyNotBeforeWithCurrentTime() {
    return verifyNotBefore(DateTime.now());
  }

  bool verifyIssueDate(DateTime currentTime) {
    if (this.issuedAt == null) {
      return true;
    }

    if (this.issuedAt is DateTime) {
      return currentTime.millisecondsSinceEpoch >=
          this.issuedAt!.millisecondsSinceEpoch;
    }

    return false;
  }

  bool verifyIssueDateWithCurrentTime() {
    return verifyIssueDate(DateTime.now());
  }

  bool verifyExpiration(DateTime currentTime) {
    if (this.expirationTime == null) {
      return true;
    }

    if (this.expirationTime is DateTime) {
      return currentTime.millisecondsSinceEpoch <=
          this.expirationTime!.millisecondsSinceEpoch;
    }

    return false;
  }

  bool verifyExpirationWithCurrentTime() {
    return verifyExpiration(DateTime.now());
  }

  bool verifyTime(DateTime currentTime) {
    return verifyNotBefore(currentTime) &&
        verifyIssueDate(currentTime) &&
        verifyExpiration(currentTime);
  }

  bool verifyTimeWithCurrentTime() {
    return verifyTime(DateTime.now());
  }
}
