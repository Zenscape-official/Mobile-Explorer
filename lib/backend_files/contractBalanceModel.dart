// To parse this JSON data, do
//
//     final contractBalancesModel = contractBalancesModelFromMap(jsonString);

import 'dart:convert';

ContractBalancesModel contractBalancesModelFromMap(String str) => ContractBalancesModel.fromMap(json.decode(str));

String contractBalancesModelToMap(ContractBalancesModel data) => json.encode(data.toMap());

class ContractBalancesModel {
  ContractBalancesModel({
    this.balances,
    this.pagination,
  });

  List<Balance>? balances;
  Pagination? pagination;

  factory ContractBalancesModel.fromMap(Map<String, dynamic> json) => ContractBalancesModel(
    balances: List<Balance>.from(json["balances"].map((x) => Balance.fromMap(x))),
    pagination: Pagination.fromMap(json["pagination"]),
  );

  Map<String, dynamic> toMap() => {
    "balances": List<dynamic>.from(balances!.map((x) => x.toMap())),
    "pagination": pagination!.toMap(),
  };
}

class Balance {
  Balance({
    this.denom,
    this.amount,
  });

  String? denom;
  String? amount;

  factory Balance.fromMap(Map<String, dynamic> json) => Balance(
    denom: json["denom"],
    amount: json["amount"],
  );

  Map<String, dynamic> toMap() => {
    "denom": denom,
    "amount": amount,
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
    total: json["total"],
  );

  Map<String, dynamic> toMap() => {
    "next_key": nextKey,
    "total": total,
  };
}
