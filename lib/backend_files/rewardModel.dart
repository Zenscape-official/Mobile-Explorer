// To parse this JSON data, do
//
//     final rewardModel = rewardModelFromJson(jsonString);

import 'dart:convert';

RewardModel rewardModelFromJson(String str) => RewardModel.fromJson(json.decode(str));

String rewardModelToJson(RewardModel data) => json.encode(data.toJson());

class RewardModel {
  RewardModel({
    this.rewards,
    this.total,
  });

  List<Reward>? rewards;
  List<Total>? total;

  factory RewardModel.fromJson(Map<String, dynamic> json) => RewardModel(
    rewards: json["rewards"] == null ? null : List<Reward>.from(json["rewards"].map((x) => Reward.fromJson(x))),
    total: json["total"] == null ? null : List<Total>.from(json["total"].map((x) => Total.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "rewards": rewards == null ? null : List<dynamic>.from(rewards!.map((x) => x.toJson())),
    "total": total == null ? null : List<dynamic>.from(total!.map((x) => x.toJson())),
  };
}

class Reward {
  Reward({
    this.validatorAddress,
    this.reward,
  });

  String? validatorAddress;
  List<Total>? reward;

  factory Reward.fromJson(Map<String, dynamic> json) => Reward(
    validatorAddress: json["validator_address"] == null ? null : json["validator_address"],
    reward: json["reward"] == null ? null : List<Total>.from(json["reward"].map((x) => Total.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "validator_address": validatorAddress == null ? null : validatorAddress,
    "reward": reward == null ? null : List<dynamic>.from(reward!.map((x) => x.toJson())),
  };
}

class Total {
  Total({
    this.denom,
    this.amount,
  });

  String? denom;
  String? amount;

  factory Total.fromJson(Map<String, dynamic> json) => Total(
    denom: json["denom"] == null ? null : json["denom"],
    amount: json["amount"] == null ? null : json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "denom": denom == null ? null : denom,
    "amount": amount == null ? null : amount,
  };
}
