// To parse this JSON data, do
//
//     final rawLogModel = rawLogModelFromJson(jsonString);

import 'dart:convert';

List<RawLogModel> rawLogModelFromJson(String str) => List<RawLogModel>.from(json.decode(str).map((x) => RawLogModel.fromJson(x)));

String rawLogModelToJson(List<RawLogModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RawLogModel {
  RawLogModel({
    this.events,
  });

  List<Event>? events;

  factory RawLogModel.fromJson(Map<String, dynamic> json) => RawLogModel(
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
