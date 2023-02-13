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
    this.stringMessage,
    this.messages,
    this.fee,
    this.gasWanted,
    this.amount,
    this.gasUsed,
    this.rawLog,
    this.memo,
    this.logs,
    this.partitionId,
    this.appID,
    this.stableVaultID,
    this.extendedPairVaultID,

  });

  String? hash;
  String? height;
  bool? success;
  String? amount;
  List<Message>? messages;
  String? stringMessage;
  Fee ?fee;
  String? gasWanted;
  String? gasUsed;
  String? rawLog;
  String? memo;
  String? sender;
  String? reciever;
  List<Log>? logs;
  String? partitionId;
  String? appID;
  String? stableVaultID;
  String? extendedPairVaultID;

  factory TxModel.fromJson(Map<String, dynamic> json) => TxModel(
    hash: json["hash"],
    height: json["height"],
    success: json["success"],
    amount: json["amount"],
    messages: json["messages"] == null ? null : List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
    fee: Fee.fromJson(json["fee"]),
    gasWanted: json["gas_wanted"],
    gasUsed: json["gas_used"],
   rawLog: json["raw_log"],
    memo: json["memo"],
    //logs: List<Log>.from(json["logs"].map((x) => Log.fromJson(x))),
    partitionId: json["partition_id"],
    appID: json["app_id"],
    stableVaultID: json["stable_vault_id"],
    extendedPairVaultID: json["extended_pair_vault_id"],


  );

  Map<String, dynamic> toJson() => {
    "hash": hash,
    "height": height,
    "success": success,
    "messages": messages == null ? null : List<dynamic>.from(messages!.map((x) => x.toJson())),
    "stringMessages":stringMessage,
    "fee": fee!.toJson(),
    "gas_wanted": gasWanted,
    "gas_used": gasUsed,
    "raw_log": rawLog,
    "logs": List<dynamic>.from(logs!.map((x) => x.toJson())),
    "partition_id": partitionId,
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
class Log {
  Log({
    this.events,
  });

  List<Event>? events;

  factory Log.fromJson(Map<String, dynamic> json) => Log(
    events: List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "events": List<dynamic>.from(events!.map((x) => x.toJson())),
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
    this.price,
    this.amount,
    this.appId,
    this.orderer,
    this.pairId,
    this.direction,
    this.offerCoin,
    this.orderLifespan,
    this.demandCoinDenom,
    this.farmer,
    this.farmingPoolCoin,
    this.poolId,
    this.assetId,
    this.depositor,
    this.token,
    this.sender,
    this.receiver,
    this.sourcePort,
    this.sourceChannel,
    this.timeoutHeight,
    this.timeoutTimestamp,
    this.fromAddress,
    this.address,
    this.toAddress,
    this.voter,
    this.option,
    this.proposalId,
    this.stringAmount,
    this.unfarmingPoolCoin,
    this.depositCoins,
    this.poolCoins,
    this.withDrawer,
    this.orderId,
    this.creator,
    this.baseCoinDenom,
    this.quoteCoinDenom,
    this.lockerId,
    this.amountIn,
    this.amountOut,
    this.extendedPairVaultId,
    this.userVaultId,
    this.stableVaultId,
    this.lender,
    this.lendId,
    this.borrower,
    this.borrowId,
    this.startTime,
    this.gaugeTypeId,
    this.depositAmount,
    this.totalTriggers,
    this.triggerDuration,
    this.liquidityMetaData,
    this.grant,
    this.grantee,
    this.granter,
    this.msgTypeUrl,
    this.withdrawAddress,
    this.delegatorAddress,
    this.validatorAddress,
    this.content,
    this.proposer,
    this.initialDeposit,
    this.value,
    this.pubkey,
    this.commission,
    this.description,
    this.minSelfDelegation,
    this.commissionRate,
    this.msgs,
    this.validatorDstAddress,
    this.validatorSrcAddress,
    this.routes,
    this.tokenIn,
    this.tokenOutMinAmount,
    this.tokenOut,
    this.tokenInMaxs,
    this.shareOutAmount,
    this.funds,
    this.contract,
  });

  String? type;
  MessageHeader? header;
  String? signer;
  String? clientId;
  Packet? packet;
  String? proofAcked;
  Height? proofHeight;
  String? acknowledgement;
  String? price;
  final dynamic amount;
  String? stringAmount;
  String? appId;
  String? depositor;
  String? lender;
  String? withDrawer;
  String? assetId;
  String? lockerId;
  String? orderer;
  String? creator;
  String? pairId;
  String? orderId;
  String? direction;
  Amount? offerCoin;
  String? orderLifespan;
  String? demandCoinDenom;
  String? farmer;
  String? poolId;
  Amount? farmingPoolCoin;
  Amount? unfarmingPoolCoin;
  List<Amount>? depositCoins;
  Amount? poolCoins;
  TokenTx? token;
  String? sender;
  String? receiver;
  String? sourcePort;
  String? sourceChannel;
  TimeoutHeight? timeoutHeight;
  String? timeoutTimestamp;
  String? toAddress;
  String? fromAddress;
  String? address;
  String? voter;
  String? option;
  String? proposalId;
  String? baseCoinDenom;
  String? quoteCoinDenom;
  final dynamic amountIn;
  final dynamic amountOut;
  String? extendedPairVaultId;
  String? userVaultId;
  String? stableVaultId;
  String? lendId;
  String? borrower;
  String? borrowId;
  DateTime? startTime;
  String? gaugeTypeId;
  Amount? depositAmount;
  String? totalTriggers;
  String? triggerDuration;
  LiquidityMetaData? liquidityMetaData;
  Grant? grant;
  String? grantee;
  String? granter;
  String? msgTypeUrl;
  String? withdrawAddress;
  String? delegatorAddress;
  String? validatorAddress;
  Content? content;
  String? proposer;
  List<dynamic>? initialDeposit;
  Amount? value;
  Pubkey? pubkey;
  Commission? commission;
  Description? description;
  String? minSelfDelegation;
  dynamic commissionRate;
  List<Msg>? msgs;
  String? validatorDstAddress;
  String? validatorSrcAddress;
  List<Route>? routes;
  TokenIn? tokenIn;
  TokenIn? tokenOut;
  String? tokenOutMinAmount;
  List<Amount>? tokenInMaxs;
  String? shareOutAmount;
  List<Amount>? funds;
  String? contract;


  factory Message.fromJson(Map<String, dynamic> json) {
    dynamic amount;
    dynamic amountIn;
    dynamic amountOut;
    if (json['amount'] is String) {
      amount = json['amount'];
    } else if (json['amount'] is Map<String, dynamic>) {
      amount = Amount.fromJson(json['amount']);
    } else if (json['amount'] is List) {
      amount = json['amount'].map((i) => Amount.fromJson(i)).toList();
    }
    if (json['amount_in'] is String) {
      amountIn = json['amount_in'];
    } else if (json['amount_in'] is Map<String, dynamic>) {
      amountIn = Amount.fromJson(json['amount_in']);
    } else if (json['amount_in'] is List) {
      amountIn = json['amount_in'].map((i) => Amount.fromJson(i)).toList();
    }
    if (json['amount_out'] is String) {
      amountOut = json['amount_out'];
    } else if (json['amount_out'] is Map<String, dynamic>) {
      amountOut = Amount.fromJson(json['amount_out']);
    } else if (json['amount_out'] is List) {
      amountOut = json['amount_out'].map((i) => Amount.fromJson(i)).toList();
    }

    return Message(
      msgs: json["msgs"] == null ? [] : List<Msg>.from(json["msgs"]!.map((x) => Msg.fromJson(x))),
    amount:amount,
    amountIn:amountIn,
    amountOut:amountOut,
    type: json["@type"],
    header: json["header"] == null ? null : MessageHeader.fromJson(json["header"]),
    signer: json["signer"],
    clientId: json["client_id"],
    packet: json["packet"] == null ? null : Packet.fromJson(json["packet"]),
    proofAcked: json["proof_acked"],
    proofHeight: json["proof_height"] == null ? null : Height.fromJson(json["proof_height"]),
    acknowledgement: json["acknowledgement"],
    price: json["price"],
    //stringAmount: json["amount"] == null ? null:  json["amount"],
    //amount: json["amount"] == null ? null: json["amount"].runtimeType != String? List<Amount>.from(json["amount"].map((x) => Amount.fromJson(x))): json["amount"],
    assetId: json["asset_id"],
    depositor: json["depositor"],
    withDrawer: json["withdrawer"],
    appId: json["app_id"],
    orderer: json["orderer"],
      creator: json["creator"],
    pairId: json["pair_id"],
    direction: json["direction"],
    farmer: json["farmer"],
    poolId: json["pool_id"],
    offerCoin: json["offer_coin"]==null?null: Amount.fromJson(json["offer_coin"]),
    orderLifespan: json["order_lifespan"],
    demandCoinDenom: json["demand_coin_denom"],
    token: json["token"] == null ? null :TokenTx.fromJson(json["token"]),
    sender: json["sender"],
    receiver: json["receiver"],
    sourcePort: json["source_port"],
    sourceChannel: json["source_channel"],
    timeoutHeight: json["timeout_height"] == null ? null :TimeoutHeight.fromJson(json["timeout_height"]),
    timeoutTimestamp: json["timeout_timestamp"],
    toAddress: json["to_address"] == null ? null : json["to_address"],
    fromAddress: json["from_address"] == null ? null : json["from_address"],
      address: json["from"] == null ? null : json["from"],
    voter: json["voter"],
    option: json["option"],
    proposalId: json["proposal_id"],
    farmingPoolCoin: json["farming_pool_coin"] == null ? null : Amount.fromJson(json["farming_pool_coin"]),
    unfarmingPoolCoin: json["unfarming_pool_coin"] == null ? null : Amount.fromJson(json["unfarming_pool_coin"]),
    depositCoins: json["deposit_coins"] == null ? [] : List<Amount>.from(json["deposit_coins"]!.map((x) => Amount.fromJson(x))),
    poolCoins: json["pool_coin"] == null ? null : Amount.fromJson(json["pool_coin"]),
    orderId: json["order_id"],
    baseCoinDenom: json["base_coin_denom"],
    quoteCoinDenom: json["quote_coin_denom"],
    lockerId: json["locker_id"],
    //amountIn: json["amount_in"],
    //amountOut: json["amount_out"],
    extendedPairVaultId: json["extended_pair_vault_id"],
    userVaultId: json["user_vault_id"],
      stableVaultId: json["stable_vault_id"],
    lender:json["lender"],
      lendId:json["lend_id"],
      borrower: json["borrower"],
      borrowId: json["borrow_id"],
      startTime: json["start_time"] == null ? null : DateTime.parse(json["start_time"]),
      gaugeTypeId: json["gauge_type_id"],
      depositAmount: json["deposit_amount"] == null ? null : Amount.fromJson(json["deposit_amount"]),
      totalTriggers: json["total_triggers"],
      triggerDuration: json["trigger_duration"],
      liquidityMetaData: json["liquidity_meta_data"] == null ? null : LiquidityMetaData.fromJson(json["liquidity_meta_data"]),
      grant: json["grant"] == null ? null : Grant.fromJson(json["grant"]),
      grantee: json["grantee"],
      granter: json["granter"],
      msgTypeUrl: json["msg_type_url"],
      withdrawAddress: json["withdraw_address"],
      delegatorAddress: json["delegator_address"],
      validatorAddress: json["validator_address"],
      content: json["content"] == null ? null : Content.fromJson(json["content"]),
      proposer: json["proposer"],
      initialDeposit: json["initial_deposit"] == null ? [] : List<dynamic>.from(json["initial_deposit"]!.map((x) => x)),
      value: json["value"] == null ? null : Amount.fromJson(json["value"]),
      pubkey: json["pubkey"] == null ? null : Pubkey.fromJson(json["pubkey"]),
      commission: json["commission"] == null ? null : Commission.fromJson(json["commission"]),
      description: json["description"] == null ? null : Description.fromJson(json["description"]),
      minSelfDelegation: json["min_self_delegation"],
      commissionRate: json["commission_rate"],
      validatorDstAddress: json["validator_dst_address"],
      validatorSrcAddress: json["validator_src_address"],
      routes: json["routes"] == null ? [] : List<Route>.from(json["routes"]!.map((x) => Route.fromJson(x))),
      tokenIn: json["token_in"] == null ? null : TokenIn.fromJson(json["token_in"]),
      tokenOut: json["token_out"] == null ? null : TokenIn.fromJson(json["token_out"]),
      tokenOutMinAmount: json["token_out_min_amount"],
      tokenInMaxs: json["token_in_maxs"] == null ? [] : List<Amount>.from(json["token_in_maxs"]!.map((x) => Amount.fromJson(x))),
      shareOutAmount: json["share_out_amount"],
      funds: json["funds"] == null ? [] : List<Amount>.from(json["funds"]!.map((x) => Amount.fromJson(x))),
      contract: json["contract"],

    );
  }

  Map<String, dynamic> toJson() => {
    "@type": type,
    "header": header == null ? null : header!.toJson(),
    "signer": signer,
    "client_id": clientId,
    "packet": packet == null ? null : packet!.toJson(),
    "proof_acked": proofAcked,
    "proof_height": proofHeight == null ? null : proofHeight!.toJson(),
    "acknowledgement": acknowledgement,
    "price": price,
    "amount":stringAmount,
    "amount": amount == null ? [] : List<dynamic>.from(amount!.map((x) => x.toJson())),
    "app_id": appId,
    "orderer": orderer,
    "creator":creator,
    "pair_id": pairId,
    "farmer":farmer,
    "pool_id":poolId,
    "direction": direction,
    "offer_coin": offerCoin!.toJson(),
    "order_lifespan": orderLifespan,
    "demand_coin_denom": demandCoinDenom,
    "token": token!.toJson(),
    "sender": sender,
    "receiver": receiver,
    "source_port": sourcePort,
    "source_channel": sourceChannel,
    "timeout_height": timeoutHeight!.toJson(),
    "timeout_timestamp": timeoutTimestamp,
    "to_address": toAddress == null ? null : toAddress,
    "from_address": fromAddress == null ? null : fromAddress,
    "farming_pool_coin": farmingPoolCoin == null ? null : farmingPoolCoin!.toJson(),
    "unfarming_pool_coin": unfarmingPoolCoin == null ? null : unfarmingPoolCoin!.toJson(),
    "deposit_coins":depositCoins==null?null:List<dynamic>.from(depositCoins!.map((x) => x.toJson())),
    "pool_coin":poolCoins==null?null:poolCoins!.toJson(),
    "withdrawer":withDrawer,
    "depositor":depositor,
    "order_id":orderId,
    "quote_coin_denom":quoteCoinDenom,
    "base_coin_denom":baseCoinDenom,
    "locker_id":lockerId,
    "from":address,
    "amount_in": amountIn,
    "amount_out": amountOut,
    "extended_pair_vault_id": extendedPairVaultId,
    "user_vault_id":userVaultId,
    "stable_vault_id":stableVaultId,
    "lender":lender,
    "lend_id":lendId,
    "borrower": borrower,
    "borrow_id": borrowId,
    "start_time": startTime?.toIso8601String(),
    "gauge_type_id": gaugeTypeId,
    "deposit_amount": depositAmount?.toJson(),
    "total_triggers": totalTriggers,
    "trigger_duration": triggerDuration,
    "liquidity_meta_data": liquidityMetaData?.toJson(),
    "grant": grant?.toJson(),
    "grantee": grantee,
    "granter": granter,
    "msg_type_url": msgTypeUrl,
    "withdraw_address":withdrawAddress,
    "delegator_address":delegatorAddress,
    "validator_address":validatorAddress,
    "content": content?.toJson(),
    "proposer": proposer,
    "initial_deposit": initialDeposit == null ? [] : List<dynamic>.from(initialDeposit!.map((x) => x)),
    "value": value?.toJson(),
    "pubkey": pubkey?.toJson(),
    "commission": commission?.toJson(),
    "description": description?.toJson(),
    "min_self_delegation": minSelfDelegation,
    "commission_rate": commissionRate,
    "msgs": msgs == null ? [] : List<dynamic>.from(msgs!.map((x) => x.toJson())),
    "validator_dst_address": validatorDstAddress,
    "validator_src_address": validatorSrcAddress,
    "token_in_maxs": tokenInMaxs == null ? [] : List<dynamic>.from(tokenInMaxs!.map((x) => x.toJson())),
    "share_out_amount": shareOutAmount,
    "funds": funds == null ? [] : List<dynamic>.from(funds!.map((x) => x.toJson())),
    "contract": contract,

  };
}
class Route {
  Route({
    this.poolId,
    this.tokenOutDenom,
    this.tokenInDenom
  });

