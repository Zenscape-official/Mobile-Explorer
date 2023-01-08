// To parse this JSON data, do
//
//     final contractTxModel = contractTxModelFromJson(jsonString);

import 'dart:convert';

List<ContractTxModel> contractTxModelFromJson(String str) => List<ContractTxModel>.from(json.decode(str).map((x) => ContractTxModel.fromJson(x)));

String contractTxModelToJson(List<ContractTxModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ContractTxModel {
  ContractTxModel({
    this.height,
    this.txhash,
    this.codespace,
    this.code,
    this.data,
    this.rawLog,
    this.logs,
    this.info,
    this.gasWanted,
    this.gasUsed,
    this.tx,
    this.timestamp,
    this.events,
  });

  String? height;
  String? txhash;
  String? codespace;
  int? code;
  String? data;
  String? rawLog;
  List<Log>? logs;
  String? info;
  String? gasWanted;
  String? gasUsed;
  Tx? tx;
  DateTime? timestamp;
  List<ContractTxModelEvent>? events;

  factory ContractTxModel.fromJson(Map<String, dynamic> json) => ContractTxModel(
    height: json["height"] == null ? null : json["height"],
    txhash: json["txhash"] == null ? null : json["txhash"],
    codespace: json["codespace"] == null ? null : json["codespace"],
    code: json["code"] == null ? null : json["code"],
    data: json["data"] == null ? null : json["data"],
    rawLog: json["raw_log"] == null ? null : json["raw_log"],
    logs: json["logs"] == null ? null : List<Log>.from(json["logs"].map((x) => Log.fromJson(x))),
    info: json["info"] == null ? null : json["info"],
    gasWanted: json["gas_wanted"] == null ? null : json["gas_wanted"],
    gasUsed: json["gas_used"] == null ? null : json["gas_used"],
    tx: json["tx"] == null ? null : Tx.fromJson(json["tx"]),
    timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
    events: json["events"] == null ? null : List<ContractTxModelEvent>.from(json["events"].map((x) => ContractTxModelEvent.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "height": height == null ? null : height,
    "txhash": txhash == null ? null : txhash,
    "codespace": codespace == null ? null : codespace,
    "code": code == null ? null : code,
    "data": data == null ? null : data,
    "raw_log": rawLog == null ? null : rawLog,
    "logs": logs == null ? null : List<dynamic>.from(logs!.map((x) => x.toJson())),
    "info": info == null ? null : info,
    "gas_wanted": gasWanted == null ? null : gasWanted,
    "gas_used": gasUsed == null ? null : gasUsed,
    "tx": tx == null ? null : tx!.toJson(),
    "timestamp": timestamp == null ? null : timestamp!.toIso8601String(),
    "events": events == null ? null : List<dynamic>.from(events!.map((x) => x.toJson())),
  };
}

class ContractTxModelEvent {
  ContractTxModelEvent({
    this.type,
    this.attributes,
  });

  String? type;
  List<PurpleAttribute>? attributes;

  factory ContractTxModelEvent.fromJson(Map<String, dynamic> json) => ContractTxModelEvent(
    type: json["type"] == null ? null : json["type"],
    attributes: json["attributes"] == null ? null : List<PurpleAttribute>.from(json["attributes"].map((x) => PurpleAttribute.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
    "attributes": attributes == null ? null : List<dynamic>.from(attributes!.map((x) => x.toJson())),
  };
}

class PurpleAttribute {
  PurpleAttribute({
    this.key,
    this.value,
    this.index,
  });

  String? key;
  String? value;
  bool? index;

  factory PurpleAttribute.fromJson(Map<String, dynamic> json) => PurpleAttribute(
    key: json["key"] == null ? null : json["key"],
    value: json["value"] == null ? null : json["value"],
    index: json["index"] == null ? null : json["index"],
  );

  Map<String, dynamic> toJson() => {
    "key": key == null ? null : key,
    "value": value == null ? null : value,
    "index": index == null ? null : index,
  };
}

class Log {
  Log({
    this.msgIndex,
    this.log,
    this.events,
  });

  int? msgIndex;
  String? log;
  List<LogEvent>? events;

  factory Log.fromJson(Map<String, dynamic> json) => Log(
    msgIndex: json["msg_index"] == null ? null : json["msg_index"],
    log: json["log"] == null ? null : json["log"],
    events: json["events"] == null ? null : List<LogEvent>.from(json["events"].map((x) => LogEvent.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "msg_index": msgIndex == null ? null : msgIndex,
    "log": log == null ? null : log,
    "events": events == null ? null : List<dynamic>.from(events!.map((x) => x.toJson())),
  };
}

class LogEvent {
  LogEvent({
    this.type,
    this.attributes,
  });

  String? type;
  List<FluffyAttribute>? attributes;

  factory LogEvent.fromJson(Map<String, dynamic> json) => LogEvent(
    type: json["type"] == null ? null : json["type"],
    attributes: json["attributes"] == null ? null : List<FluffyAttribute>.from(json["attributes"].map((x) => FluffyAttribute.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
    "attributes": attributes == null ? null : List<dynamic>.from(attributes!.map((x) => x.toJson())),
  };
}

class FluffyAttribute {
  FluffyAttribute({
    this.key,
    this.value,
  });

  String? key;
  String? value;

  factory FluffyAttribute.fromJson(Map<String, dynamic> json) => FluffyAttribute(
    key: json["key"] == null ? null : json["key"],
    value: json["value"] == null ? null : json["value"],
  );

  Map<String, dynamic> toJson() => {
    "key": key == null ? null : key,
    "value": value == null ? null : value,
  };
}

class Tx {
  Tx({
    this.type,
    this.body,
    this.authInfo,
    this.signatures,
  });

  String? type;
  Body? body;
  AuthInfo? authInfo;
  List<String>? signatures;

  factory Tx.fromJson(Map<String, dynamic> json) => Tx(
    type: json["@type"] == null ? null : json["@type"],
    body: json["body"] == null ? null : Body.fromJson(json["body"]),
    authInfo: json["auth_info"] == null ? null : AuthInfo.fromJson(json["auth_info"]),
    signatures: json["signatures"] == null ? null : List<String>.from(json["signatures"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "@type": type == null ? null : type,
    "body": body == null ? null : body!.toJson(),
    "auth_info": authInfo == null ? null : authInfo!.toJson(),
    "signatures": signatures == null ? null : List<dynamic>.from(signatures!.map((x) => x)),
  };
}

class AuthInfo {
  AuthInfo({
    this.signerInfos,
    this.fee,
  });

  List<SignerInfo>? signerInfos;
  Fee? fee;

  factory AuthInfo.fromJson(Map<String, dynamic> json) => AuthInfo(
    signerInfos: json["signer_infos"] == null ? null : List<SignerInfo>.from(json["signer_infos"].map((x) => SignerInfo.fromJson(x))),
    fee: json["fee"] == null ? null : Fee.fromJson(json["fee"]),
  );

  Map<String, dynamic> toJson() => {
    "signer_infos": signerInfos == null ? null : List<dynamic>.from(signerInfos!.map((x) => x.toJson())),
    "fee": fee == null ? null : fee!.toJson(),
  };
}

class Fee {
  Fee({
    this.amount,
    this.gasLimit,
    this.payer,
    this.granter,
  });

  List<dynamic>? amount;
  String? gasLimit;
  String? payer;
  String? granter;

  factory Fee.fromJson(Map<String, dynamic> json) => Fee(
    amount: json["amount"] == null ? null : List<dynamic>.from(json["amount"].map((x) => x)),
    gasLimit: json["gas_limit"] == null ? null : json["gas_limit"],
    payer: json["payer"] == null ? null : json["payer"],
    granter: json["granter"] == null ? null : json["granter"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount == null ? null : List<dynamic>.from(amount!.map((x) => x)),
    "gas_limit": gasLimit == null ? null : gasLimit,
    "payer": payer == null ? null : payer,
    "granter": granter == null ? null : granter,
  };
}

class SignerInfo {
  SignerInfo({
    this.publicKey,
    this.modeInfo,
    this.sequence,
  });

  PublicKey? publicKey;
  ModeInfo? modeInfo;
  String? sequence;

  factory SignerInfo.fromJson(Map<String, dynamic> json) => SignerInfo(
    publicKey: json["public_key"] == null ? null : PublicKey.fromJson(json["public_key"]),
    modeInfo: json["mode_info"] == null ? null : ModeInfo.fromJson(json["mode_info"]),
    sequence: json["sequence"] == null ? null : json["sequence"],
  );

  Map<String, dynamic> toJson() => {
    "public_key": publicKey == null ? null : publicKey!.toJson(),
    "mode_info": modeInfo == null ? null : modeInfo!.toJson(),
    "sequence": sequence == null ? null : sequence,
  };
}

class ModeInfo {
  ModeInfo({
    this.single,
  });

  Single? single;

  factory ModeInfo.fromJson(Map<String, dynamic> json) => ModeInfo(
    single: json["single"] == null ? null : Single.fromJson(json["single"]),
  );

  Map<String, dynamic> toJson() => {
    "single": single == null ? null : single!.toJson(),
  };
}

class Single {
  Single({
    this.mode,
  });

  String? mode;

  factory Single.fromJson(Map<String, dynamic> json) => Single(
    mode: json["mode"] == null ? null : json["mode"],
  );

  Map<String, dynamic> toJson() => {
    "mode": mode == null ? null : mode,
  };
}

class PublicKey {
  PublicKey({
    this.type,
    this.key,
  });

  String? type;
  String? key;

  factory PublicKey.fromJson(Map<String, dynamic> json) => PublicKey(
    type: json["@type"] == null ? null : json["@type"],
    key: json["key"] == null ? null : json["key"],
  );

  Map<String, dynamic> toJson() => {
    "@type": type == null ? null : type,
    "key": key == null ? null : key,
  };
}

class Body {
  Body({
    this.messages,
    this.memo,
    this.timeoutHeight,
    this.extensionOptions,
    this.nonCriticalExtensionOptions,
  });

  List<Message>? messages;
  String? memo;
  String? timeoutHeight;
  List<dynamic>? extensionOptions;
  List<dynamic>? nonCriticalExtensionOptions;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    messages: json["messages"] == null ? null : List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
    memo: json["memo"] == null ? null : json["memo"],
    timeoutHeight: json["timeout_height"] == null ? null : json["timeout_height"],
    extensionOptions: json["extension_options"] == null ? null : List<dynamic>.from(json["extension_options"].map((x) => x)),
    nonCriticalExtensionOptions: json["non_critical_extension_options"] == null ? null : List<dynamic>.from(json["non_critical_extension_options"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "messages": messages == null ? null : List<dynamic>.from(messages!.map((x) => x.toJson())),
    "memo": memo == null ? null : memo,
    "timeout_height": timeoutHeight == null ? null : timeoutHeight,
    "extension_options": extensionOptions == null ? null : List<dynamic>.from(extensionOptions!.map((x) => x)),
    "non_critical_extension_options": nonCriticalExtensionOptions == null ? null : List<dynamic>.from(nonCriticalExtensionOptions!.map((x) => x)),
  };
}

class Message {
  Message({
    this.type,
    this.sender,
    this.contract,
    this.msg,
    this.funds,
  });

  String? type;
  String? sender;
  String? contract;
  Msg? msg;
  List<dynamic>? funds;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    type: json["@type"] == null ? null : json["@type"],
    sender: json["sender"] == null ? null : json["sender"],
    contract: json["contract"] == null ? null : json["contract"],
    msg: json["msg"] == null ? null : Msg.fromJson(json["msg"]),
    funds: json["funds"] == null ? null : List<dynamic>.from(json["funds"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "@type": type == null ? null : type,
    "sender": sender == null ? null : sender,
    "contract": contract == null ? null : contract,
    "msg": msg == null ? null : msg!.toJson(),
    "funds": funds == null ? null : List<dynamic>.from(funds!.map((x) => x)),
  };
}

class Msg {
  Msg({
    this.feedEligibleData,
  });

  FeedEligibleData? feedEligibleData;

  factory Msg.fromJson(Map<String, dynamic> json) => Msg(
    feedEligibleData: json["feed_eligible_data"] == null ? null : FeedEligibleData.fromJson(json["feed_eligible_data"]),
  );

  Map<String, dynamic> toJson() => {
    "feed_eligible_data": feedEligibleData == null ? null : feedEligibleData!.toJson(),
  };
}

class FeedEligibleData {
  FeedEligibleData({
    this.chainId,
    this.eligibleRecipient,
  });

  int? chainId;
  List<EligibleRecipient>? eligibleRecipient;

  factory FeedEligibleData.fromJson(Map<String, dynamic> json) => FeedEligibleData(
    chainId: json["chain_id"] == null ? null : json["chain_id"],
    eligibleRecipient: json["eligible_recipient"] == null ? null : List<EligibleRecipient>.from(json["eligible_recipient"].map((x) => EligibleRecipient.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "chain_id": chainId == null ? null : chainId,
    "eligible_recipient": eligibleRecipient == null ? null : List<dynamic>.from(eligibleRecipient!.map((x) => x.toJson())),
  };
}

class EligibleRecipient {
  EligibleRecipient({
    this.recipientAddress,
    this.totalClaimableAmount,
  });

  String? recipientAddress;
  String? totalClaimableAmount;

  factory EligibleRecipient.fromJson(Map<String, dynamic> json) => EligibleRecipient(
    recipientAddress: json["recipient_address"] == null ? null : json["recipient_address"],
    totalClaimableAmount: json["total_claimable_amount"] == null ? null : json["total_claimable_amount"],
  );

  Map<String, dynamic> toJson() => {
    "recipient_address": recipientAddress == null ? null : recipientAddress,
    "total_claimable_amount": totalClaimableAmount == null ? null : totalClaimableAmount,
  };
}
