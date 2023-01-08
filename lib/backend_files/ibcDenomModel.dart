import 'dart:convert';
import 'package:flutter/services.dart';

class IBCMapping{
  List _items=[];
  readJson() async {
    final String response = await rootBundle.loadString('assets/jsonFiles/testnet_ibc_asset.json');
    final data = await json.decode(response);

      _items = data["tokens"];
      return _items;

  }
}
// To parse this JSON data, do
//
//     final ibcDenomModel = ibcDenomModelFromJson(jsonString);


IbcDenomModel ibcDenomModelFromJson(String str) => IbcDenomModel.fromJson(json.decode(str));

String ibcDenomModelToJson(IbcDenomModel data) => json.encode(data.toJson());

class IbcDenomModel {
  IbcDenomModel({
    this.tokens,
  });

  List<Token>? tokens;

  factory IbcDenomModel.fromJson(Map<String, dynamic> json) => IbcDenomModel(
    tokens: json["tokens"] == null ? null : List<Token>.from(json["tokens"].map((x) => Token.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "tokens": tokens == null ? null : List<dynamic>.from(tokens!.map((x) => x.toJson())),
  };
}

class Token {
  Token({
    this.chainId,
    this.chainName,
    this.rpc,
    this.rest,
    this.coinDenom,
    this.coinMinimalDenom,
    this.symbol,
    this.coinDecimals,
    this.coinType,
    this.prefix,
    this.channel,
    this.comdexChannel,
    this.ibcDenomHash,
    this.logoUri,
    this.coinGeckoId,
    this.explorerUrlToTx,
    this.depositUrlOverride,
    this.withdrawUrlOverride,
  });

  String? chainId;
  String? chainName;
  String? rpc;
  String? rest;
  String? coinDenom;
  String? coinMinimalDenom;
  String? symbol;
  int? coinDecimals;
  int? coinType;
  String ?prefix;
  String? channel;
  String? comdexChannel;
  String? ibcDenomHash;
  String? logoUri;
  String? coinGeckoId;
  String? explorerUrlToTx;
  String? depositUrlOverride;
  String? withdrawUrlOverride;

  factory Token.fromJson(Map<String, dynamic> json) => Token(
    chainId: json["chainId"] == null ? null : json["chainId"],
    chainName: json["chainName"] == null ? null : json["chainName"],
    rpc: json["rpc"] == null ? null : json["rpc"],
    rest: json["rest"] == null ? null : json["rest"],
    coinDenom: json["coinDenom"] == null ? null : json["coinDenom"],
    coinMinimalDenom: json["coinMinimalDenom"] == null ? null : json["coinMinimalDenom"],
    symbol: json["symbol"] == null ? null : json["symbol"],
    coinDecimals: json["coinDecimals"] == null ? null : json["coinDecimals"],
    coinType: json["coinType"] == null ? null : json["coinType"],
    prefix: json["prefix"] == null ? null : json["prefix"],
    channel: json["channel"] == null ? null : json["channel"],
    comdexChannel: json["comdexChannel"] == null ? null : json["comdexChannel"],
    ibcDenomHash: json["ibcDenomHash"] == null ? null : json["ibcDenomHash"],
    logoUri: json["logoURI"] == null ? null : json["logoURI"],
    coinGeckoId: json["coinGeckoId"] == null ? null : json["coinGeckoId"],
    explorerUrlToTx: json["explorerUrlToTx"] == null ? null : json["explorerUrlToTx"],
    depositUrlOverride: json["depositUrlOverride"] == null ? null : json["depositUrlOverride"],
    withdrawUrlOverride: json["withdrawUrlOverride"] == null ? null : json["withdrawUrlOverride"],
  );

  Map<String, dynamic> toJson() => {
    "chainId": chainId == null ? null : chainId,
    "chainName": chainName == null ? null : chainName,
    "rpc": rpc == null ? null : rpc,
    "rest": rest == null ? null : rest,
    "coinDenom": coinDenom == null ? null : coinDenom,
    "coinMinimalDenom": coinMinimalDenom == null ? null : coinMinimalDenom,
    "symbol": symbol == null ? null : symbol,
    "coinDecimals": coinDecimals == null ? null : coinDecimals,
    "coinType": coinType == null ? null : coinType,
    "prefix": prefix == null ? null : prefix,
    "channel": channel == null ? null : channel,
    "comdexChannel": comdexChannel == null ? null : comdexChannel,
    "ibcDenomHash": ibcDenomHash == null ? null : ibcDenomHash,
    "logoURI": logoUri == null ? null : logoUri,
    "coinGeckoId": coinGeckoId == null ? null : coinGeckoId,
    "explorerUrlToTx": explorerUrlToTx == null ? null : explorerUrlToTx,
    "depositUrlOverride": depositUrlOverride == null ? null : depositUrlOverride,
    "withdrawUrlOverride": withdrawUrlOverride == null ? null : withdrawUrlOverride,
  };
}
