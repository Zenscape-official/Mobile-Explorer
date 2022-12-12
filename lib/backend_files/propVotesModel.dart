// To parse this JSON data, do
//
//     final proposalVotesModel = proposalVotesModelFromJson(jsonString);

import 'dart:convert';

List<ProposalVotesModel> proposalVotesModelFromJson(String str) => List<ProposalVotesModel>.from(json.decode(str).map((x) => ProposalVotesModel.fromJson(x)));

String proposalVotesModelToJson(List<ProposalVotesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProposalVotesModel {
  ProposalVotesModel({
    this.proposalId,
    this.moniker,
    this.validatorAddress,
    this.option,
  });

  int ?proposalId;
  String? moniker;
  String? validatorAddress;
  String? option;

  factory ProposalVotesModel.fromJson(Map<String, dynamic> json) => ProposalVotesModel(
    proposalId: json["proposal_id"],
    moniker: json["moniker"],
    validatorAddress: json["validator_address"],
    option: json["option"],
  );

  Map<String, dynamic> toJson() => {
    "proposal_id": proposalId,
    "moniker": moniker,
    "validator_address": validatorAddress,
    "option": option,
  };
}
