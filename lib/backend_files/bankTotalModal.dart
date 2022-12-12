import 'dart:convert';

List<SupplyData> supplyDataFromJson(String str) => List<SupplyData>.from(json.decode(str).map((x) => SupplyData.fromJson(x)));

String supplyDataToJson(List<SupplyData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SupplyData {
  SupplyData({
    this.denom,
    this.amount,
  });

  String? denom;
  String? amount;

  factory SupplyData.fromJson(Map<String, dynamic> json) => SupplyData(
    denom: json["denom"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "denom": denom,
    "amount": amount,
  };
}
