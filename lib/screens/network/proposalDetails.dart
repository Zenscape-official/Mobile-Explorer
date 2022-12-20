import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zenscape_app/backend_files/proposalsModel.dart';
import 'package:zenscape_app/constants/constants.dart';
import 'package:zenscape_app/widgets/filterTab.dart';
import 'package:http/http.dart' as http;
import '../../backend_files/propVotesModel.dart';


class ProposalDetails extends StatefulWidget {
  final ProposalsModel proposalProduct;
 ProposalDetails({Key? key, required this.proposalProduct}) : super(key: key);
  @override
  State<ProposalDetails> createState() => _ProposalDetailsState();
}

class _ProposalDetailsState extends State<ProposalDetails> {
  var  status;
  var tallyYes;
  var tallyNo;
  var tallyAbstain;
  var tallyNoWithVeto;
  var tallyTotal;
  var tallyLoaded=false;
  var propVoters;
  var Deposit='';
  var DepositDenom='';

  getData()async{
    final response = await http.get(Uri.parse('http://167.235.151.252:3005/proposalTally/${widget.proposalProduct.id}'));
    final resultVote= await http.get(Uri.parse('http://167.235.151.252:3005/proposalVotes/${widget.proposalProduct.id}'));
    final resultDeposit= await http.get(Uri.parse('http://167.235.151.252:3005/proposalDeposit/${widget.proposalProduct.id}'));
    if (response.statusCode == 200) {
      tallyYes =  double.parse(jsonDecode(response.body)[0]['yes']);
      tallyNo = double.parse(jsonDecode(response.body)[0]['no']);
      tallyAbstain = double.parse(jsonDecode(response.body)[0]['abstain']);
      tallyNoWithVeto = double.parse(jsonDecode(response.body)[0]['no_with_veto']);
      tallyTotal=tallyNo+tallyYes+tallyAbstain+tallyNoWithVeto;
      //print(tallyNoWithVeto);
     // print(tallyYes);
      //print(tallyAbstain);
      //print(tallyNo);

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
    //print(propVoters);
    }
    if (resultDeposit.statusCode==200){
      Deposit=(jsonDecode(resultDeposit.body)[0]['amount']);
      DepositDenom=(jsonDecode(resultDeposit.body)[0]['denom']);
      //print(propVoters);
    }

  }
  void fun(){
    if(widget.proposalProduct.status=='PROPOSAL_STATUS_PASSED'){
      status='Passed';
    }
    else{
      status='Rejected';
    }
  }
  @override
  Widget build(BuildContext context) {
    fun();
    getData();
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
              // Container(
              //     width: MediaQuery.of(context).size.width/1.1,
              //     height: 40,
              //     decoration: kBoxDecorationWithoutGradient,
              //     margin: const EdgeInsets.all(20),
              //     child: Padding(
              //       padding: const EdgeInsets.all(2.0),
              //       child: TextField(
              //         //controller: nameController,
              //         decoration: InputDecoration(
              //           contentPadding: const EdgeInsets.only(left: 15, right: 15),
              //           filled: true,
              //           fillColor: Colors.transparent,
              //           focusedBorder: InputBorder.none,
              //           border: OutlineInputBorder(
              //               borderSide: const BorderSide(
              //                 width: 0,
              //                 style: BorderStyle.none,
              //               ),
              //               borderRadius: BorderRadius.circular(20)
              //           ),
              //           hintText: 'Search',
              //           prefixIcon: const Icon(Icons.search),
              //         ),
              //         onChanged: (text) {
              //           setState(() {
              //             //fullName = text;
              //             //you can access nameController in its scope to get
              //             // the value of text entered as shown below
              //             //fullName = nameController.text;
              //           });
              //         },
              //       ),
              //     )),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // ToggleButton(leftTitle: 'Summary',rightTitle: 'JSON',)
                  ],),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10,top: 10,left: 10),
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
                                      child: Text(status,
                                        style: kSmallTextStyle,),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Text(widget.proposalProduct.content!.title!,
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
                                Text('${removeAllChar(Deposit)} ${DepositDenom}'
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
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: SizedBox(
                                    width:100,
                                    height: 15,
                                    child: Text(widget.proposalProduct.proposalType!,
                                        style:kSmallBoldTextStyle),
                                  ),
                                ),
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
                        Text(widget.proposalProduct.content!.description!,
                            style:kSmallTextStyle),
                        const SizedBox(height: 20,),
                        Text('Parameter Change',
                            style:kSmallBoldTextStyle),
                        const SizedBox(height: 2,),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.all(5),decoration: kBoxBorder,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('deposit params:',
                                          style:kSmallTextStyle),
                                      Text('',
                                          style:kSmallTextStyle),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
                                      child: Text(status,
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
                        ],)


                      ]),
                ),
              ),
              Padding(
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
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Padding(
                        //     padding: const EdgeInsets.fromLTRB(8.0,0,8,8),
                        //     child: Card(
                        //         color: const Color(0xFFF9FAFC),
                        //         child: Padding(
                        //           padding: const EdgeInsets.all(8.0),
                        //           child: Column(
                        //             children: [
                        //               Row(
                        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //                 children:  [
                        //                   Text('Cosmostation',style: kSmallBoldTextStyle,),
                        //                   GreenContainer('Yes'),
                        //                 ],
                        //               ),
                        //               const SizedBox(height: 4,),
                        //               Row(
                        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //                 children: [
                        //                   Text('TxHash',style: kSmallTextStyle,),
                        //                   Text('0',style: kSmallTextStyle,)
                        //                 ],
                        //               ),
                        //               const SizedBox(height: 4,),
                        //               Row(
                        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //                 children: [
                        //                   Text('Time',style: kSmallTextStyle,),
                        //                   Text('Yesterday, 12:49 PM',style: kSmallTextStyle,)
                        //                 ],
                        //               ),
                        //             ],
                        //           ),
                        //         )),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Padding(
                        //     padding: const EdgeInsets.fromLTRB(8.0,0,8,8),
                        //     child: Card(
                        //         color: const Color(0xFFF9FAFC),
                        //         child: Padding(
                        //           padding: const EdgeInsets.all(8.0),
                        //           child: Column(
                        //             children: [
                        //               Row(
                        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //                 children:  [
                        //                   Text('1hgyfyf..jhyf9',style: kSmallBoldTextStyle,),
                        //                   GreenContainer('Yes'),
                        //                 ],
                        //               ),
                        //               const SizedBox(height: 4,),
                        //               Row(
                        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //                 children: [
                        //                   Text('TxHash',style: kSmallTextStyle,),
                        //                   Text('0',style: kSmallTextStyle,)
                        //                 ],
                        //               ),
                        //               const SizedBox(height: 4,),
                        //               Row(
                        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //                 children: [
                        //                   Text('Time',style: kSmallTextStyle,),
                        //                   Text('Yesterday, 12:49 PM',style: kSmallTextStyle,)
                        //                 ],
                        //               ),
                        //             ],
                        //           ),
                        //         )),
                        //   ),
                        // ),

                      ]
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(18.0,0,18,18),
              //   child: Container(
              //     decoration: kBoxDecorationWithoutGradient,
              //
              //     child: Column(
              //         children:[
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Padding(
              //                 padding: const EdgeInsets.all(18.0),
              //                 child: Text('Validator Votes',style: kSmallBoldTextStyle,),
              //               ),
              //               const Filter(),
              //             ],
              //           ),
              //
              //           Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Padding(
              //               padding: const EdgeInsets.fromLTRB(8.0,0,8,8),
              //               child: Card(
              //                   color: const Color(0xFFF9FAFC),
              //                   child: Padding(
              //                     padding: const EdgeInsets.all(8.0),
              //                     child: Column(
              //                       children: [
              //                         Row(
              //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                           children:  [
              //                             Row(
              //                               children: [
              //
              //                                 Padding(
              //                                   padding: const EdgeInsets.fromLTRB(0,0,8,0),
              //                                   child: CircleAvatar(
              //                                     radius: 12,
              //                                       backgroundColor:Colors.transparent,
              //                                       child:ClipOval(child: Image.asset('assets/images/auditor.png'))),
              //                                 ),
              //                         Text('Auditor.one',style: kSmallBoldTextStyle,)
              //                               ],
              //                             ),
              //
              //                             GreenContainer('Yes'),
              //                           ],
              //                         ),
              //                         const SizedBox(height: 8),
              //                         Row(
              //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                           children: [
              //                             Text('TxHash',style: kSmallTextStyle,),
              //                             Text('D0123NK..IU234VC',style: kSmallBoldTextStyle,)
              //                           ],
              //                         ),
              //                         const SizedBox(height: 4,),
              //                         Row(
              //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                           children: [
              //                             Text('Time',style: kSmallTextStyle,),
              //                             Text('Yesterday, 12:49 PM',style: kSmallTextStyle,)
              //                           ],
              //                         ),
              //                       ],
              //                     ),
              //                   )),
              //             ),
              //           ),
              //           Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Padding(
              //               padding: const EdgeInsets.fromLTRB(8.0,0,8,8),
              //               child: Card(
              //                   color: const Color(0xFFF9FAFC),
              //                   child: Padding(
              //                     padding: const EdgeInsets.all(8.0),
              //                     child: Column(
              //                       children: [
              //                         Row(
              //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                           children:  [
              //                             Row(
              //                               children: [
              //
              //                                 Padding(
              //                                   padding: const EdgeInsets.fromLTRB(0,0,8,0),
              //                                   child: CircleAvatar(
              //                                       radius: 12,
              //                                       backgroundColor:Colors.transparent,
              //                                       child:ClipOval(child: Image.asset('assets/images/auditor.png'))),
              //                                 ),
              //                                 Text('Cosmostation',style: kSmallBoldTextStyle,)
              //                               ],
              //                             ),
              //
              //                             GreenContainer('Yes'),
              //                           ],
              //                         ),
              //                         const SizedBox(height: 8),
              //                         Row(
              //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                           children: [
              //                             Text('TxHash',style: kSmallTextStyle,),
              //                             Text('D0123NK..IU234VC',style: kSmallBoldTextStyle,)
              //                           ],
              //                         ),
              //                         const SizedBox(height: 4,),
              //                         Row(
              //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                           children: [
              //                             Text('Time',style: kSmallTextStyle,),
              //                             Text('Yesterday, 12:49 PM',style: kSmallTextStyle,)
              //                           ],
              //                         ),
              //                       ],
              //                     ),
              //                   )),
              //             ),
              //           ),
              //            Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Padding(
              //               padding: const EdgeInsets.fromLTRB(8.0,0,8,8),
              //               child: Card(
              //                   color: const Color(0xFFF9FAFC),
              //                   child: Padding(
              //                     padding: const EdgeInsets.all(8.0),
              //                     child: Column(
              //                       children: [
              //                         Row(
              //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                           children:  [
              //                             Row(
              //                               children: [
              //
              //                                 Padding(
              //                                   padding: const EdgeInsets.fromLTRB(0,0,8,0),
              //                                   child: CircleAvatar(
              //                                       radius: 12,
              //                                       backgroundColor:Colors.transparent,
              //                                       child:ClipOval(child: Image.asset('assets/images/auditor.png'))),
              //                                 ),
              //                                 Text('Caps',style: kSmallBoldTextStyle,)
              //                               ],
              //                             ),
              //                             GreenContainer('Yes'),
              //                           ],
              //                         ),
              //                         const SizedBox(height: 8),
              //                         Row(
              //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                           children: [
              //                             Text('TxHash',style: kSmallTextStyle,),
              //                             Text('D0123NK..IU234VC',style: kSmallBoldTextStyle,)
              //                           ],
              //                         ),
              //                         const SizedBox(height: 4,),
              //                         Row(
              //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                           children: [
              //                             Text('Time',style: kSmallTextStyle,),
              //                             Text('Yesterday, 12:49 PM',style: kSmallTextStyle,)
              //                           ],
              //                         ),
              //                       ],
              //                     ),
              //                   )),
              //             ),
              //           ),
              //         ]
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(18.0,0,18,18),
              //   child: Container(
              //     decoration: kBoxDecorationWithoutGradient,
              //
              //     child: Column(
              //         children:[
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Padding(
              //                 padding: const EdgeInsets.all(18.0),
              //                 child: Text('Depositors',style: kSmallBoldTextStyle,),
              //               ),
              //               const Filter(),
              //             ],
              //           ),
              //
              //           Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Padding(
              //               padding: const EdgeInsets.fromLTRB(8.0,0,8,8),
              //               child: Card(
              //                   color: const Color(0xFFF9FAFC),
              //                   child: Padding(
              //                     padding: const EdgeInsets.all(8.0),
              //                     child: Column(
              //                       children: [
              //                         Row(
              //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                           children:  [
              //                             Text('SycScale.com',style: kSmallBoldTextStyle,),
              //                           ],
              //                         ),
              //                         const SizedBox(height: 8),
              //                         Row(
              //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                           children: [
              //                             Text('TxHash',style: kSmallTextStyle,),
              //                             Text('D0123NK..IU234VC',style: kSmallBoldTextStyle,)
              //                           ],
              //                         ),
              //                         const SizedBox(height: 4,),
              //                         Row(
              //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                           children: [
              //                             Text('Time',style: kSmallTextStyle,),
              //                             Text('Yesterday, 12:49 PM',style: kSmallTextStyle,)
              //                           ],
              //                         ),
              //                       ],
              //                     ),
              //                   )),
              //             ),
              //           ),
              //           Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Padding(
              //               padding: const EdgeInsets.fromLTRB(8.0,0,8,8),
              //               child: Card(
              //                   color: const Color(0xFFF9FAFC),
              //                   child: Padding(
              //                     padding: const EdgeInsets.all(8.0),
              //                     child: Column(
              //                       children: [
              //                         Row(
              //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                           children:  [
              //                             Text('SycScale.com',style: kSmallBoldTextStyle,),
              //                           ],
              //                         ),
              //                         const SizedBox(height: 8),
              //                         Row(
              //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                           children: [
              //                             Text('TxHash',style: kSmallTextStyle,),
              //                             Text('D0123NK..IU234VC',style: kSmallBoldTextStyle,)
              //                           ],
              //                         ),
              //                         const SizedBox(height: 4,),
              //                         Row(
              //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                           children: [
              //                             Text('Time',style: kSmallTextStyle,),
              //                             Text('Yesterday, 12:49 PM',style: kSmallTextStyle,)
              //                           ],
              //                         ),
              //                       ],
              //                     ),
              //                   )),
              //             ),
              //           ),
              //         ]
              //     ),
              //   ),
              // ),

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
                      Text(dotRefactorFunction(proposalVotesModel!.validatorAddress!),style: kSmallBoldTextStyle,)
                    ],
                  ),
                  const SizedBox(height: 4,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Time',style: kSmallTextStyle,),
                      Text('Yesterday, 12:49 PM',style: kSmallTextStyle,)
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
