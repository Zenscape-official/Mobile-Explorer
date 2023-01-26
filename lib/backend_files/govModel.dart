// To parse this JSON data, do
//
//     final govParamModel = govParamModelFromJson(jsonString);

import 'dart:convert';

List<GovParamModel> govParamModelFromJson(String str) => List<GovParamModel>.from(json.decode(str).map((x) => GovParamModel.fromJson(x)));

String govParamModelToJson(List<GovParamModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GovParamModel {
  GovParamModel({
    this.oneRowId,
    this.depositParams,
    this.votingParams,
    this.tallyParams,
    this.height,
  });

  bool? oneRowId;
  DepositParams? depositParams;
  VotingParams? votingParams;
  TallyParams? tallyParams;
  String? height;

  factory GovParamModel.fromJson(Map<String, dynamic> json) => GovParamModel(
    oneRowId: json["one_row_id"],
    depositParams: json["deposit_params"] == null ? null : DepositParams.fromJson(json["deposit_params"]),
    votingParams: json["voting_params"] == null ? null : VotingParams.fromJson(json["voting_params"]),
    tallyParams: json["tally_params"] == null ? null : TallyParams.fromJson(json["tally_params"]),
    height: json["height"],
  );

  Map<String, dynamic> toJson() => {
    "one_row_id": oneRowId,
    "deposit_params": depositParams?.toJson(),
    "voting_params": votingParams?.toJson(),
    "tally_params": tallyParams?.toJson(),
    "height": height,
  };
}

class DepositParams {
  DepositParams({
    this.minDeposit,
    this.maxDepositPeriod,
  });

  List<MinDeposit>? minDeposit;
  int? maxDepositPeriod;

  factory DepositParams.fromJson(Map<String, dynamic> json) => DepositParams(
    minDeposit: json["min_deposit"] == null ? [] : List<MinDeposit>.from(json["min_deposit"]!.map((x) => MinDeposit.fromJson(x))),
    maxDepositPeriod: json["max_deposit_period"],
  );

  Map<String, dynamic> toJson() => {
    "min_deposit": minDeposit == null ? [] : List<dynamic>.from(minDeposit!.map((x) => x.toJson())),
    "max_deposit_period": maxDepositPeriod,
  };
}

class MinDeposit {
  MinDeposit({
    this.denom,
    this.amount,
  });

  String? denom;
  String? amount;

  factory MinDeposit.fromJson(Map<String, dynamic> json) => MinDeposit(
    denom: json["denom"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "denom": denom,
    "amount": amount,
  };
}

class TallyParams {
  TallyParams({
    this.quorum,
    this.threshold,
    this.vetoThreshold,
  });

  String? quorum;
  String? threshold;
  String? vetoThreshold;

  factory TallyParams.fromJson(Map<String, dynamic> json) => TallyParams(
    quorum: json["quorum"],
    threshold: json["threshold"],
    vetoThreshold: json["veto_threshold"],
  );

  Map<String, dynamic> toJson() => {
    "quorum": quorum,
    "threshold": threshold,
    "veto_threshold": vetoThreshold,
  };
}

class VotingParams {
  VotingParams({
    this.votingPeriod,
  });

  int? votingPeriod;

  factory VotingParams.fromJson(Map<String, dynamic> json) => VotingParams(
    votingPeriod: json["voting_period"],
  );

  Map<String, dynamic> toJson() => {
    "voting_period": votingPeriod,
  };
}
