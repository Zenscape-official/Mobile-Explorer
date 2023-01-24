import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:zenscape_app/backend_files/ParameterModel.dart';
import 'package:zenscape_app/constants/constants.dart';
import '../../backend_files/networkList.dart';
import '../../constants/constString.dart';
import '../../widgets/navigationDrawerWidget.dart';
import '../../widgets/searchBarWidget.dart';
import '../homeScreen.dart';
import 'package:http/http.dart' as http;

class Parameters extends StatefulWidget {
  final NetworkList? networkList;
  const Parameters({Key? key,this.networkList}) : super(key: key);

  @override
  State<Parameters> createState() => _ParametersState();
}

class _ParametersState extends State<Parameters> {
  var isLoaded=false;
  var pageIndex=5;
  MintingParamModel? mintingParamModel;

  List<String> mintParams=[' ',' ',' ',' '];
  List<String> stakeParams=[' ',' ',' ',' '];
  List<String> govParams=[' ',' ',' ',' '];
  List<String> slashingParams=[' ',' ',' ',' '];
  List<String> distributionParams=[' ',' ',' ',' '];

  var mintdenom='0',blocksPerYear='0';
  var max_val='0',unbondTime='0',max_entries='0',hist_entries='0';
  var base_reward='0',bonus_reward='0',commTax='0',withdraw_enabled='0';
  var signedBlockWindow='0',minSignedPerWindow='0',slashFractionDoubleSign='0',slashFractionDowntime='0';
  var minDeposit='0',maxDeposit='0',votingPeriod='0',quorum='0',threshold='0',vetoThreshold='0';
  var stakingParams='0';
  var minty;
  var mintyLoaded;

void initstate() {
  super.initState();
  getData();
}

fetchDataMint(String input) async {
    final response = await http.get(Uri.parse(input));
    if (response.statusCode == 200) {
      return (response.body);

    } else {
      return '';
    }
  }
  static Future<String> fetchDataGov(String input,String json1,String json2) async {
    final response = await http.get(Uri.parse(input));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)[0][json1][json2].toString();
    } else {
      return '';
    }
  }

  void getData() async {
  final mintResult=await fetchDataMint(widget.networkList!.mintingParamssUrl!);
  Map<String,dynamic> mintdata= jsonDecode(mintResult)['result'];
  mintdenom = mintdata["mint_denom"];

  blocksPerYear= mintdata["blocks_per_year"];
  final stakeResult=await fetchDataMint(widget.networkList!.stakingParamsUrl!);
  Map<String,dynamic> stakedata= jsonDecode(stakeResult)['result'];
  unbondTime = stakedata["unbonding_time"];

  max_val= (stakedata["max_validators"]).toString();
  max_entries=stakedata["max_entries"].toString();
  hist_entries=stakedata["historical_entries"].toString();

  final distResult=await fetchDataMint(widget.networkList!.stakingParamsUrl!);
  Map<String,dynamic> distdata= jsonDecode(distResult)['result'];
  unbondTime = distdata["unbonding_time"];

  max_val= (distdata["max_validators"]).toString();
  max_entries=distdata["max_entries"].toString();
  hist_entries=distdata["historical_entries"].toString();

  final slashResult=await fetchDataMint(widget.networkList!.slashingParamsUrl!);
  Map<String,dynamic> slashdata= jsonDecode(slashResult)['result'];

  signedBlockWindow = slashdata["signed_blocks_window"];
  minSignedPerWindow= (slashdata["min_signed_per_window"]).toString();
  slashFractionDowntime=slashdata["slash_fraction_downtime"].toString();
  slashFractionDoubleSign=slashdata["slash_fraction_double_sign"].toString();
  setState(() {

  });

  mintParams=[blocksPerYear,mintdenom];
  stakeParams=[
    ' ${(double.parse(unbondTime) / (86400 * 1000000000)).toString()} days',max_val,max_entries,hist_entries];

  // govParams=[k_m_b_generator(double.parse(maxDeposit)),
  //   truncateToDecimalPlaces(double.parse(votingPeriod),2).toString(),
  //   truncateToDecimalPlaces(double.parse(quorum),2).toString(),
  //   truncateToDecimalPlaces(double.parse(threshold),2).toString(),
  //   truncateToDecimalPlaces(double.parse(vetoThreshold),2).toString()];

  slashingParams=[truncateToDecimalPlaces(double.parse(signedBlockWindow),2).toString(),
    truncateToDecimalPlaces(double.parse(minSignedPerWindow),2).toString(),
    truncateToDecimalPlaces(double.parse(slashFractionDoubleSign),2).toString(),
    truncateToDecimalPlaces(double.parse(slashFractionDowntime),2).toString()];

  distributionParams=[
    truncateToDecimalPlaces(double.parse(base_reward),2).toString(),
    truncateToDecimalPlaces(double.parse(bonus_reward),2).toString(),
    truncateToDecimalPlaces(double.parse(commTax),2).toString()
    ,withdraw_enabled];

  }

  TextEditingController nameController=TextEditingController();
  String fullName = '';
  @override
  Widget build(BuildContext context) {
    getData();

    return Scaffold(
      drawer: NavDraw(networkData: widget.networkList,pageIndex: pageIndex,),
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Parameters',
              style:TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: 'MontserratBold',
                fontSize: 20,
              ),),
            CircleAvatar(
                radius:15,
                child: InkWell(
                    //onTap: ()=> Navigator.of(context).popUntil((route) => route.isFirst),
                    child: Image.network(widget.networkList!.logoUrl??widget.networkList!.logUrl!)),
                backgroundColor: Colors.transparent),
          ],
        ),
      ),
      body:
      ListView(
        physics: const ClampingScrollPhysics(),
        children: <Widget>[
          SearchBar(nameController:nameController,hintText: 'Enter Block Height,Tx hash, Address..',networkList: widget.networkList!,),
         widget.networkList!.uDenom=='ucmdx'? Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Minting Parameters',
                  style:kMediumBoldTextStyle),
                ),
                StaggeredGridView.countBuilder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    itemCount: mintParams.length,
                    itemBuilder: (context,index){
                      return InfoCard(title1: mintTitle[index],icon1: image[index],titleValue1: mintParams[index]);
                    },
                    staggeredTileBuilder: (index) => const StaggeredTile.fit(1)),
              ],
            ),
          ):Container(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Staking Parameters',
                      style:kMediumBoldTextStyle),
                ),
                StaggeredGridView.countBuilder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    itemCount: stakeParams.length,
                    itemBuilder: (context,index){
                      return InfoCard(title1: stakeTitle[index],icon1: image[index],titleValue1: stakeParams[index]);
                    },
                    staggeredTileBuilder: (index) => const StaggeredTile.fit(1)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Distribution Parameters',
                      style:kMediumBoldTextStyle),
                ),
                StaggeredGridView.countBuilder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    itemCount: distributionParams.length,
                    itemBuilder: (context,index){
                      return InfoCard(title1:disTitle[index],icon1: image[index],titleValue1: distributionParams[index]);
                    },
                    staggeredTileBuilder: (index) => const StaggeredTile.fit(1)),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Slashing Parameters',
                      style:kMediumBoldTextStyle),
                ),
                StaggeredGridView.countBuilder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    itemCount: slashingParams.length,
                    itemBuilder: (context,index){
                      return InfoCard(title1:slashTitle[index],icon1: image[index],titleValue1: slashingParams[index]);
                    },
                    staggeredTileBuilder: (index) => const StaggeredTile.fit(1)
                ),
              ],
            ),
          ),
          SizedBox(height:30),
        ],
      )

          //:const Center(child: CircularProgressIndicator()),
    );
  }
}
