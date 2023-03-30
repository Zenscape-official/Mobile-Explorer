// To parse this JSON data, do
//
//     final ibcModel = ibcModelFromJson(jsonString);

import 'dart:convert';

IbcModel ibcModelFromJson(String str) => IbcModel.fromJson(json.decode(str));

String ibcModelToJson(IbcModel data) => json.encode(data.toJson());

class IbcModel {
  IbcModel({
    this.channels,
    this.pagination,
    this.height,
  });

  List<Channel>? channels;
  Pagination? pagination;
  Height? height;

  factory IbcModel.fromJson(Map<String, dynamic> json) => IbcModel(
    channels: json["channels"] == null ? [] : List<Channel>.from(json["channels"]!.map((x) => Channel.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    height: json["height"] == null ? null : Height.fromJson(json["height"]),
  );

  Map<String, dynamic> toJson() => {
    "channels": channels == null ? [] : List<dynamic>.from(channels!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
    "height": height?.toJson(),
  };
}

class Channel {
  Channel({
    this.state,
    this.ordering,
    this.counterparty,
    this.connectionHops,
    this.version,
    this.portId,
    this.channelId,
  });

  String? state;
  Ordering? ordering;
  Counterparty? counterparty;
  List<String>? connectionHops;
  Version? version;
  ChannelPortId? portId;
  String? channelId;

  factory Channel.fromJson(Map<String, dynamic> json) => Channel(
    state: json["state"]!,
    ordering: orderingValues.map[json["ordering"]],
    counterparty: json["counterparty"] == null ? null : Counterparty.fromJson(json["counterparty"]),
    connectionHops: json["connection_hops"] == null ? [] : List<String>.from(json["connection_hops"]!.map((x) => x)),
    version: versionValues.map[json["version"]],
    portId: channelPortIdValues.map[json["port_id"]],
    channelId: json["channel_id"],
  );

  Map<String, dynamic> toJson() => {
    "state": state,
    "ordering": orderingValues.reverse[ordering],
    "counterparty": counterparty?.toJson(),
    "connection_hops": connectionHops == null ? [] : List<dynamic>.from(connectionHops!.map((x) => x)),
    "version": versionValues.reverse[version],
    "port_id": channelPortIdValues.reverse[portId],
    "channel_id": channelId,
  };
}

class Counterparty {
  Counterparty({
    this.portId,
    this.channelId,
  });

  CounterpartyPortId? portId;
  String? channelId;

  factory Counterparty.fromJson(Map<String, dynamic> json) => Counterparty(
    portId: counterpartyPortIdValues.map[json["port_id"]],
    channelId: json["channel_id"],
  );

  Map<String, dynamic> toJson() => {
    "port_id": counterpartyPortIdValues.reverse[portId],
    "channel_id": channelId,
  };
}

enum CounterpartyPortId { ORACLE, TRANSFER }

final counterpartyPortIdValues = EnumValues({
  "oracle": CounterpartyPortId.ORACLE,
  "transfer": CounterpartyPortId.TRANSFER
});

enum Ordering { ORDER_UNORDERED }

final orderingValues = EnumValues({
  "ORDER_UNORDERED": Ordering.ORDER_UNORDERED
});

enum ChannelPortId { BANDORACLE_V1, TRANSFER }

final channelPortIdValues = EnumValues({
  "bandoracleV1": ChannelPortId.BANDORACLE_V1,
  "transfer": ChannelPortId.TRANSFER
});

enum State { STATE_OPEN, STATE_INIT, STATE_TRYOPEN }

final stateValues = EnumValues({
  "STATE_INIT": State.STATE_INIT,
  "STATE_OPEN": State.STATE_OPEN,
  "STATE_TRYOPEN": State.STATE_TRYOPEN
});

enum Version { BANDCHAIN_1, ICS20_1 }

final versionValues = EnumValues({
  "bandchain-1": Version.BANDCHAIN_1,
  "ics20-1": Version.ICS20_1
});

class Height {
  Height({
    this.revisionNumber,
    this.revisionHeight,
  });

  String? revisionNumber;
  String? revisionHeight;

  factory Height.fromJson(Map<String, dynamic> json) => Height(
    revisionNumber: json["revision_number"],
    revisionHeight: json["revision_height"],
  );

  Map<String, dynamic> toJson() => {
    "revision_number": revisionNumber,
    "revision_height": revisionHeight,
  };
}

class Pagination {
  Pagination({
    this.nextKey,
    this.total,
  });

  dynamic nextKey;
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
