// To parse this JSON data, do
//
//     final validatorModel = validatorModelFromJson(jsonString);

import 'dart:convert';

List<ValidatorModel> validatorModelFromJson(String str) => List<ValidatorModel>.from(json.decode(str).map((x) => ValidatorModel.fromJson(x)));

String validatorModelToJson(List<ValidatorModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ValidatorModel {
  ValidatorModel({
    this.validatorAddress,
    this.consensusPubkey,
    this.moniker,
  });

  String? validatorAddress;
  String? consensusPubkey;
  String? moniker;

  factory ValidatorModel.fromJson(Map<String, dynamic> json) => ValidatorModel(
    validatorAddress: json["validator_address"],
    consensusPubkey: json["consensus_pubkey"],
    moniker: json["moniker"],
  );

  Map<String, dynamic> toJson() => {
    "validator_address": validatorAddress,
    "consensus_pubkey": consensusPubkey,
    "moniker": moniker,
  };
}
