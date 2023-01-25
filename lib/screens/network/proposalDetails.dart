import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_rich_text/simple_rich_text.dart';
import 'package:zenscape_app/backend_files/networkList.dart';
import 'package:zenscape_app/backend_files/proposalsModel.dart';
import 'package:zenscape_app/constants/constants.dart';
import 'package:http/http.dart' as http;
import '../../backend_files/propVotesModel.dart';
import '../../constants/functions.dart';
import '../../widgets/searchBarWidget.dart';

class ProposalDetails extends StatefulWidget {
  final ProposalsModel proposalProduct;
  final NetworkList? networkData;
 ProposalDetails({Key? key, required this.proposalProduct,this.networkData}) : super(key: key);
  @override
  State<ProposalDetails> createState() => _ProposalDetailsState();
}
class _ProposalDetailsState extends State<ProposalDetails> {
  TextEditingController nameController=TextEditingController();
  var  status;
  var tallyYes;
  var tallyNo;
  var tallyAbstain;
  var tallyNoWithVeto;
  var tallyTotal;
  var tallyLoaded=false;
  var propVoters;
  var Deposit='0';
  var DepositDenom='';
  var details='';

  getData()async{
    final response = await http.get(Uri.parse('${widget.networkData!.proposalTally}${widget.proposalProduct.id}'));
    final resultVote= await http.get(Uri.parse('${widget.networkData!.proposalVote}${widget.proposalProduct.id}'));
    final resultDeposit= await http.get(Uri.parse('${widget.networkData!.proposalVote}${widget.proposalProduct.id}'));
    if (response.statusCode == 200) {
      tallyYes =  double.parse(jsonDecode(response.body)[0]['yes']);
      tallyNo = double.parse(jsonDecode(response.body)[0]['no']);
      tallyAbstain = double.parse(jsonDecode(response.body)[0]['abstain']);
      tallyNoWithVeto = double.parse(jsonDecode(response.body)[0]['no_with_veto']);
      tallyTotal=tallyNo+tallyYes+tallyAbstain+tallyNoWithVeto;

      setState(() {
        if (tallyYes!=null){
          tallyLoaded=true;
        }
        else{
          tallyLoaded=false;
        }
      });
    }
    else{
      print(response.statusCode);
    }
    if (resultVote.statusCode==200){
    propVoters=List<ProposalVotesModel>.from(json.decode((resultVote.body)).map((x) => ProposalVotesModel.fromJson(x)));
    }
    if (resultDeposit.statusCode==200){
      if(jsonDecode(resultDeposit.body)[0]['amount']!=null)
      Deposit=(jsonDecode(resultDeposit.body)[0]['amount']);

    }

  }
  void fun(){
    if(widget.proposalProduct.status=='PROPOSAL_STATUS_PASSED'){
      status='Passed';
    }
    if(widget.proposalProduct.status=='PROPOSAL_STATUS_PASSED'){
      status='Passed';
    }
    else if(widget.proposalProduct.status=='PROPOSAL_STATUS_REJECTED'){
      status='Rejected';
     // ispassed=false;
    }
    else if(widget.proposalProduct.status=='PROPOSAL_STATUS_VOTING_PERIOD'){
      status='Voting';
      //ispassed=false;
    }
    else if(widget.proposalProduct.status=='PROPOSAL_STATUS_INVALID'){
      status='Invalid';
     // ispassed=false;
    }
    else if(widget.proposalProduct.status=='PROPOSAL_STATUS_DEPOSIT_PERIOD'){
      status='Deposit';
      // ispassed=false;
    }
  }
  @override
  Widget build(BuildContext context) {
    fun();
    getData();
    details=widget.proposalProduct.description!;
    print(details);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Proposal Details',
              style: kBigBoldTextStyle,
            ),
          ],
        ),
      ),
      body: tallyLoaded? SingleChildScrollView(
        child: Column(
            children: [
              SearchBar(nameController:nameController,hintText: 'Enter Block Height,Tx hash, Address..',networkList: widget.networkData,),
              Container(
                margin: const EdgeInsets.only(right: 10,left: 10),
                width: MediaQuery.of(context).size.width/1.1,
                decoration: kBoxDecorationWithGradient,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: kBoxDecorationWithoutGradient,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text('#${widget.proposalProduct.id!}',
                                    style:kMediumBoldTextStyle),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color:status=='Passed'? Colors.lightGreenAccent.withOpacity(.1):Colors.red.shade50,
                                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                border: Border.all(
                                  color: status=='Passed'? const Color(0xFF6BD68D):Colors.red.withOpacity(.5),
                                  width: 1.0,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 9.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children:[
                                     CircleAvatar(backgroundColor:  status=='Passed'? const Color(0xFF6BD68D):Colors.red.withOpacity(.5),
                                      radius: 3,),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(status??'',
                                        style: kSmallTextStyle,),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Text(widget.proposalProduct.title??'',
                            style:kMediumBoldTextStyle),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Proposer',
                                    style:kSmallTextStyle),
                                InkWell(
                                  onTap: () => Clipboard.setData(ClipboardData(
                                    text: widget.proposalProduct.proposerAddress!,
                                  )).then((_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Proposer Address Copied to your clipboard !')));
                                  }),
                                  child: Row(
                                    children: [
                                      Text(dotRefactorFunction(widget.proposalProduct.proposerAddress!),
                                          style: kSmallBoldTextStyle),
                                      const SizedBox(width: 4),
                                      const Icon(
                                        Icons.copy,
                                        color: Colors.black54,
                                        size: 15,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20,),

                                Text('Total Deposit',
                                    style:kSmallTextStyle),
                                Text('${addComma(removeAllChar(Deposit))} ${getRestrictedCharacters(Deposit)}'
                                    ,
                                    style:kSmallBoldTextStyle),
                                const SizedBox(height: 20,),

                                Text('Voting End',
                                    style:kSmallTextStyle),
                                Text((dateTime(widget.proposalProduct.votingEndTime!)).toString(),
                                    style:kSmallBoldTextStyle),
                                const SizedBox(height: 20,),

                                Text('Submit Time',
                                    style:kSmallTextStyle),
                                Text((dateTime(widget.proposalProduct.submitTime!)).toString(),
                                    style:kSmallBoldTextStyle),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('   ',
                                    style:kSmallTextStyle),
                                Text('   ',
                                    style:kSmallBoldTextStyle),
                                const SizedBox(height: 20,),

                                Text('Voting Start',
                                    style:kSmallTextStyle),
                                Text((dateTime(widget.proposalProduct.votingStartTime!)).toString(),
                                  style:kSmallBoldTextStyle),
                                const SizedBox(height: 20,),

                                Text('Type',
                                    style:kSmallTextStyle),
                                Text(widget.proposalProduct.proposalType!,
                                    style:kSmallBoldTextStyle),
                                const SizedBox(height: 20,),

                                Text('Deposit End Time',
                                    style:kSmallTextStyle),
                                Text((dateTime(widget.proposalProduct.depositEndTime!)).toString(),
                                    style:kSmallBoldTextStyle),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Text('Details ',
                            style:kSmallBoldTextStyle),
                        const SizedBox(height: 2,),
                       SimpleRichText(formatString(widget.proposalProduct.description!),
                            style:kSmallTextStyle),
                        const SizedBox(height: 20,),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Final Status',
                                style:kSmallBoldTextStyle),
                            Container(
                              decoration: BoxDecoration(
                                color:status=='Passed'? Colors.lightGreenAccent.withOpacity(.1):Colors.red.shade50,
                                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                border: Border.all(
                                  color: status=='Passed'? const Color(0xFF6BD68D):Colors.red.withOpacity(.5),
                                  width: 1.0,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 9.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children:[
                                    CircleAvatar(backgroundColor:  status=='Passed'? const Color(0xFF6BD68D):Colors.red.withOpacity(.5),
                                      radius: 3,),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(status??'',
                                        style: kSmallTextStyle,),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Row(children: [
                          Container(
                            height:15,
                            width: 15,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(width:10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              Text('Yes',
                              style:kSmallTextStyle),
                              Text((tallyTotal)>0?
                              ('${tallyYes*100/tallyTotal}%').toString():'0',
                              style:kSmallBoldTextStyle),
                              Text(tallyYes.toString(),
                              style:kSmallTextStyle)
                            ]
                          )
                        ],),
                        const SizedBox(height: 15),
                        Row(children: [
                          Container(
                            height:15,
                            width: 15,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(width:10),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                Text('No',
                                    style:kSmallTextStyle),
                                Text((tallyTotal)>0?
                                ('${tallyNo*100/tallyTotal}%').toString():'0',
                                    style:kSmallBoldTextStyle),
                                Text(tallyNo.toString(),
                                style:kSmallTextStyle)
                              ]
                          )
                        ],),
                        const SizedBox(height: 15),
                        Row(children: [
                          Container(
                            height:15,
                            width: 15,
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(.5),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(width:10),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                Text('NoWithVeto',
                                    style:kSmallTextStyle),
                                Text(
                                    (tallyTotal)>0?
                                    ('${tallyNoWithVeto*100/tallyTotal}%').toString():'0',
                                    style:kSmallBoldTextStyle),
                                Text(tallyNoWithVeto.toString(),
                                style:kSmallTextStyle),

                              ]
                          )
                        ],),
                        const SizedBox(height: 15),
                        Row(children: [
                          Container(
                            height:15,
                            width: 15,
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(.5),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(width:10),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                Text('Abstain',
                                    style:kSmallTextStyle),
                                Text((tallyTotal)>0?
                                ('${tallyAbstain*100/tallyTotal}%').toString():'0',
                                    style:kSmallBoldTextStyle),
                                Text(tallyAbstain.toString(),
                                    style:kSmallTextStyle),
                              ]
                          )
                        ],
                        )
                      ]
                  ),
                ),
              ),
             propVoters.length!=0? Padding(
                padding: const EdgeInsets.fromLTRB(18.0,18,18,18),
                child: Container(
                  decoration: kBoxDecorationWithoutGradient,

                  child: Column(
                      children:[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Text('Votes',style: kSmallBoldTextStyle,),
                            ),
                            //const Filter(),
                          ],
                        ),

                        ListView.builder(
                            reverse: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: propVoters.length,
                            itemBuilder: (BuildContext context, int index)
                            {
                            return VoterCard(proposalVotesModel: propVoters[index],);
                          }
                        ),
                      ]
                  ),
                ),
              ):Container(),
              SizedBox(height: 30,)

            ]
        ),

      ):Center(child: CircularProgressIndicator()),
    );
  }
}

class VoterCard extends StatelessWidget {
  final ProposalVotesModel? proposalVotesModel;
  const VoterCard({
    Key? key,this.proposalVotesModel

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0,0,8,8),
        child: Card(
            color: const Color(0xFFF9FAFC),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Text(proposalVotesModel!.moniker!,style: kSmallBoldTextStyle,),
                      GreenContainer((proposalVotesModel!.option=='VOTE_OPTION_YES')?('Yes'):('No')),
                    ],
                  ),
                  const SizedBox(height: 12,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Validator Address',style: kSmallTextStyle,),
                InkWell(
                  onTap: () =>
                      Clipboard.setData(ClipboardData(
                        text: (proposalVotesModel!.validatorAddress!),
                      )).then((_) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(
                            content: Text(
                                'Validator Address Copied to your clipboard !')));
                      }),
                  child:  Text(dotRefactorFunction(proposalVotesModel!.validatorAddress!), style: kMediumBoldTextStyle,),
                ),

                    ],
                  ),
                  const SizedBox(height: 4,)
                ],
              ),
            )),
      ),
    );
  }
}
