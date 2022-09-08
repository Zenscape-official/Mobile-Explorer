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
    this.commission,
    this.price,
    this.blocktime,
    this.marketCap,
    this.the24HrVol,
    this.votingPeriod,
    this.height,
    this.tranaction,
    this.bondedTokens,
    this.communityPool,
    this.inflation,
    this.stakingApr,
    this.validatorsUrl,
    this.blocksUrl,
    this.transactionsUrl,
    this.proposalsUrl,
    this.ibcUrl,
    this.assetsUrl,
    this.contractsUrl,
    this.paramssUrl,
    this.logUrl,
  });

  String? name;
  String? logoUrl;
  String? denom;
  String? apy;
  String? commission;
  String? price;
  String? blocktime;
  String? marketCap;
  String? the24HrVol;
  String? votingPeriod;
  String? height;
  String? tranaction;
  String? bondedTokens;
  String? communityPool;
  String? inflation;
  String? stakingApr;
  String? validatorsUrl;
  String? blocksUrl;
  String? transactionsUrl;
  String? proposalsUrl;
  String? ibcUrl;
  String? assetsUrl;
  String? contractsUrl;
  String? paramssUrl;
  String? logUrl;

  factory NetworkList.fromJson(Map<String, dynamic> json) => NetworkList(
    name: json["name"],
    logoUrl: json["logoUrl"],
    denom: json["denom"],
    apy: json["apy"],
    commission: json["commission"],
    price: json["price"],
    blocktime: json["blocktime"],
    marketCap: json["market cap"],
    the24HrVol: json["24 hr vol"],
    votingPeriod: json["voting power"],
    height: json["height"],
    tranaction: json["tranaction"],
    bondedTokens: json["bonded tokens"],
    communityPool: json["community pool"],
    inflation: json["inflation"],
    stakingApr: json["staking apr"],
    validatorsUrl: json["validatorsUrl"],
    blocksUrl: json["blocksURL"],
    transactionsUrl: json["transactionsUrl"],
    proposalsUrl: json["proposalsUrl"],
    ibcUrl: json["ibcUrl"],
    assetsUrl: json["assetsUrl"],
    contractsUrl: json["contractsUrl"],
    paramssUrl: json["paramssUrl"],
    logUrl: json["logUrl"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "logoUrl": logoUrl,
    "denom": denom,
    "apy": apyValues.reverse[apy],
    "commission": commissionValues.reverse[commission],
    "price": price,
    "blocktime": blocktimeValues.reverse[blocktime],
    "market cap": marketCapValues.reverse[marketCap],
    "24 hr vol": the24HrVolValues.reverse[the24HrVol],
    "voting power": votingPowerValues.reverse[votingPeriod],
    "height": height,
    "tranaction": tranaction,
    "bonded tokens": bondedTokens,
    "community pool": communityPool,
    "inflation": inflation,
    "staking apr": stakingApr,
    "validatorsUrl": validatorsUrl,
    "blocksURL": blocksUrl,
    "transactionsUrl": transactionsUrl,
    "proposalsUrl": proposalsUrl,
    "ibcUrl": ibcUrl,
    "assetsUrl": assetsUrl,
    "contractsUrl": contractsUrl,
    "paramssUrl": paramssUrl,
    "logUrl": logUrl,
  };
}

enum Apy { THE_160 }

final apyValues = EnumValues({
  "160%": Apy.THE_160
});

enum Blocktime { THE_609_MS }

final blocktimeValues = EnumValues({
  "6,09ms": Blocktime.THE_609_MS
});

enum Commission { THE_5 }

final commissionValues = EnumValues({
  "5%": Commission.THE_5
});

enum MarketCap { THE_44460560 }

final marketCapValues = EnumValues({
  "44,460,560": MarketCap.THE_44460560
});

enum The24HrVol { THE_1468879 }

final the24HrVolValues = EnumValues({
  "1,468,879": The24HrVol.THE_1468879
});

enum VotingPower { THE_34 }

final votingPowerValues = EnumValues({
  "3/4": VotingPower.THE_34
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
