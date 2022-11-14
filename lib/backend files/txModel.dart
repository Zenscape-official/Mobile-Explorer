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
    this.rawLog,
    this.memo,
  });

  String? hash;
  String? height;
  bool? success;
  List<Message>? messages;
  Fee ?fee;
  String? gasWanted;
  String? gasUsed;
  List<RawLog>? rawLog;
  String? memo;

  factory TxModel.fromJson(Map<String, dynamic> json) => TxModel(
    hash: json["hash"],
    height: json["height"],
    success: json["success"],
    messages: List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
    fee: Fee.fromJson(json["fee"]),
    gasWanted: json["gas_wanted"],
    gasUsed: json["gas_used"],
    //rawLog: List<RawLog>.from(json["raw_log"].map((x) => RawLog.fromJson(x))),
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
    "raw_log": List<dynamic>.from(rawLog!.map((x) => x.toJson())),
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
    this.price,
    this.amount,
    this.appId,
    this.orderer,
    this.pairId,
    this.direction,
    this.offerCoin,
    this.orderLifespan,
    this.demandCoinDenom,
  });

  String? type;
  String? price;
  String? amount;
  String? appId;
  String? orderer;
  String? pairId;
  String? direction;
  Amount? offerCoin;
  String? orderLifespan;
  String? demandCoinDenom;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    type: json["@type"],
    price: json["price"],
    //amount: json["amount"],
    appId: json["app_id"],
    orderer: json["orderer"],
    pairId: json["pair_id"],
    direction: json["direction"],
    //offerCoin: Amount.fromJson(json["offer_coin"]),
    orderLifespan: json["order_lifespan"],
    demandCoinDenom: json["demand_coin_denom"],
  );

  Map<String, dynamic> toJson() => {
    "@type": type,
    "price": price,
    "amount": amount,
    "app_id": appId,
    "orderer": orderer,
    "pair_id": pairId,
    "direction": direction,
    "offer_coin": offerCoin!.toJson(),
    "order_lifespan": orderLifespan,
    "demand_coin_denom": demandCoinDenom,
  };
}

class RawLog {
  RawLog({
    this.events,
  });

  List<Event>? events;

  factory RawLog.fromJson(Map<String, dynamic> json) => RawLog(
    events: List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "events": List<dynamic>.from(events!.map((x) => x.toJson())),
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
