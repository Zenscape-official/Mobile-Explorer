// To parse this JSON data, do
//
//     final validatorModel = validatorModelFromJson(jsonString);

import 'dart:convert';

List<ValidatorModel> validatorModelFromJson(String str) => List<ValidatorModel>.from(json.decode(str).map((x) => ValidatorModel.fromJson(x)));

String validatorModelToJson(List<ValidatorModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ValidatorModel {
  ValidatorModel({
    this.rank,
    this.accountAddress,
    this.operatorAddress,
    this.consensusPubkey,
    this.jailed,
    this.status,
    this.tokens,
    this.delegatorShares,
    this.moniker,
    this.identity,
    this.website,
    this.details,
    this.unbondingHeight,
    this.unbondingTime,
    this.rate,
    this.maxRate,
    this.maxChangeRate,
    this.updateTime,
    this.uptime,
    this.minSelfDelegation,
    this.keybaseUrl,
  });

  int? rank;
  String? accountAddress;
  String? operatorAddress;
  String? consensusPubkey;
  bool? jailed;
  int? status;
  String? tokens;
  String? delegatorShares;
  String? moniker;
  String? identity;
  String? website;
  String? details;
  String? unbondingHeight;
  DateTime? unbondingTime;
  String? rate;
  String? maxRate;
  String? maxChangeRate;
  DateTime? updateTime;
  Uptime? uptime;
  String? minSelfDelegation;
  String? keybaseUrl;

  factory ValidatorModel.fromJson(Map<String, dynamic> json) => ValidatorModel(
    rank: json["rank"],
    accountAddress: json["account_address"],
    operatorAddress: json["operator_address"],
    consensusPubkey: json["consensus_pubkey"],
    jailed: json["jailed"],
    status: json["status"],
    tokens: json["tokens"],
    delegatorShares: json["delegator_shares"],
    moniker: json["moniker"],
    identity: json["identity"],
    website: json["website"],
    details: json["details"],
    unbondingHeight: json["unbonding_height"],
    unbondingTime: DateTime.parse(json["unbonding_time"]),
    rate: json["rate"],
    maxRate: json["max_rate"],
    maxChangeRate: json["max_change_rate"],
    updateTime: DateTime.parse(json["update_time"]),
    uptime: Uptime.fromJson(json["uptime"]),
    minSelfDelegation: json["min_self_delegation"],
    keybaseUrl: json["keybase_url"],
  );

  Map<String, dynamic> toJson() => {
    "rank": rank,
    "account_address": accountAddress,
    "operator_address": operatorAddress,
    "consensus_pubkey": consensusPubkey,
    "jailed": jailed,
    "status": status,
    "tokens": tokens,
    "delegator_shares": delegatorShares,
    "moniker": moniker,
    "identity": identity,
    "website": website,
    "details": details,
    "unbonding_height": unbondingHeight,
    "unbonding_time": unbondingTime!.toIso8601String(),
    "rate": rate,
    "max_rate": maxRate,
    "max_change_rate": maxChangeRate,
    "update_time": updateTime!.toIso8601String(),
    "uptime": uptime!.toJson(),
    "min_self_delegation": minSelfDelegation,
    "keybase_url": keybaseUrl,
  };
}

class Uptime {
  Uptime({
    this.address,
    this.missedBlocks,
    this.overBlocks,
  });

  String? address;
  int? missedBlocks;
  int? overBlocks;

  factory Uptime.fromJson(Map<String, dynamic> json) => Uptime(
    address: json["address"],
    missedBlocks: json["missed_blocks"],
    overBlocks: json["over_blocks"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "missed_blocks": missedBlocks,
    "over_blocks": overBlocks,
  };
}
