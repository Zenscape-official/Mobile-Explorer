// To parse this JSON data, do
//
//     final networkList = networkListFromJson(jsonString);

import 'dart:convert';
List<NetworkList?>? networkListFromJson(String str) => json.decode(str) == null ? [] : List<NetworkList?>.from(json.decode(str)!.map((x) => NetworkList.fromJson(x)));
String networkListToJson(List<NetworkList?>? data) => json.encode(data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));
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
    this.txTimestamp,
    this.blocksMoniker,
    this.proposalTally,
    this.proposalVote,
    this.proposalDeposit,
    this.contractDetailsBalances,
    this.contractTxs,
    this.paramssUrl,
    this.blockSearchUrl,
    this.txSearchUrl
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
  String? blockSearchUrl;
  String? txSearchUrl;
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
  String? txTimestamp;
  String? blocksMoniker;
  String? proposalTally;
  String? proposalVote;
  String? proposalDeposit;
  String? contractDetailsBalances;
  String? contractTxs;
  String? paramssUrl;

  factory NetworkList.fromJson(Map<String, dynamic> json) => NetworkList(
    id: json["id"],
    isActive: json["isActive"],
    name: json["name"],
    logoUrl: json["logoUrl"],
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
    logUrl: json["logUrl"],
    txTimestamp: json["txTimestamp"],
    blocksMoniker: json["blocksMoniker"],
    proposalTally: json["proposalTally"],
    proposalVote: json["proposalVote"],
    proposalDeposit: json["proposalDeposit"],
    contractDetailsBalances: json["contractDetailsBalances"],
    contractTxs: json["contractTxs"],
    paramssUrl: json["paramssUrl"],
    blockSearchUrl: json["blockSearch"],
    txSearchUrl: json["transactionSearch"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "isActive": isActive,
    "name": name,
    "logoUrl": logoUrl,
    "denom": denom,
    "apy": apy,
    "commission": commission,
    "price": price,
    "perc change in price": percChangeInPrice,
    "blocktime": blocktime,
    "market cap": marketCap,
    "24 hr vol": the24HrVol,
    "voting power": votingPower,
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
    "logUrl": logUrl,
    "txTimestamp": txTimestamp,
    "blocksMoniker": blocksMoniker,
    "proposalTally": proposalTally,
    "proposalVote": proposalVote,
    "proposalDeposit": proposalDeposit,
    "contractDetailsBalances": contractDetailsBalances,
    "contractTxs": contractTxs,
    "paramssUrl": paramssUrl,
    "transactionSearch":txSearchUrl,
    "blockSearch":blockSearchUrl
  };
}
