// To parse this JSON data, do
//
//     final validatorModel = validatorModelFromJson(jsonString);

import 'dart:convert';

List<ValidatorModel> validatorModelFromJson(String str) => List<ValidatorModel>.from(json.decode(str).map((x) => ValidatorModel.fromJson(x)));

String validatorModelToJson(List<ValidatorModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ValidatorModel {
  ValidatorModel({
    this.consensusAddress,
    this.consensusPubkey,
    this.validatorAddress,
    this.commission,
    this.minSelfDelegation,
    this.height,
    this.moniker,
    this.identity,
    this.avatarUrl,
    this.website,
    this.securityContact,
    this.details,
    this.operatorAddress,
    this.selfDelegateAddress,
    this.maxChangeRate,
    this.maxRate,
    this.startHeight,
    this.indexOffset,
    this.jailedUntil,
    this.tombstoned,
    this.missedBlocksCounter,
    this.votingPower,
  });

  String? consensusAddress;
  String ?consensusPubkey;
  String ?validatorAddress;
  String? commission;
  String ?minSelfDelegation;
  String ?height;
  String ?moniker;
  String ?identity;
  String? avatarUrl;
  String ?website;
  String? securityContact;
  String? details;
  String? operatorAddress;
  String? selfDelegateAddress;
  String? maxChangeRate;
  String? maxRate;
  String? startHeight;
  String? indexOffset;
  DateTime? jailedUntil;
  bool? tombstoned;
  String? missedBlocksCounter;
  int? votingPower;

  factory ValidatorModel.fromJson(Map<String, dynamic> json) => ValidatorModel(
    consensusAddress: json["consensus_address"],
    consensusPubkey: json["consensus_pubkey"],
    validatorAddress: json["validator_address"],
    commission: json["commission"],
    minSelfDelegation: json["min_self_delegation"],
    height: json["height"],
    moniker: json["moniker"],
    identity: json["identity"] == null ? null : json["identity"],
    avatarUrl: json["avatar_url"] == null ? null : json["avatar_url"],
    website: json["website"] == null ? null : json["website"],
    securityContact: json["security_contact"] == null ? null : json["security_contact"],
    details: json["details"] == null ? null : json["details"],
    operatorAddress: json["operator_address"],
    selfDelegateAddress: json["self_delegate_address"],
    maxChangeRate: json["max_change_rate"],
    maxRate: json["max_rate"],
    startHeight: json["start_height"],
    indexOffset: json["index_offset"],
    jailedUntil: DateTime.parse(json["jailed_until"]),
    tombstoned: json["tombstoned"],
    missedBlocksCounter: json["missed_blocks_counter"],
    votingPower: int.parse(json["voting_power"]),
  );

  Map<String, dynamic> toJson() => {
    "consensus_address": consensusAddress,
    "consensus_pubkey": consensusPubkey,
    "validator_address": validatorAddress,
    "commission": commission,
    "min_self_delegation": minSelfDelegation,
    "height": height,
    "moniker": moniker,
    "identity": identity == null ? null : identity,
    "avatar_url": avatarUrl == null ? null : avatarUrl,
    "website": website == null ? null : website,
    "security_contact": securityContact == null ? null : securityContact,
    "details": details == null ? null : details,
    "operator_address": operatorAddress,
    "self_delegate_address": selfDelegateAddress,
    "max_change_rate": maxChangeRate,
    "max_rate": maxRate,
    "start_height": startHeight,
    "index_offset": indexOffset,
    "jailed_until": jailedUntil!.toIso8601String(),
    "tombstoned": tombstoned,
    "missed_blocks_counter": missedBlocksCounter,
    "voting_power": votingPower,
  };
}
