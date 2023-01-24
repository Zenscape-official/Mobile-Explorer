// To parse this JSON data, do
//
//     final contractModel = contractModelFromJson(jsonString);

import 'dart:convert';

List<ContractModel> contractModelFromJson(String str) => List<ContractModel>.from(json.decode(str).map((x) => ContractModel.fromJson(x)));

String contractModelToJson(List<ContractModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ContractModel {
  ContractModel({
    this.codeId,
    this.height,
    this.instantiatePermission,
    this.creator,
    this.label,
    this.contractAddress,
    this.instantiatedAt,
    this.contractStates,
  });

  String? codeId;
  String? height;
  String? instantiatePermission;
  String? creator;
  String? label;
  String? contractAddress;
  DateTime? instantiatedAt;
  ContractStates? contractStates;

  factory ContractModel.fromJson(Map<String, dynamic> json) => ContractModel(
    codeId: json["code_id"],
    height: json["height"],
    //instantiatePermission: json["instantiate_permission"],
    creator: json["creator"],
    label: json["label"],
    contractAddress: json["contract_address"],
    instantiatedAt: DateTime.parse(json["instantiated_at"]),
    // contractStates: ContractStates.fromJson(json["contract_states"]),
  );

  Map<String, dynamic> toJson() => {
    "code_id": codeId,
    "height": height,
    //"instantiate_permission": instantiatePermission,
    "creator": creator,
    "label": label,
    "contract_address": contractAddress,
    "instantiated_at": instantiatedAt!.toIso8601String(),
    // "contract_states": contractStates!.toJson(),
  };
}

class ContractStates {
  ContractStates({
    this.config,
    this.contractInfo,
  });

  String? config;
  ContractInfo? contractInfo;

  factory ContractStates.fromJson(Map<String, dynamic> json) => ContractStates(
    config: json["config"],
    //contractInfo: ContractInfo.fromJson(json["contract_info"]),
  );

  Map<String, dynamic> toJson() => {
    "config": config,
    "contract_info": contractInfo!.toJson(),
  };
}

class Config {
  Config({
    this.threshold,
    this.target,
  });

  Threshold? threshold;
  String? target;

  factory Config.fromJson(Map<String, dynamic> json) => Config(
    threshold: Threshold.fromJson(json["threshold"]),
    target: json["target"],
  );

  Map<String, dynamic> toJson() => {
    "threshold": threshold!.toJson(),
    "target": target,
  };
}

class Threshold {
  Threshold({
    this.thresholdQuorum,
  });

  ThresholdQuorum? thresholdQuorum;

  factory Threshold.fromJson(Map<String, dynamic> json) => Threshold(
    thresholdQuorum: ThresholdQuorum.fromJson(json["threshold_quorum"]),
  );

  Map<String, dynamic> toJson() => {
    "threshold_quorum": thresholdQuorum!.toJson(),
  };
}

class ThresholdQuorum {
  ThresholdQuorum({
    this.threshold,
    this.quorum,
  });

  String? threshold;
  String? quorum;

  factory ThresholdQuorum.fromJson(Map<String, dynamic> json) => ThresholdQuorum(
    threshold: json["threshold"],
    quorum: json["quorum"],
  );

  Map<String, dynamic> toJson() => {
    "threshold": threshold,
    "quorum": quorum,
  };
}

class ContractInfo {
  ContractInfo({
    this.contract,
    this.version,
  });

  String? contract;
  String? version;

  factory ContractInfo.fromJson(Map<String, dynamic> json) => ContractInfo(
    contract: json["contract"],
    version: json["version"],
  );

  Map<String, dynamic> toJson() => {
    "contract": contract,
    "version": version,
  };
}
