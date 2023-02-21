import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

var kBigTextStyle= TextStyle(
fontFamily: 'MontserratRegular',
  color: Colors.black,
  fontWeight: Platform.isAndroid ?FontWeight.normal: FontWeight.normal,
fontSize: 20,
);
var kBigBoldTextStyle= TextStyle(
  fontFamily: 'MontserratBold',
  color: Colors.black.withOpacity(.8),
  fontWeight: Platform.isAndroid ?FontWeight.w700: FontWeight.w700,
  fontSize: 20,
);
var kMediumTextStyle= TextStyle(
  fontFamily: 'MontserratRegular',
  color: Colors.black,
  fontWeight: Platform.isAndroid?FontWeight.normal: FontWeight.normal,
  fontSize: 15,
);
var kMediumBoldTextStyle= TextStyle(
  fontFamily: 'MontserratBold',
  color: Colors.black.withOpacity(.7),
  fontWeight:  FontWeight.w700,
  fontSize: 15,
);
var kMediumBlueBoldTextStyle= TextStyle(
  decoration: TextDecoration.underline,
  fontFamily: 'MontserratBold',
  color: Colors.blue.withOpacity(1),
  fontWeight:  FontWeight.w700,
  fontSize: 15,
);
var kSmallTextStyle= TextStyle(
  fontFamily: 'MontserratRegular',
  color: Colors.black,
  fontWeight: Platform.isAndroid?FontWeight.normal: FontWeight.normal,
  fontSize: 13,
);
var kSmallBoldTextStyle= TextStyle(
  fontFamily: 'MontserratBold',
  color: Colors.black.withOpacity(.7),
  fontWeight: Platform.isAndroid?FontWeight.bold: FontWeight.bold,
  fontSize: 12,
);

var kLandingPageBoldTextStyle= TextStyle(
  fontFamily: 'MontserratBold',
  color: Colors.black.withOpacity(.7),
  fontWeight: Platform.isAndroid?FontWeight.bold: FontWeight.bold,
  fontSize: 15,
);
var kExtraSmallTextStyle= TextStyle(
  fontFamily: 'MontserratRegular',
  color: Colors.black,
  fontWeight: Platform.isAndroid?FontWeight.normal: FontWeight.normal,
  fontSize: 10,
);

var kExtraSmallBoldTextStyle= TextStyle(
  fontFamily: 'MontserratBold',
  color: Colors.black.withOpacity(.7),
  fontWeight: Platform.isAndroid?FontWeight.normal: FontWeight.normal,
  fontSize: 10,
);
var kGradientColor= LinearGradient(
  colors: [ Colors.white, const Color(0xFFBCE4FC).withOpacity(.05)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
var kBoxDecorationWithGradient=BoxDecoration (
  borderRadius: const BorderRadius.all(Radius.circular(15.0),
  ),
  gradient: kGradientColor,
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(.05),
    spreadRadius: 1,
    blurRadius: 1,
    offset: const Offset(0,4), // changes position of shadow
  ),],);
var kBoxDecorationWithoutGradient=BoxDecoration (
  color: const Color(0xFFD4F1FF).withOpacity(.3),
  borderRadius: const BorderRadius.all(Radius.circular(12.0),
  ),
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(.05),
      spreadRadius: 1,
      blurRadius: 1,
      offset: const Offset(-2, -2), // changes position of shadow
    ),],);
