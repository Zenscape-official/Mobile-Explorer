// To parse this JSON data, do
//
//     final valStatusModel = valStatusModelFromMap(jsonString);

import 'dart:convert';

List<ValStatusModel> valStatusModelFromMap(String str) => List<ValStatusModel>.from(json.decode(str).map((x) => ValStatusModel.fromMap(x)));

String valStatusModelToMap(List<ValStatusModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class ValStatusModel {
  ValStatusModel({
    this.validatorAddress,
    this.consensusPubkey,
    this.status,
    this.jailed,
  });

  String? validatorAddress;
  String? consensusPubkey;
  int? status;
  bool? jailed;

  factory ValStatusModel.fromMap(Map<String, dynamic> json) => ValStatusModel(
    validatorAddress: json["validator_address"],
    consensusPubkey: json["consensus_pubkey"],
    status: json["status"],
    jailed: json["jailed"],
  );

  Map<String, dynamic> toMap() => {
    "validator_address": validatorAddress,
    "consensus_pubkey": consensusPubkey,
    "status": status,
    "jailed": jailed,
  };
}
