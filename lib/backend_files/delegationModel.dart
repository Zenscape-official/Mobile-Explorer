// To parse this JSON data, do
//
//     final delegationModel = delegationModelFromMap(jsonString);

import 'dart:convert';

import '../backend_files/contractBalanceModel.dart';

DelegationModel delegationModelFromMap(String str) => DelegationModel.fromMap(json.decode(str));

String delegationModelToMap(DelegationModel data) => json.encode(data.toMap());

class DelegationModel {
  DelegationModel({
    this.delegationResponses,
    this.pagination,
  });

  List<DelegationResponse>? delegationResponses;
  Pagination? pagination;

  factory DelegationModel.fromMap(Map<String, dynamic> json) => DelegationModel(
    delegationResponses: json["delegation_responses"] == null ? null : List<DelegationResponse>.from(json["delegation_responses"].map((x) => DelegationResponse.fromMap(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromMap(json["pagination"]),
  );

  Map<String, dynamic> toMap() => {
    "delegation_responses": delegationResponses == null ? null : List<dynamic>.from(delegationResponses!.map((x) => x.toMap())),
    "pagination": pagination == null ? null : pagination!.toMap(),
  };
}

class DelegationResponse {
  DelegationResponse({
    this.delegation,
    this.balance,
  });

  Delegation? delegation;
  Balance? balance;

  factory DelegationResponse.fromMap(Map<String, dynamic> json) => DelegationResponse(
    delegation: json["delegation"] == null ? null : Delegation.fromMap(json["delegation"]),
    balance: json["balance"] == null ? null : Balance.fromMap(json["balance"]),
  );

  Map<String, dynamic> toMap() => {
    "delegation": delegation == null ? null : delegation!.toMap(),
    "balance": balance == null ? null : balance!.toMap(),
  };
}

// class Balance {
//   Balance({
//     this.denom,
//     this.amount,
//   });
//
//   String? denom;
//   String? amount;
//
//   factory Balance.fromMap(Map<String, dynamic> json) => Balance(
//     denom: json["denom"] == null ? null : json["denom"],
//     amount: json["amount"] == null ? null : json["amount"],
//   );
//
//   Map<String, dynamic> toMap() => {
//     "denom": denom == null ? null : denom,
//     "amount": amount == null ? null : amount,
//   };
// }

class Delegation {
  Delegation({
    this.delegatorAddress,
    this.validatorAddress,
    this.shares,
  });

  String? delegatorAddress;
  String? validatorAddress;
  String? shares;

  factory Delegation.fromMap(Map<String, dynamic> json) => Delegation(
    delegatorAddress: json["delegator_address"] == null ? null : json["delegator_address"],
    validatorAddress: json["validator_address"] == null ? null : json["validator_address"],
    shares: json["shares"] == null ? null : json["shares"],
  );

  Map<String, dynamic> toMap() => {
    "delegator_address": delegatorAddress == null ? null : delegatorAddress,
    "validator_address": validatorAddress == null ? null : validatorAddress,
    "shares": shares == null ? null : shares,
  };
}

class Pagination {
  Pagination({
    this.nextKey,
    this.total,
  });

  dynamic nextKey;
  String? total;

  factory Pagination.fromMap(Map<String, dynamic> json) => Pagination(
    nextKey: json["next_key"],
    total: json["total"] == null ? null : json["total"],
  );

  Map<String, dynamic> toMap() => {
    "next_key": nextKey,
    "total": total == null ? null : total,
  };
}
