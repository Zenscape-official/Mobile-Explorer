import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  fontWeight: Platform.isAndroid?FontWeight.w700: FontWeight.w700,
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

String dotRefactorFunction (String hash){
var result=hash[0]+hash[1]+hash[2]+'...'+hash[hash.length-3]+hash[hash.length-2]+hash[hash.length-1];
return result;
}
String dateTime(DateTime dateTime){
  var fm = DateFormat('yyyy-MM-dd hh:mm:ss');
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
    return '0';
  } else {
    return restricted.join("");
  }
}






getType(String input) {
  switch (input) {
    //auction
  // MsgPlaceSurplusBid(MsgPlaceSurplusBidRequest) returns (MsgPlaceSurplusBidResponse);
  // rpc MsgPlaceDebtBid(MsgPlaceDebtBidRequest) returns (MsgPlaceDebtBidResponse);
  // rpc MsgPlaceDutchBid(MsgPlaceDutchBidRequest) returns (MsgPlaceDutchBidResponse);
  // rpc MsgPlaceDutchLendBid(MsgPlaceDutchLendBidRequest) returns (MsgPlaceDutchLendBidResponse);

    case '/comdex.auction.v1beta1.MsgPlaceSurplusBidRequest':
      return 'Place Surplus Bid Request';

    case '/comdex.auction.v1beta1.MsgPlaceDebtBidRequest':
      return 'Place Debt Bid Request';

    case '/comdex.auction.v1beta1.MsgPlaceDutchBidRequest':
      return 'Place Surplus Dutch Request';

    case '/comdex.auction.v1beta1.MsgPlaceDutchLendBidRequest':
      return 'Place Dutch Lend Bid Request';

//bandOracles
    case '/comdex.bandoracle.v1beta1.MsgFetchPriceDataResponse':
      return 'Fetch Price Data Response';



    //  esm
  //message MsgDepositESMResponse {}
  // message MsgExecuteESMResponse {}
  // message MsgKillResponse {}
  // message MsgCollateralRedemptionResponse{}

    case '/comdex.esm.v1beta1.MsgDepositESMResponse':
      return 'Deposit ESM Response';

    case '/comdex.esm.v1beta1.MsgExecuteESMResponse':
      return 'Execute ESM Response';

    case '/comdex.esm.v1beta1.MsgKillResponse':
      return 'Kill Response';

    case '/comdex.esm.v1beta1.MsgCollateralRedemptionResponse':
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

    case '/comdex.lend.v1beta1.MsgLendResponse':
      return 'Lend Request';

    case '/comdex.lend.v1beta1.MsgWithdrawResponse':
      return 'Withdraw Request';

    case '/comdex.lend.v1beta1.MsgDepositResponse':
      return 'Deposit Request';

    case '/comdex.lend.v1beta1.MsgCloseLendResponse':
      return 'Close Lend Response';

    case '/comdex.lend.v1beta1.MsgBorrowResponse':
      return 'Borrow Response';

    case '/comdex.lend.v1beta1.MsgRepayResponse':
      return 'Repay Response';

    case '/comdex.lend.v1beta1.MsgDepositBorrowResponse':
      return 'Deposit Borrow Response';

      case '/comdex.lend.v1beta1.MsgDrawResponse':
      return 'Draw Response';
    case '/comdex.lend.v1beta1.MsgCloseBorrowResponse':
      return 'Close Borrow Response';

    case '/comdex.lend.v1beta1.MsgBorrowAlternateResponse':
      return 'Borrow Alternate Response';

    case '/comdex.lend.v1beta1.MsgFundModuleAccountsResponse':
      return 'Fund Module Accounts Response';

    case '/comdex.lend.v1beta1.MsgFundModuleAccountsResponse':
      return 'Calculate Interest And Rewards Response';


      //liquidation
    //MsgLiquidateBorrowResponse{}
    case '/comdex.liquidation.v1beta1.MsgLiquidateBorrowResponse':
      return 'Liquidate Borrow Response';


      //liquidity
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

    case '/comdex.liquidity.v1beta1.MsgCreatePair':
      return 'Create Pair';


    case '/comdex.liquidity.v1beta1.MsgCreatePool':
      return 'Create Pool';

    case '/comdex.liquidity.v1beta1.MsgDeposit':
      return 'Deposit';

    case '/comdex.liquidity.v1beta1.MsgWithdraw':
      return 'Withdraw';

    case '/comdex.liquidity.v1beta1.MsgLimitOrder':
      return 'Limit Order';

    case '/comdex.liquidity.v1beta1.MsgMarketOrder':
      return 'Market Order';

    case '/comdex.liquidity.v1beta1.MsgCancelOrder':
      return 'Cancel Order';

    case '/comdex.liquidity.v1beta1.MsgCancelAllOrders':
      return 'Cancel ALl Orders';

    case '/comdex.liquidity.v1beta1.MsgFarm':
      return 'Farm';

    case '/comdex.liquidity.v1beta1.MsgUnfarm':
      return 'UnFarm';
  //locker
  // rpc MsgCreateLocker() returns (MsgCreateLockerResponse);
  //   rpc MsgDepositAsset(MsgDepositAssetRequest) returns (MsgDepositAssetResponse);
  //   rpc MsgWithdrawAsset() returns (MsgWithdrawAssetResponse);
  //   rpc MsgCloseLocker() returns (MsgCloseLockerResponse);
  //   rpc MsgLockerRewardCalc() returns (MsgLockerRewardCalcResponse);


    case '/comdex.locker.v1beta1.MsgCreateLockerRequest':
      return 'Create Locker Request';

    case '/comdex.locker.v1beta1.MsgDepositAssetRequest':
      return 'Deposit Asset Request';

    case '/comdex.locker.v1beta1.MsgWithdrawAssetRequest':
      return 'Withdraw Asset Request';

    case '/comdex.locker.v1beta1.MsgCloseLockerRequest':
      return 'Close Locker Request';

    case '/comdex.locker.v1beta1.MsgLockerRewardCalcRequest':
      return 'Locker Reward Calc Request';

//rewards
//       rpc CreateGauge(MsgCreateGauge) returns (MsgCreateGaugeResponse);
//       rpc ExternalRewardsLockers(ActivateExternalRewardsLockers) returns (ActivateExternalRewardsLockersResponse);
//       rpc ExternalRewardsVault(ActivateExternalRewardsVault) returns (ActivateExternalRewardsVaultResponse);
//       rpc ExternalRewardsLend(ActivateExternalRewardsLend) returns (ActivateExternalRewardsLendResponse);


    case '/comdex.rewards.v1beta1.MsgCreateGauge':
      return 'Create Gauge';

    case '/comdex.rewards.v1beta1.ActivateExternalRewardsLockers':
      return 'Activate External Rewards Lockers';

    case '/comdex.rewards.v1beta1.ActivateExternalRewardsVault':
      return 'Activate External Rewards Vault';

    case '/comdex.rewards.v1beta1.ActivateExternalRewardsLend':
      return 'Activate External Rewards Lend';

//tokenmint

    case '/comdex.tokenmint.v1beta1.MsgMintNewTokensRequest':
      return 'Mint New Tokens Request';

      //vault
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


    case '/comdex.vault.v1beta1.MsgCreateRequest':
      return 'Create Response';

    case '/comdex.vault.v1beta1.MsgDepositRequest':
      return 'Deposit Response';

    case '/comdex.vault.v1beta1.MsgWithdrawRequest':
      return 'Withdraw Request';

    case '/comdex.vault.v1beta1.MsgDrawRequest':
      return 'Draw Request';

    case '/comdex.vault.v1beta1.MsgRepayRequest':
      return 'Repay Request';

    case '/comdex.vault.v1beta1.MsgCloseRequest':
      return 'Close Request';

    case '/comdex.vault.v1beta1.MsgDepositAndDrawRequest':
      return 'Deposit And Draw Request';

    case '/comdex.vault.v1beta1.MsgCreateStableMintRequest':
      return 'Create Stable Mint Request';

    case '/comdex.vault.v1beta1.MsgDepositStableMintRequest':
      return 'Deposit Stable Mint Request';

    case '/comdex.vault.v1beta1.MsgWithdrawStableMintRequest':
      return 'Withdraw Stable Mint Request';

    case '/comdex.vault.v1beta1.MsgVaultInterestCalcRequest':
      return 'Vault Interest Calc Request';

    case '/cosmos.bank.v1beta1.MsgSend':
      return 'Send';
      case '/ibc.core.client.v1.MsgDepositResponse':
      return 'Deposit Request';

    case '/cosmwasm.wasm.v1.MsgExecuteContract':
      return 'Execute Contract';

    case '/ibc.applications.transfer.v1.MsgTransfer':
      return 'IBC Transfer';

    default:
      return 'N/A';
  }
}