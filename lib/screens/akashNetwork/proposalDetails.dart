import 'package:flutter/material.dart';
import 'package:zenscape_app/widgets/filterTab.dart';

import '../../Constants/constants.dart';
import '../../widgets/onboardingwidgets/toggleButton.dart';

class ProposalDetails extends StatefulWidget {
  const ProposalDetails({Key? key}) : super(key: key);

  @override
  State<ProposalDetails> createState() => _ProposalDetailsState();
}

class _ProposalDetailsState extends State<ProposalDetails> {
  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Column(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width/1.1,
                  height: 40,
                  decoration: kBoxDecorationWithoutGradient,
                  margin: const EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextField(
                      //controller: nameController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 15, right: 15),
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
                        hintText: 'Search',
                        prefixIcon: const Icon(Icons.search),
                      ),
                      onChanged: (text) {
                        setState(() {
                          //fullName = text;
                          //you can access nameController in its scope to get
                          // the value of text entered as shown below
                          //fullName = nameController.text;
                        });
                      },
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ToggleButton(leftTitle: 'Summary',rightTitle: 'JSON',)
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
                      children:  <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: kBoxDecorationWithoutGradient,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text('#6',
                                    style:kMediumBoldTextStyle),
                              ),
                            ),
                            Container(
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
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text('Passed',
                                        style: kSmallTextStyle,),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Text('Update the minimum deposit for governance proposals',
                            style:kSmallTextStyle),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Proposers',
                                    style:kSmallTextStyle),
                                Text('Synscale.com',
                                    style:kSmallBoldTextStyle),
                                const SizedBox(height: 20,),

                                Text('Total Deposit',
                                    style:kSmallTextStyle),
                                Text('100.000000 CMDX',
                                    style:kSmallBoldTextStyle),
                                const SizedBox(height: 20,),

                                Text('Voting End',
                                    style:kSmallTextStyle),
                                Text('2022-07-15 22:52:55',
                                    style:kSmallBoldTextStyle),
                                const SizedBox(height: 20,),

                                Text('Submit Time',
                                    style:kSmallTextStyle),
                                Text('2022-07-15 22:52:55',
                                    style:kSmallBoldTextStyle),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Initial Deposit',
                                    style:kSmallTextStyle),
                                Text('0.000000 CMDX',
                                    style:kSmallBoldTextStyle),
                                const SizedBox(height: 20,),

                                Text('Voting Start',
                                    style:kSmallTextStyle),
                                Text('0.000000 CMDX',
                                    style:kSmallBoldTextStyle),
                                const SizedBox(height: 20,),

                                Text('Type',
                                    style:kSmallTextStyle),
                                Text('Parameter Change',
                                    style:kSmallBoldTextStyle),
                                const SizedBox(height: 20,),

                                Text('Deposit End Time',
                                    style:kSmallTextStyle),
                                Text('Parameter Change',
                                    style:kSmallBoldTextStyle),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Text('Details ',
                            style:kSmallBoldTextStyle),
                        const SizedBox(height: 2,),
                        Text('Update the minimum deposit for governance proposals. Discussion Forum Link : https://forum.comdex.one/t/proposal-increasing-deposit-amount-minimum-transaction-fee-for-comdex-chain/343 .<br/>By voting YES, you agree to update the minimum deposit as per the proposal raised. <br/> By voting NO, you disagree to update the minimum deposit as per the proposal raised',
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
                                      Text('min deposit : 30000000 CMDX',
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
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text('Passed',
                                        style: kExtraSmallTextStyle,),
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
                              Text('99.08%',
                              style:kSmallBoldTextStyle),
                              Text('51,334,682.826751 CMDX',
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
                                Text('0.00%',
                                    style:kSmallBoldTextStyle),
                                Text('1,159.427282 CMDX',
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
                                Text('0.00%',
                                    style:kSmallBoldTextStyle),
                                Text('0000000 CMDX',
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
                                Text('0.02%',
                                    style:kSmallBoldTextStyle),
                                Text('10,064.526492 CMDX',
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
                            const Filter(),
                          ],
                        ),

                        Padding(
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
                                          Text('1hgyfyf..jhyf9',style: kSmallBoldTextStyle,),
                                          GreenContainer('Yes'),
                                        ],
                                      ),
                                      const SizedBox(height: 4,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('TxHash',style: kSmallTextStyle,),
                                          Text('D0123NK..IU234VC',style: kSmallBoldTextStyle,)
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
                        ),
                        Padding(
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
                                          Text('Cosmostation',style: kSmallBoldTextStyle,),
                                          GreenContainer('Yes'),
                                        ],
                                      ),
                                      const SizedBox(height: 4,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('TxHash',style: kSmallTextStyle,),
                                          Text('0',style: kSmallTextStyle,)
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
                        ),
                        Padding(
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
                                          Text('1hgyfyf..jhyf9',style: kSmallBoldTextStyle,),
                                          GreenContainer('Yes'),
                                        ],
                                      ),
                                      const SizedBox(height: 4,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('TxHash',style: kSmallTextStyle,),
                                          Text('0',style: kSmallTextStyle,)
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
                        ),

                      ]
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0,0,18,18),
                child: Container(
                  decoration: kBoxDecorationWithoutGradient,

                  child: Column(
                      children:[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Text('Validator Votes',style: kSmallBoldTextStyle,),
                            ),
                            const Filter(),
                          ],
                        ),

                        Padding(
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
                                          Row(
                                            children: [

                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0,0,8,0),
                                                child: CircleAvatar(
                                                  radius: 12,
                                                    backgroundColor:Colors.transparent,
                                                    child:ClipOval(child: Image.asset('assets/images/auditor.png'))),
                                              ),
                                      Text('Auditor.one',style: kSmallBoldTextStyle,)
                                            ],
                                          ),

                                          GreenContainer('Yes'),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('TxHash',style: kSmallTextStyle,),
                                          Text('D0123NK..IU234VC',style: kSmallBoldTextStyle,)
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
                        ),
                        Padding(
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
                                          Row(
                                            children: [

                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0,0,8,0),
                                                child: CircleAvatar(
                                                    radius: 12,
                                                    backgroundColor:Colors.transparent,
                                                    child:ClipOval(child: Image.asset('assets/images/auditor.png'))),
                                              ),
                                              Text('Cosmostation',style: kSmallBoldTextStyle,)
                                            ],
                                          ),

                                          GreenContainer('Yes'),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('TxHash',style: kSmallTextStyle,),
                                          Text('D0123NK..IU234VC',style: kSmallBoldTextStyle,)
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
                        ),
                         Padding(
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
                                          Row(
                                            children: [

                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0,0,8,0),
                                                child: CircleAvatar(
                                                    radius: 12,
                                                    backgroundColor:Colors.transparent,
                                                    child:ClipOval(child: Image.asset('assets/images/auditor.png'))),
                                              ),
                                              Text('Caps',style: kSmallBoldTextStyle,)
                                            ],
                                          ),
                                          GreenContainer('Yes'),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('TxHash',style: kSmallTextStyle,),
                                          Text('D0123NK..IU234VC',style: kSmallBoldTextStyle,)
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
                        ),
                      ]
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0,0,18,18),
                child: Container(
                  decoration: kBoxDecorationWithoutGradient,

                  child: Column(
                      children:[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Text('Depositors',style: kSmallBoldTextStyle,),
                            ),
                            const Filter(),
                          ],
                        ),

                        Padding(
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
                                          Text('SycScale.com',style: kSmallBoldTextStyle,),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('TxHash',style: kSmallTextStyle,),
                                          Text('D0123NK..IU234VC',style: kSmallBoldTextStyle,)
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
                        ),
                        Padding(
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
                                          Text('SycScale.com',style: kSmallBoldTextStyle,),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('TxHash',style: kSmallTextStyle,),
                                          Text('D0123NK..IU234VC',style: kSmallBoldTextStyle,)
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
                        ),
                      ]
                  ),
                ),
              ),

            ]
        ),

      ),
    );
  }
}
