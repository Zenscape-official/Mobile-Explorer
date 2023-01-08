// To parse this JSON data, do
//
//     final mintingParamModel = mintingParamModelFromJson(jsonString);

import 'dart:convert';

MintingParamModel? mintingParamModelFromJson(String str) => MintingParamModel.fromJson(json.decode(str));

String mintingParamModelToJson(MintingParamModel? data) => json.encode(data!.toJson());

class MintingParamModel {
  MintingParamModel({
    this.mintDenom,
    this.inflationRateChange,
    this.inflationMax,
    this.inflationMin,
    this.goalBonded,
    this.blocksPerYear,
  });

  String? mintDenom;
  String? inflationRateChange;
  String? inflationMax;
  String? inflationMin;
  String? goalBonded;
  String? blocksPerYear;

  factory MintingParamModel.fromJson(Map<String, dynamic> json) => MintingParamModel(
    mintDenom: json["mint_denom"],
    inflationRateChange: json["inflation_rate_change"],
    inflationMax: json["inflation_max"],
    inflationMin: json["inflation_min"],
    goalBonded: json["goal_bonded"],
    blocksPerYear: json["blocks_per_year"],
  );

  Map<String, dynamic> toJson() => {
    "mint_denom": mintDenom,
    "inflation_rate_change": inflationRateChange,
    "inflation_max": inflationMax,
    "inflation_min": inflationMin,
    "goal_bonded": goalBonded,
    "blocks_per_year": blocksPerYear,
  };
}
