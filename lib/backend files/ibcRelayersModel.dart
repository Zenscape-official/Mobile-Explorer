// To parse this JSON data, do
//
//     final ibcModel = ibcModelFromJson(jsonString);

import 'dart:convert';

IbcModel ibcModelFromJson(String str) => IbcModel.fromJson(json.decode(str));

String ibcModelToJson(IbcModel data) => json.encode(data.toJson());

class IbcModel {
  IbcModel({
    this.sendable,
  });

  List<Sendable>? sendable;

  factory IbcModel.fromJson(Map<String, dynamic> json) => IbcModel(
    sendable: List<Sendable>.from(json["sendable"].map((x) => Sendable.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "sendable": List<dynamic>.from(sendable!.map((x) => x.toJson())),
  };
}

class Sendable {
  Sendable({
    this.chainId,
    this.paths,
  });

  String? chainId;
  List<Path>? paths;

  factory Sendable.fromJson(Map<String, dynamic> json) => Sendable(
    chainId: json["chain_id"],
    paths: List<Path>.from(json["paths"].map((x) => Path.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "chain_id": chainId,
    "paths": List<dynamic>.from(paths!.map((x) => x.toJson())),
  };
}

class Path {
  Path({
    this.channelId,
    this.portId,
    this.channelState,
    this.counterParty,
    this.stats,
    this.createdAt,
    this.auth,
    this.relayerImg,
  });

  String? channelId;
  PortId? portId;
  ChannelState? channelState;
  CounterParty? counterParty;
  Stats? stats;
  DateTime? createdAt;
  bool? auth;
  String? relayerImg;

  factory Path.fromJson(Map<String, dynamic> json) => Path(
    channelId: json["channel_id"],
    portId: portIdValues.map[json["port_id"]],
    channelState: channelStateValues.map[json["channel_state"]],
    counterParty: CounterParty.fromJson(json["counter_party"]),
    stats: Stats.fromJson(json["stats"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    auth: json["auth"] == null ? null : json["auth"],
    relayerImg: json["relayer_img"] == null ? null : json["relayer_img"],
  );

  Map<String, dynamic> toJson() => {
    "channel_id": channelId,
    "port_id": portIdValues.reverse[portId],
    "channel_state": channelStateValues.reverse[channelState],
    "counter_party": counterParty!.toJson(),
    "stats": stats!.toJson(),
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "auth": auth == null ? null : auth,
    "relayer_img": relayerImg == null ? null : relayerImg,
  };
}

enum ChannelState { STATE_OPEN, STATE_INIT, STATE_TRYOPEN }

final channelStateValues = EnumValues({
  "STATE_INIT": ChannelState.STATE_INIT,
  "STATE_OPEN": ChannelState.STATE_OPEN,
  "STATE_TRYOPEN": ChannelState.STATE_TRYOPEN
});

class CounterParty {
  CounterParty({
    this.channelId,
    this.portId,
    this.channelState,
  });

  String? channelId;
  PortId ?portId;
  ChannelState? channelState;

  factory CounterParty.fromJson(Map<String, dynamic> json) => CounterParty(
    channelId: json["channel_id"] == null ? null : json["channel_id"],
    portId: portIdValues.map[json["port_id"]],
    channelState: json["channel_state"] == null ? null : channelStateValues.map[json["channel_state"]],
  );

  Map<String, dynamic> toJson() => {
    "channel_id": channelId == null ? null : channelId,
    "port_id": portIdValues.reverse[portId],
    "channel_state": channelState == null ? null : channelStateValues.reverse[channelState],
  };
}

enum PortId { TRANSFER }

final portIdValues = EnumValues({
  "transfer": PortId.TRANSFER
});

class Stats {
  Stats({
    this.current,
    this.past,
  });

  Current? current;
  Current? past;

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
    current: Current.fromJson(json["current"]),
    past: Current.fromJson(json["past"]),
  );

  Map<String, dynamic> toJson() => {
    "current": current!.toJson(),
    "past": past!.toJson(),
  };
}

class Current {
  Current({
    this.txNum,
    this.vol,
  });

  TxNum? txNum;
  Vol? vol;

  factory Current.fromJson(Map<String, dynamic> json) => Current(
    txNum: TxNum.fromJson(json["tx_num"]),
    vol: Vol.fromJson(json["vol"]),
  );

  Map<String, dynamic> toJson() => {
    "tx_num": txNum!.toJson(),
    "vol": vol!.toJson(),
  };
}

class TxNum {
  TxNum({
    this.transfer,
    this.receive,
  });

  dynamic transfer;
  dynamic receive;

  factory TxNum.fromJson(Map<String, dynamic> json) => TxNum(
    transfer: json["transfer"],
    receive: json["receive"],
  );

  Map<String, dynamic> toJson() => {
    "transfer": transfer,
    "receive": receive,
  };
}

class Vol {
  Vol({
    this.transfer,
    this.receive,
  });

  List<ReceiveElement>? transfer;
  List<ReceiveElement>? receive;

  factory Vol.fromJson(Map<String, dynamic> json) => Vol(
    transfer: json["transfer"] == null ? null : List<ReceiveElement>.from(json["transfer"].map((x) => ReceiveElement.fromJson(x))),
    receive: json["receive"] == null ? null : List<ReceiveElement>.from(json["receive"].map((x) => ReceiveElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "transfer": transfer == null ? null : List<dynamic>.from(transfer!.map((x) => x.toJson())),
    "receive": receive == null ? null : List<dynamic>.from(receive!.map((x) => x.toJson())),
  };
}

class ReceiveElement {
  ReceiveElement({
    this.denom,
    this.amount,
  });

  String? denom;
  String? amount;

  factory ReceiveElement.fromJson(Map<String, dynamic> json) => ReceiveElement(
    denom: json["denom"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "denom": denom,
    "amount": amount,
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
