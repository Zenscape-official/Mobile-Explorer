// To parse this JSON data, do
//
//     final atomValidators = atomValidatorsFromJson(jsonString);

import 'dart:convert';

AtomValidators atomValidatorsFromJson(String str) => AtomValidators.fromJson(json.decode(str));

String atomValidatorsToJson(AtomValidators data) => json.encode(data.toJson());

class AtomValidators {
  AtomValidators({
    this.validators,
    this.pagination,
  });

  List<Validator>? validators;
  Pagination? pagination;

  factory AtomValidators.fromJson(Map<String, dynamic> json) => AtomValidators(
    validators: json["validators"] == null ? [] : List<Validator>.from(json["validators"]!.map((x) => Validator.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "validators": validators == null ? [] : List<dynamic>.from(validators!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class Pagination {
  Pagination({
    this.nextKey,
    this.total,
  });

  String? nextKey;
  String? total;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    nextKey: json["next_key"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "next_key": nextKey,
    "total": total,
  };
}

class Validator {
  Validator({
    this.operatorAddress,
    this.consensusPubkey,
    this.jailed,
    this.status,
    this.tokens,
    this.delegatorShares,
    this.description,
    this.unbondingHeight,
    this.unbondingTime,
    this.commission,
    this.minSelfDelegation,
  });

  String? operatorAddress;
  ConsensusPubkey? consensusPubkey;
  bool? jailed;
  Status? status;
  int? tokens;
  String? delegatorShares;
  Description? description;
  String? unbondingHeight;
  DateTime? unbondingTime;
  Commission? commission;
  String? minSelfDelegation;

  factory Validator.fromJson(Map<String, dynamic> json) => Validator(
    operatorAddress: json["operator_address"],
    consensusPubkey: json["consensus_pubkey"] == null ? null : ConsensusPubkey.fromJson(json["consensus_pubkey"]),
    jailed: json["jailed"],
    status: statusValues.map[json["status"]]!,
    tokens: int.parse(json["tokens"]),
    delegatorShares: json["delegator_shares"],
    description: json["description"] == null ? null : Description.fromJson(json["description"]),
    unbondingHeight: json["unbonding_height"],
    unbondingTime: json["unbonding_time"] == null ? null : DateTime.parse(json["unbonding_time"]),
    commission: json["commission"] == null ? null : Commission.fromJson(json["commission"]),
    minSelfDelegation: json["min_self_delegation"],
  );

  Map<String, dynamic> toJson() => {
    "operator_address": operatorAddress,
    "consensus_pubkey": consensusPubkey?.toJson(),
    "jailed": jailed,
    "status": statusValues.reverse[status],
    "tokens": tokens,
    "delegator_shares": delegatorShares,
    "description": description?.toJson(),
    "unbonding_height": unbondingHeight,
    "unbonding_time": unbondingTime?.toIso8601String(),
    "commission": commission?.toJson(),
    "min_self_delegation": minSelfDelegation,
  };
}

class Commission {
  Commission({
    this.commissionRates,
    this.updateTime,
  });

  CommissionRates? commissionRates;
  DateTime? updateTime;

  factory Commission.fromJson(Map<String, dynamic> json) => Commission(
    commissionRates: json["commission_rates"] == null ? null : CommissionRates.fromJson(json["commission_rates"]),
    updateTime: json["update_time"] == null ? null : DateTime.parse(json["update_time"]),
  );

  Map<String, dynamic> toJson() => {
    "commission_rates": commissionRates?.toJson(),
    "update_time": updateTime?.toIso8601String(),
  };
}

class CommissionRates {
  CommissionRates({
    this.rate,
    this.maxRate,
    this.maxChangeRate,
  });

  String? rate;
  String? maxRate;
  String? maxChangeRate;

  factory CommissionRates.fromJson(Map<String, dynamic> json) => CommissionRates(
    rate: json["rate"],
    maxRate: json["max_rate"],
    maxChangeRate: json["max_change_rate"],
  );

  Map<String, dynamic> toJson() => {
    "rate": rate,
    "max_rate": maxRate,
    "max_change_rate": maxChangeRate,
  };
}

class ConsensusPubkey {
  ConsensusPubkey({
    this.type,
    this.key,
  });

  Type? type;
  String? key;

  factory ConsensusPubkey.fromJson(Map<String, dynamic> json) => ConsensusPubkey(
    type: typeValues.map[json["@type"]]!,
    key: json["key"],
  );

  Map<String, dynamic> toJson() => {
    "@type": typeValues.reverse[type],
    "key": key,
  };
}

enum Type { COSMOS_CRYPTO_ED25519_PUB_KEY }

final typeValues = EnumValues({
  "/cosmos.crypto.ed25519.PubKey": Type.COSMOS_CRYPTO_ED25519_PUB_KEY
});

class Description {
  Description({
    this.moniker,
    this.identity,
    this.website,
    this.securityContact,
    this.details,
  });

  String? moniker;
  String? identity;
  String? website;
  String? securityContact;
  String? details;

  factory Description.fromJson(Map<String, dynamic> json) => Description(
    moniker: json["moniker"],
    identity: json["identity"],
    website: json["website"],
    securityContact: json["security_contact"],
    details: json["details"],
  );

  Map<String, dynamic> toJson() => {
    "moniker": moniker,
    "identity": identity,
    "website": website,
    "security_contact": securityContact,
    "details": details,
  };
}

enum Status { BOND_STATUS_UNBONDED, BOND_STATUS_BONDED }

final statusValues = EnumValues({
  "BOND_STATUS_BONDED": Status.BOND_STATUS_BONDED,
  "BOND_STATUS_UNBONDED": Status.BOND_STATUS_UNBONDED
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