var kBoxBorder = BoxDecoration (
  border: Border.all(
    color: Colors.lightBlueAccent.withOpacity(.5),
    width: 1.0,
  ),
  color: const Color(0xFF8CDAFF).withOpacity(.2),
  borderRadius: const BorderRadius.all(Radius.circular(15.0),
  ),
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(.05),
      spreadRadius: 1,
      blurRadius: 1,
      offset: const Offset(-2, -2), // changes position of shadow
    ),
  ],
);
class GreenContainer extends StatelessWidget {
  GreenContainer(this.title);
  String? title;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightGreenAccent.withOpacity(.1),
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        border: Border.all(
          color: const Color(0xFF6BD68D),
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
            const CircleAvatar(backgroundColor:  Colors.green,
              radius: 3,),
            SizedBox(width: 2,),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(title!,
                style: kSmallTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class RedContainer extends StatelessWidget {
  RedContainer(this.title);
  String? title;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.redAccent.withOpacity(.1),
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        border: Border.all(
          color:  Colors.red.withOpacity(.5),
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
             CircleAvatar(backgroundColor:  Colors.red.withOpacity(.5),
              radius: 3,),
            SizedBox(width: 2,),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(title!,
                style: kSmallTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String dotRefactorFunction (String hash){

 if(hash.isNotEmpty) {
    var result = hash[0] +
        hash[1] +
        hash[2] +
        '...' +
        hash[hash.length - 3] +
        hash[hash.length - 2] +
        hash[hash.length - 1];
    return result;
  }
 else
 {
   return '';
 }

}
String dateTime(DateTime dateTime){
  var fm = DateFormat('yyyy-MM-dd HH:mm:ss');
  return fm.format(dateTime);
}

double truncateToDecimalPlaces(num value, int fractionalDigits) => (value * pow(10,
    fractionalDigits)).truncate() / pow(10, fractionalDigits);

String k_m_b_generator(num) {
  if (num > 999 && num < 99999) {
    return "${(num / 1000).toStringAsFixed(1)} K";
  } else if (num > 99999 && num < 999999) {
    return "${(num / 1000).toStringAsFixed(0)} K";
  } else if (num > 999999 && num < 999999999) {
    return "${(num / 1000000).toStringAsFixed(1)} M";
  } else if (num > 999999999) {
    return "${(num / 1000000000).toStringAsFixed(1)} B";
  } else {
    return num.toString();
  }
}

 getValue(String symbol, String jsonString) {
  // remove parentheses and convert to valid JSON format
  jsonString = jsonString.replaceAll("(", "\"").replaceAll(")", "\"").replaceAll(",", ":");
  var parsedJson = json.decode(jsonString);

  // search for symbol
  for(var entry in parsedJson.entries) {
    if(entry.key == symbol) {
      return entry.value;
    }
  }
  return null;
}

 getValueNextTo(String jsonString, String symbol) {
  // Reformat the json string to a proper json format
  jsonString = jsonString.replaceAll("\'", "\"");

  // Parse the json string
  var json = jsonDecode(jsonString);
  var coins = json[0]["coins"];

  // Search for the value next to the given symbol
  var pattern = RegExp("\\($symbol,([\\d.]+)\\)");
  var match = pattern.firstMatch(coins);

  // Return the value as a double
  if (match != null) {
    return double.parse(match.group(1)!);
  } else {
    return null;
  }
}


String removeAllChar(String comm){
  List newS=[];

  for(int i=0;i<comm.length;i++){

    if(
    (comm[i])=='0'||(comm[i])=='1'||(comm[i])=='2'||(comm[i])=='3'||(comm[i])=='4'||(comm[i])=='5'||
        (comm[i])=='6'||(comm[i])=='7'||(comm[i])=='8'||(comm[i])=='9'||(comm[i])=='.')
    {
      newS.add(comm[i]);

    }
    if(comm[i]==')')break;
  }
   comm.replaceAll(RegExp(','), '');
  return newS.join("");
}

 findBracketByToken(String input, String token) {
  RegExp regExp = RegExp("\\(" + token + ".*\\)");
  RegExpMatch? match = regExp.firstMatch(input);
  return match!.group(0);
}
 getValueFromBracket(String bracket) {
  RegExp exp = new RegExp(r'[\d.]+');
  Iterable<RegExpMatch> matches = exp.allMatches(bracket);
  return double.parse(matches.first.group(0)!);
}


int screen(int scrNo){
  return scrNo;
}

String? getRestrictedCharacters(String string){
  const notAllowedCharacters = r"""1234567890!"#$%&'()+,-./:;<=>?@[\]^_`{|}~""";
  Set<String> restricted = Set();
  final split = string.split('');
  split.forEach((c) {
    if (!notAllowedCharacters.contains(c)) {
      restricted.add(c);
    }
  });
  if (restricted.isEmpty){
    return '';
  } else {
    return restricted.join("");
  }
}

getType(String input) {
  input=truncateBeforeLastDot(input);
  switch (input) {


    //auction
  // MsgPlaceSurplusBid(MsgPlaceSurplusBidRequest) returns (MsgPlaceSurplusBidResponse);
  // rpc MsgPlaceDebtBid(MsgPlaceDebtBidRequest) returns (MsgPlaceDebtBidResponse);
  // rpc MsgPlaceDutchBid(MsgPlaceDutchBidRequest) returns (MsgPlaceDutchBidResponse);
  // rpc MsgPlaceDutchLendBid(MsgPlaceDutchLendBidRequest) returns (MsgPlaceDutchLendBidResponse);

    case 'MsgPlaceSurplusBidRequest':
      return 'Place Surplus Bid Request';

    case 'MsgPlaceDebtBidRequest':
      return 'Place Debt Bid Request';

    case 'MsgPlaceDutchBidRequest':
      return 'Place Surplus Dutch Request';

    case 'MsgPlaceDutchLendBidRequest':
      return 'Place Dutch Lend Bid Request';

//bandOracles
    case 'MsgFetchPriceDataResponse':
      return 'Fetch Price Data Response';



    //  esm
  //message MsgDepositESMResponse {}
  // message MsgExecuteESMResponse {}
  // message MsgKillResponse {}
  // message MsgCollateralRedemptionResponse{}

    case 'MsgDepositESMResponse':
      return 'Deposit ESM Response';

    case 'MsgExecuteESMResponse':
      return 'Execute ESM Response';

    case 'MsgKillResponse':
      return 'Kill Response';

    case 'MsgCollateralRedemptionResponse':
      return 'Collateral Redemption Response';

      //lend

      // message MsgLendResponse {}
      // message MsgWithdrawResponse {}
      // message MsgDepositResponse {}
      // message MsgCloseLendResponse {}
      // message MsgBorrowResponse {}
      // message MsgRepayResponse {}
      // message MsgDepositBorrowResponse {}
      // message MsgDrawResponse {}
      // message MsgCloseBorrowResponse {}
      // message MsgBorrowAlternateResponse {}
      // message MsgFundModuleAccountsResponse {}
      // message MsgCalculateInterestAndRewardsResponse {}


    case 'MsgLend':
      return 'Lend';

    case 'MsgWithdraw':
      return 'Withdraw Request';

    case 'MsgDeposit':
      return 'Deposit Request';

    case 'MsgCloseLend':
      return 'Close Lend Response';
      //not done
    case 'MsgBorrow':
      return 'Borrow Response';

    case 'MsgRepay':
      return 'Repay Response';

      //not done
    case 'MsgDepositBorrow':
      return 'Deposit Borrow Response';

      case 'MsgDraw':
      return 'Draw Response';

        //not done
    case 'MsgCloseBorrow':
      return 'Close Borrow Response';

    case 'MsgBorrowAlternate':
      return 'Borrow Alternate Response';
        //not done
    case 'MsgFundModuleAccounts':
      return 'Fund Module Accounts Response';

    case 'MsgCalculateInterestAndRewards':
      return 'Calculate Interest And Rewards';


      //liquidation
    //MsgLiquidateBorrowResponse{}
  //MsgLiquidateVaultResponse{}
    case 'MsgLiquidateVaultResponse':
      return 'Liquidate Vault Response';

    case 'MsgLiquidateBorrowResponse':
      return 'Liquidate Borrow Response';


      //liquidity (done except few)
  //rpc CreatePair() returns (MsgCreatePairResponse);
  //
  //   // CreatePool defines a method for creating a pool
  //   rpc CreatePool() returns (MsgCreatePoolResponse);
  //
  //   // Deposit defines a method for depositing coins to the pool
  //   rpc Deposit() returns (MsgDepositResponse);
  //
  //   // Withdraw defines a method for withdrawing pool coin from the pool
  //   rpc Withdraw() returns (MsgWithdrawResponse);
  //
  //   // LimitOrder defines a method for making a limit order
  //   rpc LimitOrder() returns (MsgLimitOrderResponse);
  //
  //   // MarketOrder defines a method for making a market order
  //   rpc MarketOrder() returns (MsgMarketOrderResponse);
  //
  //   // CancelOrder defines a method for cancelling an order
  //   rpc CancelOrder() returns (MsgCancelOrderResponse);
  //
  //   // CancelAllOrders defines a method for cancelling all orders
  //   rpc CancelAllOrders() returns (MsgCancelAllOrdersResponse);
  //
  //   // MsgFarm defines a method to farm the pool token, for incentivization
  //   rpc Farm() returns (MsgFarmResponse);
  //
  //   // Unfarm defines a method to unfarm the farmed pool token
  //   rpc Unfarm() returns (MsgUnfarmResponse);
  //
  // }

    case 'MsgCreatePair':
      return 'Create Pair';


    case 'MsgCreatePool':
      return 'Create Pool';

      //done
    case 'MsgDeposit':
      return 'Deposit';
    //done
    case 'MsgWithdraw':
      return 'Withdraw';
    //done
    case 'MsgLimitOrder':
      return 'Limit Order';
    //done
    case 'MsgMarketOrder':
      return 'Market Order';

    //done
    case 'MsgCancelOrder':
      return 'Cancel Order';

    case 'MsgCancelAllOrders':
      return 'Cancel ALl Orders';
      //done
    case 'MsgFarm':
      return 'Farm';
    //done
    case 'MsgUnfarm':
      return 'UnFarm';

  //locker (all done)
  // rpc MsgCreateLocker() returns (MsgCreateLockerResponse);
  //   rpc MsgDepositAsset(MsgDepositAssetRequest) returns (MsgDepositAssetResponse);
  //   rpc MsgWithdrawAsset() returns (MsgWithdrawAssetResponse);
  //   rpc MsgCloseLocker() returns (MsgCloseLockerResponse);
  //   rpc MsgLockerRewardCalc() returns (MsgLockerRewardCalcResponse);


    case 'MsgCreateLockerRequest':
      return 'Create Locker Request';

    case 'MsgDepositAssetRequest':
      return 'Deposit Asset Request';

    case 'MsgWithdrawAssetRequest':
      return 'Withdraw Asset Request';

    case 'MsgCloseLockerRequest':
      return 'Close Locker Request';

    case 'MsgLockerRewardCalcRequest':
      return 'Locker Reward Calc Request';

//rewards
//       rpc CreateGauge(MsgCreateGauge) returns (MsgCreateGaugeResponse);
//       rpc ExternalRewardsLockers(ActivateExternalRewardsLockers) returns (ActivateExternalRewardsLockersResponse);
//       rpc ExternalRewardsVault(ActivateExternalRewardsVault) returns (ActivateExternalRewardsVaultResponse);
//       rpc ExternalRewardsLend(ActivateExternalRewardsLend) returns (ActivateExternalRewardsLendResponse);

      //done only this
    case 'MsgCreateGauge':
      return 'Create Gauge';

    case 'ActivateExternalRewardsLockers':
      return 'Activate External Rewards Lockers';

    case 'ActivateExternalRewardsVault':
      return 'Activate External Rewards Vault';

    case 'ActivateExternalRewardsLend':
      return 'Activate External Rewards Lend';

//tokenmint (done)

    case 'MsgMintNewTokensRequest':
      return 'Mint New Tokens Request';

      //vault (all done)
      // rpc MsgCreate() returns (MsgCreateResponse);
      // rpc MsgDeposit() returns (MsgDepositResponse);
      // rpc MsgWithdraw() returns (MsgWithdrawResponse);
      // rpc MsgDraw() returns (MsgDrawResponse);
      // rpc MsgRepay() returns (MsgRepayResponse);
      // rpc MsgClose() returns (MsgCloseResponse);
      // rpc MsgDepositAndDraw() returns (MsgDepositAndDrawResponse);
      // rpc MsgCreateStableMint() returns (MsgCreateStableMintResponse);
      // rpc MsgDepositStableMint() returns (MsgDepositStableMintResponse);
      // rpc MsgWithdrawStableMint(MsgWithdrawStableMintRequest) returns (MsgWithdrawStableMintResponse);
      // rpc MsgVaultInterestCalc(MsgVaultInterestCalcRequest) returns (MsgVaultInterestCalcResponse);


    case 'MsgCreateRequest':
      return 'Create Response';

    case 'MsgDepositRequest':
      return 'Deposit Response';

    case 'MsgWithdrawRequest':
      return 'Withdraw Request';

    case 'MsgDrawRequest':
      return 'Draw Request';

    case 'MsgRepayRequest':
      return 'Repay Request';

    case 'MsgCloseRequest':
      return 'Close Request';

    case 'MsgDepositAndDrawRequest':
      return 'Deposit And Draw Request';

    case 'MsgCreateStableMintRequest':
      return 'Create Stable Mint Request';

    case 'MsgDepositStableMintRequest':
      return 'Deposit Stable Mint Request';

    case 'MsgWithdrawStableMintRequest':
      return 'Withdraw Stable Mint Request';

    case 'MsgVaultInterestCalcRequest':
      return 'Vault Interest Calc Request';


    //cosmos

      //auth
    case 'MsgUpdateParams':
      return 'Update Params';

      //authz
      //done
    case 'MsgGrant':
      return 'Grant';

    //done
    case 'MsgRevoke':
      return 'Revoke';

      //bank
    //done
    case 'MsgSend':
      return 'Send';

    case 'MsgMultiSend':
      return 'Multi Send';

    case 'MsgUpdateParams':
      return 'Update Params';

    case 'MsgSetSendEnabled':
      return 'Set Send Enabled';

    //circuit
    case 'MsgAuthorizeCircuitBreaker':
      return 'Authorized Circuit Breaker';

    case 'MsgTripCircuitBreaker':
      return 'Trip Circuit Breaker';

    case 'MsgResetCircuitBreaker':
      return 'Reset Circuit Breaker';

      //distribution
        //done
    case 'MsgSetWithdrawAddress':
      return 'Set Withdraw Address';
        //done
    case 'MsgWithdrawDelegatorReward':
      return 'Withdraw Delegator Reward';
        //done
    case 'MsgWithdrawValidatorCommission':
      return 'Withdraw Validator Commission';

    case 'MsgFundCommunityPool':
      return 'Fund Community Pool';

    case 'MsgCommunityPoolSpend':
      return 'Community Pool Spend';

    case 'MsgDepositValidatorRewardsPool':
      return 'Deposit Validator Rewards Pool';

      //evidence
    case 'MsgSubmitEvidence':
      return 'Submit Evidence';

      //freegrant

    case 'MsgGrantAllowance':
      return 'Grant Allowance';

    case 'MsgRevokeAllowanceResponse':
      return 'Revoke Allowance';

      //gov
  //done
    case 'MsgSubmitProposal':
      return 'Submit Proposal';

      //done
    case 'MsgVote':
      return 'Vote';
      //done
    case 'MsgVoteWeighted':
      return 'Vote Weighted';
      //(same as in comdex module but different JSON)
    case 'MsgDeposit':
      return 'Deposit';

      //group (not done)
    case 'MsgCreateGroup':
      return 'Create Group';

    case 'MsgUpdateGroupMembers':
      return 'Update Group Members';

    case 'MsgUpdateGroupAdmin':
      return 'Update Group Admin';

    case 'MsgUpdateGroupMetadata':
      return 'Update Group Metadata';

    case 'MsgCreateGroupPolicy':
      return 'Create Group Policy';

    case 'MsgCreateGroupWithPolicy':
      return 'Create Group With Policy';

    case 'MsgUpdateGroupPolicyAdmin':
      return 'Update Group Policy Admin';

    case 'MsgUpdateGroupPolicyDecisionPolicy':
      return 'Update Group Policy Decision Policy';



    case 'MsgUpdateGroupPolicyMetadata':
      return 'Update Group Policy Metadata';

    case 'MsgSubmitProposal':
      return 'Submit Proposal';

    case 'MsgWithdrawProposal':
      return 'Withdraw Proposal';

    case 'MsgLeaveGroup':
      return 'Leave Group';

    case 'MsgUpdateGroupPolicyDecisionPolicy':
      return 'Update Group Policy Decision Policy';

      //mint MsgUpdateParams only

    case'/cosmos.tx.v1beta1.Tx':
      return 'Execute Contract';

      //staking
    case'MsgCreateValidator':
      return 'Create Validator';
    case'MsgEditValidator':
      return 'Edit Validator';
    case'MsgExec':
      return 'Execute';
    case'MsgBeginRedelegate':
      return 'Begin Redelegate';
    case'MsgDelegate':
      return 'Delegate';


    //to be done
    case'MsgUndelegate':
      return 'Undelegate';
    case'MsgCancelUnbondingDelegation':
      return 'Cancel Unbonding Delegation';
    case'MsgUpdateParams':
      return 'Update Params';

      //slashing
    // case'/cosmos.slashing.v1beta1.MsgUnjail':
    case'MsgUnjail':
      return 'Unjail';
    case'MsgUpdateParams':
      return 'Update Params';

      //upgrade
    case'MsgSoftwareUpgrade':
      return 'Software Upgrade';
    case'MsgCancelUpgrade':
      return 'Cancel Upgrade Validator';

      //vesting
    case'/cosmos.vesting.v1beta1.MsgCreateVestingAccount':
      return 'Create Vesting Acc';
    case'/cosmos.vesting.v1beta1.MsgCreatePermanentLockedAccount':
      return 'Create Permanent Locked Acc';
    case'/cosmos.vesting.v1beta1.MsgCreatePeriodicVestingAccount':
      return 'Create Periodic Vesting Acc';


      //cosmwasm
    case '/cosmwasm.wasm.v1.MsgExecuteContract':
      return 'Execute Contract';

      //ibc
    case 'MsgUpdateClient':
      return 'Update Client';

    case 'MsgTransfer':
      return 'IBC Transfer';

    case '/ibc.core.client.v1.MsgDepositResponse':
      return 'Deposit Request';

      //osmosis
    case 'MsgSwapExactAmountIn':
      return 'Swap Exact Amount In';

    case 'MsgSwapExactAmountOut':
      return 'Swap Exact Amount Out';

    case 'MsgJoinPool':
      return 'Join Pool';

      //contract

    case 'MsgExecuteContract':
      return 'Execute Contract';


    default:
      return input;
  }
}
String truncateBeforeLastDot(String input) {
  int lastDotIndex = input.lastIndexOf(".");
  if (lastDotIndex == -1) {
    return input;
  } else {
    return input.substring(lastDotIndex + 1);
  }
}