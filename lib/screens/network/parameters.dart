import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:zenscape_app/constants/constants.dart';
import '../../backend files/networkList.dart';
import '../../constants/constString.dart';
import '../../widgets/navigationDrawerWidget.dart';
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



  var mintdenom,blocksPerYear;
  var max_val,unbondTime,max_entries,hist_entries;
  var base_reward,bonus_reward,commTax,withdraw_enabled;
  var signedBlockWindow,minSignedPerWindow,slashFractionDoubleSign,slashFractionDowntime;
  var minDeposit,maxDeposit,votingPeriod,quorum,threshold,vetoThreshold;
  var stakingParams;



void initstate() {
  super.initState();
  getData();
}

  static Future<String> fetchDataMint(String input,String json1,String json2) async {
    final response = await http.get(Uri.parse(input));
    if (response.statusCode == 200) {
      return await (jsonDecode(response.body)[json1][json2].toString());
    } else {
      return '';
    }
  }
  // static Future<String> fetchDataGov(String input,String json1,String json2) async {
  //   final response = await http.get(Uri.parse(input));
  //   if (response.statusCode == 200) {
  //     return await (jsonDecode(response.body)[0][json1][json2]).toString();
  //   } else {
  //     return '';
  //   }
  // }

  void getData() async {
     mintdenom = (await fetchDataMint(widget.networkList!.mintingParamssUrl!,'result','mint_denom'));
     blocksPerYear = (await fetchDataMint(widget.networkList!.mintingParamssUrl!,'result','blocks_per_year'));


     max_val = (await fetchDataMint(widget.networkList!.stakingParamsUrl!,'result','max_validators'));
     unbondTime = (await fetchDataMint(widget.networkList!.stakingParamsUrl!,'result','unbonding_time'));
     max_entries = (await fetchDataMint(widget.networkList!.stakingParamsUrl!,'result','max_entries'));
     hist_entries = (await fetchDataMint(widget.networkList!.stakingParamsUrl!,'result','historical_entries'));


     commTax = (await fetchDataMint(widget.networkList!.distParamsUrl!,'result','community_tax'));
     base_reward = (await fetchDataMint(widget.networkList!.distParamsUrl!,'result','base_proposer_reward'));
     bonus_reward = (await fetchDataMint(widget.networkList!.distParamsUrl!,'result','bonus_proposer_reward'));
     withdraw_enabled = (await fetchDataMint(widget.networkList!.distParamsUrl!,'result','withdraw_addr_enabled'));

     signedBlockWindow = (await fetchDataMint(widget.networkList!.slashingParamsUrl!,'result','signed_blocks_window'));
     minSignedPerWindow = (await fetchDataMint(widget.networkList!.slashingParamsUrl!,'result','min_signed_per_window'));
     slashFractionDoubleSign = (await fetchDataMint(widget.networkList!.slashingParamsUrl!,'result','slash_fraction_double_sign'));
     slashFractionDowntime = (await fetchDataMint(widget.networkList!.slashingParamsUrl!,'result','slash_fraction_downtime'));


     // maxDeposit = (await fetchDataGov(widget.networkList!.govParamsUrl!,'deposit_params','max_deposit_period'));
     // votingPeriod = (await fetchDataGov(widget.networkList!.govParamsUrl!,'voting_params','voting_period'));
     // quorum= (await fetchDataGov(widget.networkList!.govParamsUrl!,'tally_params','quorum'));
     // threshold= (await fetchDataGov(widget.networkList!.govParamsUrl!,'tally_params','threshold'));
     // vetoThreshold=(await fetchDataGov(widget.networkList!.govParamsUrl!,'tally_params','veto_threshold'));

     mintParams=[blocksPerYear,mintdenom];
     stakeParams=[unbondTime,max_val,max_entries,hist_entries];

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

     setState(() {
       if (
       //vetoThreshold != null &&
       //     threshold!= null &&
           // quorum != null &&
       commTax!=null&&
           slashFractionDowntime != null &&
           //maxDeposit!=null&&
           blocksPerYear!=null) {
         isLoaded = true;

       } else {
         isLoaded = false;
       }
     });
  }

  TextEditingController nameController=TextEditingController();
  String fullName = '';
  @override
  Widget build(BuildContext context) {
    getData();

    return isLoaded? Scaffold(
      drawer: NavDraw(networkData: widget.networkList),
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text('Parameters',
              style:TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: 'MontserratBold',
                fontSize: 20,
              ),),
          ],
        ),
      ),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width/1.1,
              height: 40,
              decoration: kBoxDecorationWithoutGradient,
              margin: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15),
                    filled: true,
                    fillColor: Colors.transparent,
                    focusedBorder: InputBorder.none,
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    hintText: 'Select a chain',
                    prefixIcon: const Icon(Icons.search),
                  ),
                  onChanged: (text) {
                    setState(() {
                      fullName = text;
                      //you can access nameController in its scope to get
                      // the value of text entered as shown below
                      //fullName = nameController.text;
                    });
                  },
                ),
              )),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Minting Parameters',
                  style:kMediumTextStyle),
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
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Staking Parameters',
                      style:kMediumTextStyle),
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
                  child: Text('Governance Parameters',
                      style:kMediumTextStyle),
                ),
                StaggeredGridView.countBuilder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    itemCount: govParams.length,
                    itemBuilder: (context,index){
                      return InfoCard(title1: govTitle[index],icon1: image[index],titleValue1: govParams[index]);
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
                      style:kMediumTextStyle),
                ),
                StaggeredGridView.countBuilder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
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
                      style:kMediumTextStyle),
                ),
                StaggeredGridView.countBuilder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    itemCount: slashingParams.length,
                    itemBuilder: (context,index){
                      return InfoCard(title1:slashTitle[index],icon1: image[index],titleValue1: slashingParams[index]);
                    },
                    staggeredTileBuilder: (index) => const StaggeredTile.fit(1)),
              ],
            ),
          ),
        ],
      ),
    ):const Center(child: CircularProgressIndicator());
  }
}