  String? poolId;
  String? tokenOutDenom;
  String? tokenInDenom;

  factory Route.fromJson(Map<String, dynamic> json) => Route(
    poolId: json["pool_id"],
    tokenOutDenom: json["token_out_denom"],
    tokenInDenom: json["token_in_denom"]
  );

  Map<String, dynamic> toJson() => {
    "pool_id": poolId,
    "token_out_denom": tokenOutDenom,
    "token_in_denom": tokenInDenom
  };
}

class TokenIn {
  TokenIn({
    this.denom,
    this.amount,
  });

  String? denom;
  String? amount;

  factory TokenIn.fromJson(Map<String, dynamic> json) => TokenIn(
    denom: json["denom"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "denom": denom,
    "amount": amount,
  };
}

class Msg {
  Msg({
    this.type,
    this.amount,
    this.delegatorAddress,
    this.validatorAddress,
  });

  Type? type;
  Amount? amount;
  String? delegatorAddress;
  String? validatorAddress;

  factory Msg.fromJson(Map<String, dynamic> json) => Msg(
    type: typeValues.map[json["@type"]]!,
    amount: json["amount"] == null ? null : Amount.fromJson(json["amount"]),
    delegatorAddress: json["delegator_address"],
    validatorAddress:json["validator_address"],
  );

