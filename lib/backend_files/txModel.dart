// To parse this JSON data, do
//
//     final txModel = txModelFromJson(jsonString);

import 'dart:convert';

List<TxModel> txModelFromJson(String str) => List<TxModel>.from(json.decode(str).map((x) => TxModel.fromJson(x)));

String txModelToJson(List<TxModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TxModel {
  TxModel({
    this.hash,
    this.height,
    this.success,
    this.messages,
    this.fee,
    this.gasWanted,
    this.gasUsed,
    //this.rawLog,
    this.memo,
  });

  String? hash;
  String? height;
  bool? success;
  List<Message>? messages;
  Fee ?fee;
  String? gasWanted;
  String? gasUsed;
  //List<RawLog>? rawLog;
  String? memo;

  factory TxModel.fromJson(Map<String, dynamic> json) => TxModel(
    hash: json["hash"],
    height: json["height"],
    success: json["success"],
    messages: List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
    fee: Fee.fromJson(json["fee"]),
    gasWanted: json["gas_wanted"],
    gasUsed: json["gas_used"],
   // rawLog: List<RawLog>.from(json["raw_log"].map((x) => RawLog.fromJson(x))),
    memo: json["memo"],
  );

  Map<String, dynamic> toJson() => {
    "hash": hash,
    "height": height,
    "success": success,
    "messages": List<dynamic>.from(messages!.map((x) => x.toJson())),
    "fee": fee!.toJson(),
    "gas_wanted": gasWanted,
    "gas_used": gasUsed,
    //"raw_log": List<dynamic>.from(rawLog!.map((x) => x.toJson())),
    "memo": memo,
  };
}

class Fee {
  Fee({
    this.payer,
    this.amount,
    this.granter,
    this.gasLimit,
  });

  String? payer;
  List<Amount>? amount;
  String? granter;
  String? gasLimit;

  factory Fee.fromJson(Map<String, dynamic> json) => Fee(
    payer: json["payer"],
    amount: List<Amount>.from(json["amount"].map((x) => Amount.fromJson(x))),
    granter: json["granter"],
    gasLimit: json["gas_limit"],
  );

  Map<String, dynamic> toJson() => {
    "payer": payer,
    "amount": List<dynamic>.from(amount!.map((x) => x.toJson())),
    "granter": granter,
    "gas_limit": gasLimit,
  };
}

class Amount {
  Amount({
    this.denom,
    this.amount,
  });

  String? denom;
  String? amount;

  factory Amount.fromJson(Map<String, dynamic> json) => Amount(
    denom: json["denom"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "denom": denom,
    "amount": amount,
  };
}

class Message {
  Message({
    this.type,
    this.header,
    this.signer,
    this.clientId,
    this.packet,
    this.proofAcked,
    this.proofHeight,
    this.acknowledgement,
  });

  String? type;
  MessageHeader? header;
  String? signer;
  String? clientId;
  Packet? packet;
  String? proofAcked;
  Height? proofHeight;
  String? acknowledgement;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    type: json["@type"],
    header: json["header"] == null ? null : MessageHeader.fromJson(json["header"]),
    signer: json["signer"],
    clientId: json["client_id"],
    packet: json["packet"] == null ? null : Packet.fromJson(json["packet"]),
    proofAcked: json["proof_acked"],
    proofHeight: json["proof_height"] == null ? null : Height.fromJson(json["proof_height"]),
    acknowledgement: json["acknowledgement"],
  );

  Map<String, dynamic> toJson() => {
    "@type": type,
    "header": header == null ? null : header!.toJson(),
    "signer": signer,
    "client_id": clientId,
    "packet": packet == null ? null : packet!.toJson(),
    "proof_acked": proofAcked,
    "proof_height": proofHeight == null ? null : proofHeight!.toJson(),
    "acknowledgement": acknowledgement,
  };
}

class MessageHeader {
  MessageHeader({
    this.type,
    this.signedHeader,
    this.validatorSet,
    this.trustedHeight,
    this.trustedValidators,
  });

  String? type;
  SignedHeader? signedHeader;
  TrustedValidators? validatorSet;
  Height? trustedHeight;
  TrustedValidators? trustedValidators;

  factory MessageHeader.fromJson(Map<String, dynamic> json) => MessageHeader(
    type: json["@type"],
    signedHeader: SignedHeader.fromJson(json["signed_header"]),
    validatorSet: TrustedValidators.fromJson(json["validator_set"]),
    trustedHeight: Height.fromJson(json["trusted_height"]),
    trustedValidators: TrustedValidators.fromJson(json["trusted_validators"]),
  );

  Map<String, dynamic> toJson() => {
    "@type": type,
    "signed_header": signedHeader!.toJson(),
    "validator_set": validatorSet!.toJson(),
    "trusted_height": trustedHeight!.toJson(),
    "trusted_validators": trustedValidators!.toJson(),
  };
}

class SignedHeader {
  SignedHeader({
    this.commit,
    this.header,
  });

  Commit? commit;
  SignedHeaderHeader? header;

  factory SignedHeader.fromJson(Map<String, dynamic> json) => SignedHeader(
    commit: Commit.fromJson(json["commit"]),
    header: SignedHeaderHeader.fromJson(json["header"]),
  );

  Map<String, dynamic> toJson() => {
    "commit": commit!.toJson(),
    "header": header!.toJson(),
  };
}

class Commit {
  Commit({
    this.round,
    this.height,
    this.blockId,
    this.signatures,
  });

  int? round;
  String? height;
  BlockId? blockId;
  List<Signature>? signatures;

  factory Commit.fromJson(Map<String, dynamic> json) => Commit(
    round: json["round"],
    height: json["height"],
    blockId: BlockId.fromJson(json["block_id"]),
    signatures: List<Signature>.from(json["signatures"].map((x) => Signature.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "round": round,
    "height": height,
    "block_id": blockId!.toJson(),
    "signatures": List<dynamic>.from(signatures!.map((x) => x.toJson())),
  };
}

class BlockId {
  BlockId({
    this.hash,
    this.partSetHeader,
  });

  String? hash;
  PartSetHeader? partSetHeader;

  factory BlockId.fromJson(Map<String, dynamic> json) => BlockId(
    hash: json["hash"],
    partSetHeader: PartSetHeader.fromJson(json["part_set_header"]),
  );

  Map<String, dynamic> toJson() => {
    "hash": hash,
    "part_set_header": partSetHeader!.toJson(),
  };
}

class PartSetHeader {
  PartSetHeader({
    this.hash,
    this.total,
  });

  String? hash;
  int? total;

  factory PartSetHeader.fromJson(Map<String, dynamic> json) => PartSetHeader(
    hash: json["hash"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "hash": hash,
    "total": total,
  };
}

class Signature {
  Signature({
    this.signature,
    this.timestamp,
    this.blockIdFlag,
    this.validatorAddress,
  });

  String? signature;
  DateTime? timestamp;
  BlockIdFlag? blockIdFlag;
  String? validatorAddress;

  factory Signature.fromJson(Map<String, dynamic> json) => Signature(
    signature: json["signature"],
    timestamp: DateTime.parse(json["timestamp"]),
    blockIdFlag: blockIdFlagValues.map[json["block_id_flag"]],
    validatorAddress: json["validator_address"],
  );

  Map<String, dynamic> toJson() => {
    "signature": signature,
    "timestamp": timestamp!.toIso8601String(),
    "block_id_flag": blockIdFlagValues.reverse[blockIdFlag],
    "validator_address": validatorAddress,
  };
}

enum BlockIdFlag { BLOCK_ID_FLAG_COMMIT }

final blockIdFlagValues = EnumValues({
  "BLOCK_ID_FLAG_COMMIT": BlockIdFlag.BLOCK_ID_FLAG_COMMIT
});

class SignedHeaderHeader {
  SignedHeaderHeader({
    this.time,
    this.height,
    this.version,
    this.appHash,
    this.chainId,
    this.dataHash,
    this.evidenceHash,
    this.lastBlockId,
    this.consensusHash,
    this.validatorsHash,
    this.lastCommitHash,
    this.proposerAddress,
    this.lastResultsHash,
    this.nextValidatorsHash,
  });

  DateTime? time;
  String? height;
  Version? version;
  String? appHash;
  String? chainId;
  String? dataHash;
  String? evidenceHash;
  BlockId? lastBlockId;
  String? consensusHash;
  String? validatorsHash;
  String? lastCommitHash;
  String? proposerAddress;
  String? lastResultsHash;
  String? nextValidatorsHash;

  factory SignedHeaderHeader.fromJson(Map<String, dynamic> json) => SignedHeaderHeader(
    time: DateTime.parse(json["time"]),
    height: json["height"],
    version: Version.fromJson(json["version"]),
    appHash: json["app_hash"],
    chainId: json["chain_id"],
    dataHash: json["data_hash"],
    evidenceHash: json["evidence_hash"],
    lastBlockId: BlockId.fromJson(json["last_block_id"]),
    consensusHash: json["consensus_hash"],
    validatorsHash: json["validators_hash"],
    lastCommitHash: json["last_commit_hash"],
    proposerAddress: json["proposer_address"],
    lastResultsHash: json["last_results_hash"],
    nextValidatorsHash: json["next_validators_hash"],
  );

  Map<String, dynamic> toJson() => {
    "time": time!.toIso8601String(),
    "height": height,
    "version": version!.toJson(),
    "app_hash": appHash,
    "chain_id": chainId,
    "data_hash": dataHash,
    "evidence_hash": evidenceHash,
    "last_block_id": lastBlockId!.toJson(),
    "consensus_hash": consensusHash,
    "validators_hash": validatorsHash,
    "last_commit_hash": lastCommitHash,
    "proposer_address": proposerAddress,
    "last_results_hash": lastResultsHash,
    "next_validators_hash": nextValidatorsHash,
  };
}

class Version {
  Version({
    this.app,
    this.block,
  });

  String? app;
  String? block;

  factory Version.fromJson(Map<String, dynamic> json) => Version(
    app: json["app"],
    block: json["block"],
  );

  Map<String, dynamic> toJson() => {
    "app": app,
    "block": block,
  };
}

class Height {
  Height({
    this.revisionHeight,
    this.revisionNumber,
  });

  String? revisionHeight;
  String? revisionNumber;

  factory Height.fromJson(Map<String, dynamic> json) => Height(
    revisionHeight: json["revision_height"],
    revisionNumber: json["revision_number"],
  );

  Map<String, dynamic> toJson() => {
    "revision_height": revisionHeight,
    "revision_number": revisionNumber,
  };
}

class TrustedValidators {
  TrustedValidators({
    this.proposer,
    this.validators,
    this.totalVotingPower,
  });

  Proposer? proposer;
  List<Proposer>? validators;
  String? totalVotingPower;

  factory TrustedValidators.fromJson(Map<String, dynamic> json) => TrustedValidators(
    proposer: Proposer.fromJson(json["proposer"]),
    validators: List<Proposer>.from(json["validators"].map((x) => Proposer.fromJson(x))),
    totalVotingPower: json["total_voting_power"],
  );

  Map<String, dynamic> toJson() => {
    "proposer": proposer!.toJson(),
    "validators": List<dynamic>.from(validators!.map((x) => x.toJson())),
    "total_voting_power": totalVotingPower,
  };
}

class Proposer {
  Proposer({
    this.address,
    this.pubKey,
    this.votingPower,
    this.proposerPriority,
  });

  String? address;
  PubKey? pubKey;
  String? votingPower;
  String? proposerPriority;

  factory Proposer.fromJson(Map<String, dynamic> json) => Proposer(
    address: json["address"],
    pubKey: PubKey.fromJson(json["pub_key"]),
    votingPower: json["voting_power"],
    proposerPriority: json["proposer_priority"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "pub_key": pubKey!.toJson(),
    "voting_power": votingPower,
    "proposer_priority": proposerPriority,
  };
}

class PubKey {
  PubKey({
    this.secp256K1,
  });

  String? secp256K1;

  factory PubKey.fromJson(Map<String, dynamic> json) => PubKey(
    secp256K1: json["secp256k1"],
  );

  Map<String, dynamic> toJson() => {
    "secp256k1": secp256K1,
  };
}

class Packet {
  Packet({
    this.data,
    this.sequence,
    this.sourcePort,
    this.sourceChannel,
    this.timeoutHeight,
    this.destinationPort,
    this.timeoutTimestamp,
    this.destinationChannel,
  });

  String? data;
  String? sequence;
  String? sourcePort;
  String? sourceChannel;
  Height? timeoutHeight;
  String? destinationPort;
  String? timeoutTimestamp;
  String? destinationChannel;

  factory Packet.fromJson(Map<String, dynamic> json) => Packet(
    data: json["data"],
    sequence: json["sequence"],
    sourcePort: json["source_port"],
    sourceChannel: json["source_channel"],
    timeoutHeight: Height.fromJson(json["timeout_height"]),
    destinationPort: json["destination_port"],
    timeoutTimestamp: json["timeout_timestamp"],
    destinationChannel: json["destination_channel"],
  );

  Map<String, dynamic> toJson() => {
    "data": data,
    "sequence": sequence,
    "source_port": sourcePort,
    "source_channel": sourceChannel,
    "timeout_height": timeoutHeight!.toJson(),
    "destination_port": destinationPort,
    "timeout_timestamp": timeoutTimestamp,
    "destination_channel": destinationChannel,
  };
}

class RawLog {
  RawLog({
    this.events,
    this.msgIndex,
  });

  List<Event>? events;
  int? msgIndex;

  factory RawLog.fromJson(Map<String, dynamic> json) => RawLog(
    events: List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
    msgIndex: json["msg_index"],
  );

  Map<String, dynamic> toJson() => {
    "events": List<dynamic>.from(events!.map((x) => x.toJson())),
    "msg_index": msgIndex,
  };
}

class Event {
  Event({
    this.type,
    this.attributes,
  });

  String? type;
  List<Attribute>? attributes;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    type: json["type"],
    attributes: List<Attribute>.from(json["attributes"].map((x) => Attribute.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "attributes": List<dynamic>.from(attributes!.map((x) => x.toJson())),
  };
}

class Attribute {
  Attribute({
    this.key,
    this.value,
  });

  String? key;
  String? value;

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
    key: json["key"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "value": value,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
