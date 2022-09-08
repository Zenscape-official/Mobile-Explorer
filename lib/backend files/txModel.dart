// To parse this JSON data, do
//
//     final txModel = txModelFromJson(jsonString);

import 'dart:convert';

List<TxModel> txModelFromJson(String str) => List<TxModel>.from(json.decode(str).map((x) => TxModel.fromJson(x)));

String txModelToJson(List<TxModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TxModel {
  TxModel({
    this.header,
    this.data,
  });

  Header? header;
  Data? data;

  factory TxModel.fromJson(Map<String, dynamic> json) => TxModel(
    header: Header.fromJson(json["header"]),
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "header": header!.toJson(),
    "data": data!.toJson(),
  };
}

class Data {
  Data({
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
  List<DataEvent>? events;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    height: json["height"],
    txhash: json["txhash"],
    codespace: json["codespace"],
    code: json["code"],
    data: json["data"],
    rawLog: json["raw_log"],
    logs: List<Log>.from(json["logs"].map((x) => Log.fromJson(x))),
    info: json["info"],
    gasWanted: json["gas_wanted"],
    gasUsed: json["gas_used"],
    tx: Tx.fromJson(json["tx"]),
    timestamp: DateTime.parse(json["timestamp"]),
    events: List<DataEvent>.from(json["events"].map((x) => DataEvent.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "height": height,
    "txhash": txhash,
    "codespace": codespace,
    "code": code,
    "data": data,
    "raw_log": rawLog,
    "logs": List<dynamic>.from(logs!.map((x) => x.toJson())),
    "info": info,
    "gas_wanted": gasWanted,
    "gas_used": gasUsed,
    "tx": tx!.toJson(),
    "timestamp": timestamp!.toIso8601String(),
    "events": List<dynamic>.from(events!.map((x) => x.toJson())),
  };
}

class DataEvent {
  DataEvent({
    this.type,
    this.attributes,
  });

  Type? type;
  List<PurpleAttribute>? attributes;

  factory DataEvent.fromJson(Map<String, dynamic> json) => DataEvent(
    type: typeValues.map![json["type"]],
    attributes: List<PurpleAttribute>.from(json["attributes"].map((x) => PurpleAttribute.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "type": typeValues.reverse[type],
    "attributes": List<dynamic>.from(attributes!.map((x) => x.toJson())),
  };
}

class PurpleAttribute {
  PurpleAttribute({
    this.key,
    this.value,
    this.index,
  });

  PurpleKey? key;
  String? value;
  bool? index;

  factory PurpleAttribute.fromJson(Map<String, dynamic> json) => PurpleAttribute(
    key: purpleKeyValues.map![json["key"]],
    value: json["value"],
    index: json["index"],
  );

  Map<String, dynamic> toJson() => {
    "key": purpleKeyValues.reverse[key],
    "value": value,
    "index": index,
  };
}

enum PurpleKey { C3_BLBM_RLCG, YW1_VD_W50, CM_VJ_Z_WL2_ZXI, CM_VJA_X_BP_ZW50, C2_VU_ZG_VY, ZM_VL, YW_NJ_X3_NLC_Q, C2_LNBM_F0_D_X_JL, YWN0_A_W9_U, B_W9_KD_WXL, DM_FSA_W_RHD_G9_Y, BM_V3_X3_NO_YX_JLCW }

final purpleKeyValues = EnumValues({
  "bmV3X3NoYXJlcw==": PurpleKey.BM_V3_X3_NO_YX_JLCW,
  "bW9kdWxl": PurpleKey.B_W9_KD_WXL,
  "c2lnbmF0dXJl": PurpleKey.C2_LNBM_F0_D_X_JL,
  "c2VuZGVy": PurpleKey.C2_VU_ZG_VY,
  "c3BlbmRlcg==": PurpleKey.C3_BLBM_RLCG,
  "cmVjaXBpZW50": PurpleKey.CM_VJA_X_BP_ZW50,
  "cmVjZWl2ZXI=": PurpleKey.CM_VJ_Z_WL2_ZXI,
  "dmFsaWRhdG9y": PurpleKey.DM_FSA_W_RHD_G9_Y,
  "YW1vdW50": PurpleKey.YW1_VD_W50,
  "YWN0aW9u": PurpleKey.YWN0_A_W9_U,
  "YWNjX3NlcQ==": PurpleKey.YW_NJ_X3_NLC_Q,
  "ZmVl": PurpleKey.ZM_VL
});

enum Type { COIN_SPENT, COIN_RECEIVED, TRANSFER, MESSAGE, TX, DELEGATE }

final typeValues = EnumValues({
  "coin_received": Type.COIN_RECEIVED,
  "coin_spent": Type.COIN_SPENT,
  "delegate": Type.DELEGATE,
  "message": Type.MESSAGE,
  "transfer": Type.TRANSFER,
  "tx": Type.TX
});

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
    msgIndex: json["msg_index"],
    log: json["log"],
    events: List<LogEvent>.from(json["events"].map((x) => LogEvent.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "msg_index": msgIndex,
    "log": log,
    "events": List<dynamic>.from(events!.map((x) => x.toJson())),
  };
}

class LogEvent {
  LogEvent({
    this.type,
    this.attributes,
  });

  Type? type;
  List<FluffyAttribute>? attributes;

  factory LogEvent.fromJson(Map<String, dynamic> json) => LogEvent(
    type: typeValues.map![json["type"]],
    attributes: List<FluffyAttribute>.from(json["attributes"].map((x) => FluffyAttribute.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "type": typeValues.reverse[type],
    "attributes": List<dynamic>.from(attributes!.map((x) => x.toJson())),
  };
}

class FluffyAttribute {
  FluffyAttribute({
    this.key,
    this.value,
  });

  FluffyKey? key;
  String? value;

  factory FluffyAttribute.fromJson(Map<String, dynamic> json) => FluffyAttribute(
    key: fluffyKeyValues.map![json["key"]],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "key": fluffyKeyValues.reverse[key],
    "value": value,
  };
}

enum FluffyKey { RECEIVER, AMOUNT, SPENDER, ACTION, SENDER, RECIPIENT, MODULE, VALIDATOR, NEW_SHARES }

final fluffyKeyValues = EnumValues({
  "action": FluffyKey.ACTION,
  "amount": FluffyKey.AMOUNT,
  "module": FluffyKey.MODULE,
  "new_shares": FluffyKey.NEW_SHARES,
  "receiver": FluffyKey.RECEIVER,
  "recipient": FluffyKey.RECIPIENT,
  "sender": FluffyKey.SENDER,
  "spender": FluffyKey.SPENDER,
  "validator": FluffyKey.VALIDATOR
});

class Tx {
  Tx({
    this.type,
    this.body,
    this.authInfo,
    this.signatures,
  });

  TxType? type;
  Body? body;
  AuthInfo? authInfo;
  List<String>? signatures;

  factory Tx.fromJson(Map<String, dynamic> json) => Tx(
    type: txTypeValues.map![json["@type"]],
    body: Body.fromJson(json["body"]),
    authInfo: AuthInfo.fromJson(json["auth_info"]),
    signatures: List<String>.from(json["signatures"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "@type": txTypeValues.reverse[type],
    "body": body!.toJson(),
    "auth_info": authInfo!.toJson(),
    "signatures": List<dynamic>.from(signatures!.map((x) => x)),
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
    signerInfos: List<SignerInfo>.from(json["signer_infos"].map((x) => SignerInfo.fromJson(x))),
    fee: Fee.fromJson(json["fee"]),
  );

  Map<String, dynamic> toJson() => {
    "signer_infos": List<dynamic>.from(signerInfos!.map((x) => x.toJson())),
    "fee": fee!.toJson(),
  };
}

class Fee {
  Fee({
    this.amount,
    this.gasLimit,
    this.payer,
    this.granter,
  });

  List<AmountElement>? amount;
  String? gasLimit;
  String? payer;
  String? granter;

  factory Fee.fromJson(Map<String, dynamic> json) => Fee(
    amount: List<AmountElement>.from(json["amount"].map((x) => AmountElement.fromJson(x))),
    gasLimit: json["gas_limit"],
    payer: json["payer"],
    granter: json["granter"],
  );

  Map<String, dynamic> toJson() => {
    "amount": List<dynamic>.from(amount!.map((x) => x.toJson())),
    "gas_limit": gasLimit,
    "payer": payer,
    "granter": granter,
  };
}

class AmountElement {
  AmountElement({
    this.denom,
    this.amount,
  });

  String? denom;
  String? amount;

  factory AmountElement.fromJson(Map<String, dynamic> json) => AmountElement(
    denom: json["denom"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "denom": denomValues.reverse[denom],
    "amount": amount,
  };
}

enum Denom { UAKT }

final denomValues = EnumValues({
  "uakt": Denom.UAKT
});

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
    publicKey: PublicKey.fromJson(json["public_key"]),
    modeInfo: ModeInfo.fromJson(json["mode_info"]),
    sequence: json["sequence"],
  );

  Map<String, dynamic> toJson() => {
    "public_key": publicKey?.toJson(),
    "mode_info": modeInfo?.toJson(),
    "sequence": sequence,
  };
}

class ModeInfo {
  ModeInfo({
    this.single,
  });

  Single? single;

  factory ModeInfo.fromJson(Map<String, dynamic> json) => ModeInfo(
    single: Single.fromJson(json["single"]),
  );

  Map<String, dynamic> toJson() => {
    "single": single?.toJson(),
  };
}

class Single {
  Single({
    this.mode,
  });

  Mode? mode;

  factory Single.fromJson(Map<String, dynamic> json) => Single(
    mode: modeValues.map![json["mode"]],
  );

  Map<String, dynamic> toJson() => {
    "mode": modeValues.reverse[mode],
  };
}

enum Mode { SIGN_MODE_DIRECT, SIGN_MODE_LEGACY_AMINO_JSON }

final modeValues = EnumValues({
  "SIGN_MODE_DIRECT": Mode.SIGN_MODE_DIRECT,
  "SIGN_MODE_LEGACY_AMINO_JSON": Mode.SIGN_MODE_LEGACY_AMINO_JSON
});

class PublicKey {
  PublicKey({
    this.type,
    this.key,
  });

  PublicKeyType? type;
  String? key;

  factory PublicKey.fromJson(Map<String, dynamic> json) => PublicKey(
    type: publicKeyTypeValues.map![json["@type"]],
    key: json["key"],
  );

  Map<String, dynamic> toJson() => {
    "@type": publicKeyTypeValues.reverse[type],
    "key": key,
  };
}

enum PublicKeyType { COSMOS_CRYPTO_SECP256_K1_PUB_KEY }

final publicKeyTypeValues = EnumValues({
  "/cosmos.crypto.secp256k1.PubKey": PublicKeyType.COSMOS_CRYPTO_SECP256_K1_PUB_KEY
});

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
    messages: List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
    memo: json["memo"],
    timeoutHeight: json["timeout_height"],
    extensionOptions: List<dynamic>.from(json["extension_options"].map((x) => x)),
    nonCriticalExtensionOptions: List<dynamic>.from(json["non_critical_extension_options"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "messages": List<dynamic>.from(messages!.map((x) => x.toJson())),
    "memo": memoValues.reverse[memo],
    "timeout_height": timeoutHeight,
    "extension_options": List<dynamic>.from(extensionOptions!.map((x) => x)),
    "non_critical_extension_options": List<dynamic>.from(nonCriticalExtensionOptions!.map((x) => x)),
  };
}

enum Memo { EMPTY, RE_STAKED_BY_LAVENDER_FIVE_NODES }

final memoValues = EnumValues({
  "": Memo.EMPTY,
  "REStaked by  Lavender.Five Nodes \ud83d\udc1d": Memo.RE_STAKED_BY_LAVENDER_FIVE_NODES
});

class Message {
  Message({
    this.type,
    this.bidId,
    this.fromAddress,
    this.toAddress,
    this.amount,
    this.delegatorAddress,
    this.validatorAddress,
    this.grantee,
    this.msgs,
  });

  String? type;
  BidId? bidId;
  String? fromAddress;
  String? toAddress;
  dynamic amount;
  String? delegatorAddress;
  String? validatorAddress;
  String? grantee;
  List<Msg>? msgs;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    type: json["@type"],
    bidId: json["bid_id"] == null ? null : BidId.fromJson(json["bid_id"]),
    fromAddress: json["from_address"],
    toAddress: json["to_address"] == null ? null : json["to_address"],
    amount: json["amount"],
    delegatorAddress: json["delegator_address"] == null ? null : json["delegator_address"],
    validatorAddress: json["validator_address"] == null ? null : json["validator_address"],
    grantee: json["grantee"] == null ? null : json["grantee"],
    msgs: json["msgs"] == null ? null : List<Msg>.from(json["msgs"].map((x) => Msg.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "@type": type,
    "bid_id": bidId == null ? null : bidId!.toJson(),
    "from_address": fromAddress == null ? null : fromAddress,
    "to_address": toAddress == null ? null : toAddress,
    "amount": amount,
    "delegator_address": delegatorAddress == null ? null : delegatorAddress,
    "validator_address": validatorAddress == null ? null : validatorAddress,
    "grantee": grantee == null ? null : grantee,
    "msgs": msgs == null ? null : List<dynamic>.from(msgs!.map((x) => x.toJson())),
  };
}

class BidId {
  BidId({
    this.owner,
    this.dseq,
    this.gseq,
    this.oseq,
    this.provider,
  });

  String? owner;
  String? dseq;
  int? gseq;
  int? oseq;
  String? provider;

  factory BidId.fromJson(Map<String, dynamic> json) => BidId(
    owner: json["owner"],
    dseq: json["dseq"],
    gseq: json["gseq"],
    oseq: json["oseq"],
    provider: json["provider"],
  );

  Map<String, dynamic> toJson() => {
    "owner": owner,
    "dseq": dseq,
    "gseq": gseq,
    "oseq": oseq,
    "provider": provider,
  };
}

class Msg {
  Msg({
    this.type,
    this.delegatorAddress,
    this.validatorAddress,
    this.amount,
  });

  MsgType? type;
  String? delegatorAddress;
  ValidatorAddress? validatorAddress;
  AmountElement? amount;

  factory Msg.fromJson(Map<String, dynamic> json) => Msg(
    type: msgTypeValues.map![json["@type"]],
    delegatorAddress: json["delegator_address"],
    validatorAddress: validatorAddressValues.map![json["validator_address"]],
    amount: AmountElement.fromJson(json["amount"]),
  );

  Map<String, dynamic> toJson() => {
    "@type": msgTypeValues.reverse[type],
    "delegator_address": delegatorAddress,
    "validator_address": validatorAddressValues.reverse[validatorAddress],
    "amount": amount!.toJson(),
  };
}

enum MsgType { COSMOS_STAKING_V1_BETA1_MSG_DELEGATE }

final msgTypeValues = EnumValues({
  "/cosmos.staking.v1beta1.MsgDelegate": MsgType.COSMOS_STAKING_V1_BETA1_MSG_DELEGATE
});

enum ValidatorAddress { AKASHVALOPER140_L6_Y2_GP3_GXVAY6_QTN70_RE7_Z2_S0_GN57_ZTQS903 }

final validatorAddressValues = EnumValues({
  "akashvaloper140l6y2gp3gxvay6qtn70re7z2s0gn57ztqs903": ValidatorAddress.AKASHVALOPER140_L6_Y2_GP3_GXVAY6_QTN70_RE7_Z2_S0_GN57_ZTQS903
});

enum TxType { COSMOS_TX_V1_BETA1_TX }

final txTypeValues = EnumValues({
  "/cosmos.tx.v1beta1.Tx": TxType.COSMOS_TX_V1_BETA1_TX
});

class Header {
  Header({
    this.id,
    this.chainId,
    this.blockId,
    this.timestamp,
  });

  int? id;
  String? chainId;
  int? blockId;
  DateTime? timestamp;

  factory Header.fromJson(Map<String, dynamic> json) => Header(
    id: json["id"],
    chainId: json["chain_id"],
    blockId: json["block_id"],
    timestamp: DateTime.parse(json["timestamp"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "chain_id": chainIdValues.reverse[chainId],
    "block_id": blockId,
    "timestamp": timestamp!.toIso8601String(),
  };
}

enum ChainId { AKASHNET_2 }

final chainIdValues = EnumValues({
  "akashnet-2": ChainId.AKASHNET_2
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map!.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
