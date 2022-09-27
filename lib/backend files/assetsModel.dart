// To parse this JSON data, do
//
//     final assets = assetsFromJson(jsonString);

import 'dart:convert';

Assets assetsFromJson(String str) => Assets.fromJson(json.decode(str));
String assetsToJson(Assets data) => json.encode(data.toJson());

class Assets {
  Assets({
    this.assets,
  });

  List<Asset>? assets;

  factory Assets.fromJson(Map<String, dynamic> json) => Assets(
    assets: List<Asset>.from(json["assets"].map((x) => Asset.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "assets": List<dynamic>.from(assets!.map((x) => x.toJson())),
  };
}

class Asset {
  Asset({
    this.chain,
    this.denom,
    this.type,
    this.baseDenom,
    this.baseType,
    this.dpDenom,
    this.originChain,
    this.decimal,
    this.description,
    this.image,
    this.coinGeckoId,
    this.path,
    this.channel,
    this.port,
    this.counterParty,
  });

  String? chain;
  String? denom;
  Type? type;
  String? baseDenom;
  BaseType? baseType;
  String? dpDenom;
  String? originChain;
  int? decimal;
  String? description;
  String? image;
  String? coinGeckoId;
  String? path;
  String? channel;
  String? port;
  CounterParty? counterParty;

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
    chain: json["chain"],
    denom: json["denom"],
    type: typeValues.map![json["type"]],
    baseDenom: json["base_denom"],
    baseType: baseTypeValues.map![json["base_type"]],
    dpDenom: json["dp_denom"],
    originChain: json["origin_chain"],
    decimal: json["decimal"],
    description: json["description"],
    image: json["image"],
    coinGeckoId: json["coinGeckoId"],
    path: json["path"],
    channel: json["channel"],
    port: json["port"],
    counterParty: json["counter_party"] == null ? null : CounterParty.fromJson(json["counter_party"]),
  );

  Map<String, dynamic> toJson() => {
    "chain": chainValues.reverse[chain],
    "denom": denom,
    "type": typeValues.reverse[type],
    "base_denom": baseDenom,
    "base_type": baseTypeValues.reverse[baseType],
    "dp_denom": dpDenom,
    "origin_chain": originChain,
    "decimal": decimal,
    "description": description,
    "image": image,
    "coinGeckoId": coinGeckoId,
    "path": path,
    "channel": channel,
    "port": port,
    "counter_party": counterParty == null ? null : counterParty!.toJson(),
  };
}

enum BaseType { STAKING, NATIVE }

final baseTypeValues = EnumValues({
  "native": BaseType.NATIVE,
  "staking": BaseType.STAKING
});

enum Chain { AKASH }

final chainValues = EnumValues({
  "akash": Chain.AKASH
});

class CounterParty {
  CounterParty({
    this.channel,
    this.port,
    this.denom,
  });

  String? channel;
  String? port;
  String? denom;

  factory CounterParty.fromJson(Map<String, dynamic> json) => CounterParty(
    channel: json["channel"],
    port: json["port"],
    denom: json["denom"],
  );

  Map<String, dynamic> toJson() => {
    "channel": channel,
    "port": port,
    "denom": denom,
  };
}

enum Type { STAKING, IBC }

final typeValues = EnumValues({
  "ibc": Type.IBC,
  "staking": Type.STAKING
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map!.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
