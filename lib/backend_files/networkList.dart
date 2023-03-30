// To parse this JSON data, do
//
//     final staticJson = staticJsonFromJson(jsonString);

import 'dart:convert';

StaticJson staticJsonFromJson(String str) => StaticJson.fromJson(json.decode(str));

String staticJsonToJson(StaticJson data) => json.encode(data.toJson());

class StaticJson {
  StaticJson({
    this.landingPageBanner,
    this.networkList,
  });

  List<BannerObject>? landingPageBanner;
  List<NetworkList>? networkList;

  factory StaticJson.fromJson(Map<String, dynamic> json) => StaticJson(
    landingPageBanner: json["landingPage_banner"] == null ? [] : List<BannerObject>.from(json["landingPage_banner"]!.map((x) => BannerObject.fromJson(x))),
    networkList: json["networkList"] == null ? [] : List<NetworkList>.from(json["networkList"]!.map((x) => NetworkList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "landingPage_banner": landingPageBanner == null ? [] : List<dynamic>.from(landingPageBanner!.map((x) => x.toJson())),
    "networkList": networkList == null ? [] : List<dynamic>.from(networkList!.map((x) => x.toJson())),
  };
}

class BannerObject {
  BannerObject({
    this.urlForBanner,
    this.urlForWebsite,
  });

  String? urlForBanner;
  String? urlForWebsite;

  factory BannerObject.fromJson(Map<String, dynamic> json) => BannerObject(
    urlForBanner: json["URL_for_banner"],
    urlForWebsite: json["URL_for_website"],
  );

  Map<String, dynamic> toJson() => {
    "URL_for_banner": urlForBanner,
    "URL_for_website": urlForWebsite,
  };
}

class NetworkList {
  NetworkList({
    this.id,
    this.isActive,
    this.name,
    this.uDenom,
    this.logUrl,
    this.dashboardPageUrl,
    this.validatorsPageUrl,
    this.blocksPageUrl,
    this.proposalPageUrl,
    this.denom,
    this.apy,
    this.commission,
    this.percChangeInPrice,
    this.price,
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
    this.valStatus,
    this.blocksUrl,
    this.transactionsUrl,
    this.proposalsUrl,
    this.contractsUrl,
    this.mintingParamssUrl,
    this.stakingParamsUrl,
    this.govParamsUrl,
    this.distParamsUrl,
    this.slashingParamsUrl,
    this.txTimestamp,
    this.blockSearch,
    this.blockSearchFromProposer,
    this.transactionSearch,
    this.transactionSearchFromHt,
    this.validatorSearch,
    this.blocksMoniker,
    this.proposalTally,
    this.proposalVote,
    this.proposalDeposit,
    this.contractDetailsBalances,
    this.txFromAddress,
    this.delegationFromAddress,
    this.rewardFromAddress,
    this.contractTxs,
    this.ibcRelayers,
    this.assetList
  });

  String? id;
  String? isActive;
  String? name;
  String? uDenom;
  String? logUrl;
  List<BannerObject>? dashboardPageUrl;
  List<BannerObject>? validatorsPageUrl;
  List<BannerObject>? blocksPageUrl;
  List<BannerObject>? proposalPageUrl;
  String? denom;
  String? apy;
  String? commission;
  String? percChangeInPrice;
  String? price;
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
  String? valStatus;
  String? blocksUrl;
  String? transactionsUrl;
  String? proposalsUrl;
  String? contractsUrl;
  String? mintingParamssUrl;
  String? stakingParamsUrl;
  String? govParamsUrl;
  String? distParamsUrl;
  String? slashingParamsUrl;
  String? txTimestamp;
  String? blockSearch;
  String? blockSearchFromProposer;
  String? transactionSearch;
  String? transactionSearchFromHt;
  String? validatorSearch;
  String? blocksMoniker;
  String? proposalTally;
  String? proposalVote;
  String? proposalDeposit;
  String? contractDetailsBalances;
  String? txFromAddress;
  String? delegationFromAddress;
  String? rewardFromAddress;
  String? contractTxs;
  String? ibcRelayers;
  String? assetList;

  factory NetworkList.fromJson(Map<String, dynamic> json) => NetworkList(
    id: json["id"],
    isActive: json["isActive"],
    name: json["name"],
    uDenom: json["uDenom"],
    logUrl: json["logUrl"],
    dashboardPageUrl: json["dashboard_page_Url"] == null ? [] : List<BannerObject>.from(json["dashboard_page_Url"]!.map((x) => BannerObject.fromJson(x))),
    validatorsPageUrl: json["validators_page_Url"] == null ? [] : List<BannerObject>.from(json["validators_page_Url"]!.map((x) => BannerObject.fromJson(x))),
    blocksPageUrl: json["blocks_page_Url"] == null ? [] : List<BannerObject>.from(json["blocks_page_Url"]!.map((x) => BannerObject.fromJson(x))),
    proposalPageUrl: json["proposal_page_Url"] == null ? [] : List<BannerObject>.from(json["proposal_page_Url"]!.map((x) => BannerObject.fromJson(x))),
    denom: json["denom"],
    apy: json["apy"],
    commission: json["commission"],
    percChangeInPrice: json["perc change in price"],
    price: json["price"],
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
    valStatus: json["valStatus"],
    blocksUrl: json["blocksURL"],
    transactionsUrl: json["transactionsUrl"],
    proposalsUrl: json["proposalsUrl"],
    contractsUrl: json["contractsUrl"],
    mintingParamssUrl: json["mintingParamssUrl"],
    stakingParamsUrl: json["stakingParamsUrl"],
    govParamsUrl: json["govParamsUrl"],
    distParamsUrl: json["distParamsUrl"],
    slashingParamsUrl: json["slashingParamsUrl"],
    txTimestamp: json["txTimestamp"],
    blockSearch: json["blockSearch"],
    blockSearchFromProposer: json["blockSearchFromProposer"],
    transactionSearch: json["transactionSearch"],
    transactionSearchFromHt: json["transactionSearchFromHt"],
    validatorSearch: json["validatorSearch"],
    blocksMoniker: json["blocksMoniker"],
    proposalTally: json["proposalTally"],
    proposalVote: json["proposalVote"],
    proposalDeposit: json["proposalDeposit"],
    contractDetailsBalances: json["contractDetailsBalances"],
    txFromAddress: json["txFromAddress"],
    delegationFromAddress: json["delegationFromAddress"],
    rewardFromAddress: json["rewardFromAddress"],
    contractTxs: json["contractTxs"],
    ibcRelayers: json["ibcRelayers"],
    assetList:json["assetList"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "isActive": isActive,
    "name": name,
    "uDenom": uDenom,
    "logUrl": logUrl,
    "dashboard_page_Url": dashboardPageUrl == null ? [] : List<dynamic>.from(dashboardPageUrl!.map((x) => x.toJson())),
    "validators_page_Url": validatorsPageUrl == null ? [] : List<dynamic>.from(validatorsPageUrl!.map((x) => x.toJson())),
    "blocks_page_Url": blocksPageUrl == null ? [] : List<dynamic>.from(blocksPageUrl!.map((x) => x.toJson())),
    "proposal_page_Url": proposalPageUrl == null ? [] : List<dynamic>.from(proposalPageUrl!.map((x) => x.toJson())),
    "denom": denom,
    "apy": apy,
    "commission": commission,
    "perc change in price": percChangeInPrice,
    "price": price,
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
    "valStatus": valStatus,
    "blocksURL": blocksUrl,
    "transactionsUrl": transactionsUrl,
    "proposalsUrl": proposalsUrl,
    "contractsUrl": contractsUrl,
    "mintingParamssUrl": mintingParamssUrl,
    "stakingParamsUrl": stakingParamsUrl,
    "govParamsUrl": govParamsUrl,
    "distParamsUrl": distParamsUrl,
    "slashingParamsUrl": slashingParamsUrl,
    "txTimestamp": txTimestamp,
    "blockSearch": blockSearch,
    "blockSearchFromProposer": blockSearchFromProposer,
    "transactionSearch": transactionSearch,
    "transactionSearchFromHt": transactionSearchFromHt,
    "validatorSearch": validatorSearch,
    "blocksMoniker": blocksMoniker,
    "proposalTally": proposalTally,
    "proposalVote": proposalVote,
    "proposalDeposit": proposalDeposit,
    "contractDetailsBalances": contractDetailsBalances,
    "txFromAddress": txFromAddress,
    "delegationFromAddress": delegationFromAddress,
    "rewardFromAddress": rewardFromAddress,
    "contractTxs": contractTxs,
    "assetList":assetList,
    "ibcRelayers":ibcRelayers
  };
}
