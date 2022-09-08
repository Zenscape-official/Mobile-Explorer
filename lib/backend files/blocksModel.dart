// To parse this JSON data, do
//
//     final blockModel = blockModelFromJson(jsonString);

import 'dart:convert';

List<BlockModel> blockModelFromJson(String str) => List<BlockModel>.from(json.decode(str).map((x) => BlockModel.fromJson(x)));

String blockModelToJson(List<BlockModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BlockModel {
  BlockModel({
    this.id,
    this.chainid,
    this.height,
    this.proposer,
    this.operatorAddress,
    this.moniker,
    this.blockHash,
    this.identity,
    this.numSignatures,
    this.numTxs,
    this.txs,
    this.timestamp,
  });

  int? id;
  String? chainid;
  int? height;
  String? proposer;
  String? operatorAddress;
  String? moniker;
  String? blockHash;
  String? identity;
  int? numSignatures;
  int? numTxs;
  dynamic txs;
  DateTime? timestamp;

  factory BlockModel.fromJson(Map<String, dynamic> json) => BlockModel(
    id: json["id"],
    chainid: json["chainid"],
    height: json["height"],
    proposer: json["proposer"],
    operatorAddress: json["operator_address"],
    moniker: json["moniker"],
    blockHash: json["block_hash"],
    identity: json["identity"] == null ? null : json["identity"],
    numSignatures: json["num_signatures"],
    numTxs: json["num_txs"],
    txs: json["txs"],
    timestamp: DateTime.parse(json["timestamp"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "chainid": chainidValues.reverse[chainid],
    "height": height,
    "proposer": proposer,
    "operator_address": operatorAddress,
    "moniker": moniker,
    "block_hash": blockHash,
    "identity": identity == null ? null : identity,
    "num_signatures": numSignatures,
    "num_txs": numTxs,
    "txs": txs,
    "timestamp": timestamp!.toIso8601String(),
  };
}

enum Chainid { AKASHNET_2 }

final chainidValues = EnumValues({
  "akashnet-2": Chainid.AKASHNET_2
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
