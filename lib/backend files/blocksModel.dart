// To parse this JSON data, do
//
//     final blockModel = blockModelFromJson(jsonString);

import 'dart:convert';

List<BlockModel> blockModelFromJson(String str) => List<BlockModel>.from(json.decode(str).map((x) => BlockModel.fromJson(x)));

String blockModelToJson(List<BlockModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BlockModel {
  BlockModel({
    this.height,
    this.timestamp,
    this.hash,
    this.numTxs,
    this.totalGas,
    this.proposerAddress,
  });

  String ?height;
  DateTime? timestamp;
  String ?hash;
  int ?numTxs;
  String? totalGas;
  String ?proposerAddress;

  factory BlockModel.fromJson(Map<String, dynamic> json) => BlockModel(
    height: json["height"],
    timestamp: DateTime.parse(json["timestamp"]),
    hash: json["hash"],
    numTxs: json["num_txs"],
    totalGas: json["total_gas"],
    proposerAddress: json["proposer_address"],
  );

  Map<String, dynamic> toJson() => {
    "height": height,
    "timestamp": timestamp!.toIso8601String(),
    "hash": hash,
    "num_txs": numTxs,
    "total_gas": totalGas,
    "proposer_address": proposerAddress,
  };
}