  Map<String, dynamic> toJson() => {
    "@type": typeValues.reverse[type],
    "amount": amount?.toJson(),
    "delegator_address": delegatorAddress,
    "validator_address": validatorAddressValues.reverse[validatorAddress],
  };
}
enum Denom { UCMDX }

final denomValues = EnumValues({
  "ucmdx": Denom.UCMDX
});

enum Type { COSMOS_STAKING_V1_BETA1_MSG_DELEGATE }

final typeValues = EnumValues({
  "/cosmos.staking.v1beta1.MsgDelegate": Type.COSMOS_STAKING_V1_BETA1_MSG_DELEGATE
});

enum ValidatorAddress { COMDEXVALOPER195_RE7_MHWH9_UREWM3_RVAJ9_R7_VM6_J63_C4_SD78_NJD }

final validatorAddressValues = EnumValues({
  "comdexvaloper195re7mhwh9urewm3rvaj9r7vm6j63c4sd78njd": ValidatorAddress.COMDEXVALOPER195_RE7_MHWH9_UREWM3_RVAJ9_R7_VM6_J63_C4_SD78_NJD
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

class Commission {
  Commission({
    this.rate,
    this.maxRate,
    this.maxChangeRate,
  });

  String? rate;
  String? maxRate;
  String? maxChangeRate;

  factory Commission.fromJson(Map<String, dynamic> json) => Commission(
    rate: json["rate"],
    maxRate: json["max_rate"],
    maxChangeRate: json["max_change_rate"],
  );

  Map<String, dynamic> toJson() => {
    "rate": rate,
    "max_rate": maxRate,
    "max_change_rate": maxChangeRate,
  };
}

class Description {
  Description({
    this.details,
    this.moniker,
    this.website,
    this.identity,
    this.securityContact,
  });

  String? details;
  String? moniker;
  String? website;
  String? identity;
  String? securityContact;

  factory Description.fromJson(Map<String, dynamic> json) => Description(
    details: json["details"],
    moniker: json["moniker"],
    website: json["website"],
    identity: json["identity"],
    securityContact: json["security_contact"],
  );

  Map<String, dynamic> toJson() => {
    "details": details,
    "moniker": moniker,
    "website": website,
    "identity": identity,
    "security_contact": securityContact,
  };
}

class Pubkey {
  Pubkey({
    this.key,
    this.type,
  });

  String? key;
  String? type;

  factory Pubkey.fromJson(Map<String, dynamic> json) => Pubkey(
    key: json["key"],
    type: json["@type"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "@type": type,
  };
}

class Content {
  Content({
    this.type,
    this.title,
    this.description,
  });

  String? type;
  String? title;
  String? description;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    type: json["@type"],
    title: json["title"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "@type": type,
    "title": title,
    "description": description,
  };
}
class Grant {
  Grant({
    this.expiration,
    this.authorization,
  });

  DateTime? expiration;
  Authorization? authorization;

  factory Grant.fromJson(Map<String, dynamic> json) => Grant(
    expiration: json["expiration"] == null ? null : DateTime.parse(json["expiration"]),
    authorization: json["authorization"] == null ? null : Authorization.fromJson(json["authorization"]),
  );

  Map<String, dynamic> toJson() => {
    "expiration": expiration?.toIso8601String(),
    "authorization": authorization?.toJson(),
  };
}
class TimeoutHeight {
  TimeoutHeight({
    this.revisionHeight,
    this.revisionNumber,
  });

  String? revisionHeight;
  String? revisionNumber;

  factory TimeoutHeight.fromJson(Map<String, dynamic> json) => TimeoutHeight(
    revisionHeight: json["revision_height"],
    revisionNumber: json["revision_number"],
  );

  Map<String, dynamic> toJson() => {
    "revision_height": revisionHeight,
    "revision_number": revisionNumber,
  };
}

class TokenTx {
  TokenTx({
    this.denom,
    this.amount,
  });

  String? denom;
  String? amount;

  factory TokenTx.fromJson(Map<String, dynamic> json) => TokenTx(
    denom: json["denom"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "denom": denom,
    "amount": amount,
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

class EnumValue<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValue(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map!.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}

class LiquidityMetaData {
  LiquidityMetaData({
    this.poolId,
    this.childPoolIds,
    this.isMasterPool,
  });

  String? poolId;
  List<dynamic>? childPoolIds;
  bool? isMasterPool;

  factory LiquidityMetaData.fromJson(Map<String, dynamic> json) => LiquidityMetaData(
    poolId: json["pool_id"],
    childPoolIds: json["child_pool_ids"] == null ? [] : List<dynamic>.from(json["child_pool_ids"]!.map((x) => x)),
    isMasterPool: json["is_master_pool"],
  );

  Map<String, dynamic> toJson() => {
    "pool_id": poolId,
    "child_pool_ids": childPoolIds == null ? [] : List<dynamic>.from(childPoolIds!.map((x) => x)),
    "is_master_pool": isMasterPool,
  };
}


class Authorization {
  Authorization({
    this.type,
    this.allowList,
    this.maxTokens,
    this.authorizationType,
  });

  String? type;
  AllowList? allowList;
  dynamic maxTokens;
  String? authorizationType;

  factory Authorization.fromJson(Map<String, dynamic> json) => Authorization(
    type: json["@type"],
    allowList: json["allow_list"] == null ? null : AllowList.fromJson(json["allow_list"]),
    maxTokens: json["max_tokens"],
    authorizationType: json["authorization_type"],
  );

  Map<String, dynamic> toJson() => {
    "@type": type,
    "allow_list": allowList?.toJson(),
    "max_tokens": maxTokens,
    "authorization_type": authorizationType,
  };
}

class AllowList {
  AllowList({
    this.address,
  });

  List<String>? address;

  factory AllowList.fromJson(Map<String, dynamic> json) => AllowList(
    address: json["address"] == null ? [] : List<String>.from(json["address"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "address": address == null ? [] : List<dynamic>.from(address!.map((x) => x)),
  };
}
