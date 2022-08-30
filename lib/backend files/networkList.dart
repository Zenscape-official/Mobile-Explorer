// To parse this JSON data, do
//
//     final networkList = networkListFromJson(jsonString);

import 'dart:convert';

List<NetworkList> networkListFromJson(String str) => List<NetworkList>.from(json.decode(str).map((x) => NetworkList.fromJson(x)));

String networkListToJson(List<NetworkList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NetworkList {
  NetworkList({
    this.name,
    this.logoUrl,
    this.denom,
    this.apy,
    this.proposal,
    this.commission,
  });

  String? name;
  String? logoUrl;
  String? denom;
  Apy? apy;
  String? proposal;
  Apy? commission;

  factory NetworkList.fromJson(Map<String, dynamic> json) => NetworkList(
    name: json["name"],
    logoUrl: json["logoUrl"],
    denom: json["denom"],
    apy: apyValues.map[json["apy"]],
    proposal: json["proposal"] == null ? null : json["proposal"],
    commission: apyValues.map[json["commission"]],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "logoUrl": logoUrl,
    "denom": denom,
    "apy": apyValues.reverse[apy],
    "proposal": proposal == null ? null : proposal,
    "commission": apyValues.reverse[commission],
  };
}

enum Apy { EMPTY }

final apyValues = EnumValues({
  "-": Apy.EMPTY
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
