// To parse this JSON data, do
//
//     final networkList = networkListFromJson(jsonString);

import 'dart:convert';

List<NetworkList> networkListFromJson(String str) => List<NetworkList>.from(json.decode(str).map((x) => NetworkList.fromJson(x)));

String networkListToJson(List<NetworkList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NetworkList {
  NetworkList({
    this.id,
    this.isActive,
    this.name,
    this.logoUrl,
    this.denom,
    this.apy,
    this.commission,
    this.price,
    this.percChangeInPrice,
    this.blocktime,
    this.marketCap,
    this.the24HrVol,
    this.votingPower,
    this.height,
    this.transaction,
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
    this.mintingParamssUrl,
    this.stakingParamsUrl,
    this.govParamsUrl,
    this.distParamsUrl,
    this.slashingParamsUrl,
    this.logUrl,
  });

  String? id;
  String? isActive;
  String? name;
  String? logoUrl;
  String? denom;
  String? apy;
  String? commission;
  String? price;
  String? percChangeInPrice;
  String? blocktime;
  String? marketCap;
  String? the24HrVol;
  String? votingPower;
  String? height;
  String? transaction;
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
  String? mintingParamssUrl;
  String? stakingParamsUrl;
  String? govParamsUrl;
  String? distParamsUrl;
  String? slashingParamsUrl;
  String? logUrl;

  factory NetworkList.fromJson(Map<String, dynamic> json) => NetworkList(
    id: json["id"],
    isActive: json["isActive"],
    name: json["name"],
    logoUrl: json["logoUrl"] == null ? null : json["logoUrl"],
    denom: json["denom"],
    apy: json["apy"],
    commission: json["commission"],
    price: json["price"],
    percChangeInPrice: json["perc change in price"],
    blocktime: json["blocktime"],
    marketCap: json["market cap"],
    the24HrVol: json["24 hr vol"],
    votingPower: json["voting power"],
    height: json["height"],
    transaction: json["transaction"],
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
    mintingParamssUrl: json["mintingParamssUrl"],
    stakingParamsUrl: json["stakingParamsUrl"],
    govParamsUrl: json["govParamsUrl"],
    distParamsUrl: json["distParamsUrl"],
    slashingParamsUrl: json["slashingParamsUrl"],
    logUrl: json["logUrl"] == null ? null : json["logUrl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "isActive":isActive,
    "name": name,
    "logoUrl": logoUrl == null ? null : logoUrl,
    "denom": denom,
    "apy": apyValues.reverse[apy],
    "commission": commissionValues.reverse[commission],
    "price": price,
    "perc change in price": percChangeInPrice,
    "blocktime": blocktime,
    "market cap": marketCapValues.reverse[marketCap],
    "24 hr vol": the24HrVolValues.reverse[the24HrVol],
    "voting power": votingPowerValues.reverse[votingPower],
    "height": height,
    "transaction": transaction,
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
    "mintingParamssUrl": mintingParamssUrl,
    "stakingParamsUrl": stakingParamsUrl,
    "govParamsUrl": govParamsUrl,
    "distParamsUrl": distParamsUrl,
    "slashingParamsUrl": slashingParamsUrl,
    "logUrl": logUrl == null ? null : logUrl,
  };
}

enum Apy { THE_160 }

final apyValues = EnumValues({
  "160%": Apy.THE_160
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
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
