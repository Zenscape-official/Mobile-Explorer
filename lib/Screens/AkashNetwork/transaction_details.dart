import 'package:flutter/material.dart';
import 'package:zenscape_app/widgets/ToggleButton.dart';

import '../../Constants/constants.dart';
class TxDetails extends StatefulWidget {
  const TxDetails({Key? key}) : super(key: key);

  @override
  State<TxDetails> createState() => _TxDetailsState();
}

class _TxDetailsState extends State<TxDetails> {
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
              'Transaction Details',
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
                decoration: kBoxDecorationWithGradient,
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
                      hintText: 'Select a chain',
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
                          Text('Information',
                          style:kMediumBoldTextStyle),
                      const SizedBox(height: 20,),
                      Text('Chain Id',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text('comdex-1',
                          style:kMediumBoldTextStyle),
                      const SizedBox(height: 20,),
                      Text('TxHash',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text('B26590478E47C347EEE988CF8AB2B3544FF23AC8D1FE6E2B8732D3CF3B3A15E4',
                          style:kMediumBoldTextStyle),
                      const SizedBox(height: 20,),
                      Text('Status',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text('Success',
                          style:kMediumBoldTextStyle),
                      const SizedBox(height: 20,),
                      Text('Height',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text('3,123,456',
                          style:kMediumBoldTextStyle),
                      const SizedBox(height: 20,),
                      Text('Time',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text('10m ago ( 2022-08-10 21:35:19 )',
                          style:kMediumBoldTextStyle),
                      const SizedBox(height: 20,),
                      Text('Fee',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text('0.002374 CMDX',
                          style:kMediumBoldTextStyle),
                      const SizedBox(height: 20,),
                      Text('Gas (used/wanted)',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text('400,576 / 474,648',
                          style:kMediumBoldTextStyle),
                      const SizedBox(height: 20,),
                      Text('Memo',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text('relayed by CryptoCrew Validators | hermes 0.15.0 (https://hermes.informal.systems)',
                          style:kMediumBoldTextStyle),
                      const SizedBox(height: 20,),
                      Text('Signer',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text('comdex1yvejj22t78s2vfk7slty2d7fs5lkc8rn5ynsut',
                          style:kMediumBoldTextStyle),
                      const SizedBox(height: 20,),
                      Text('Client ID',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text('07-tendermint-30',
                          style:kMediumBoldTextStyle),
                      const SizedBox(height: 20,),
                      Text('Block',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text('11',
                          style:kMediumBoldTextStyle),
                      const SizedBox(height: 20,),
                      Text('App',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text('0',
                          style:kMediumBoldTextStyle),
                      const SizedBox(height: 20,),
                      Text('Client ID',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text('juno_1',
                          style:kMediumBoldTextStyle),
                      const SizedBox(height: 20,),
                      Text('Height',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text('4,306,629',
                          style:kMediumBoldTextStyle),
                      const SizedBox(height: 20,),
                      Text('Time',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text('2022-08-10T16:04:58.767763617Z',
                          style:kMediumBoldTextStyle),
                      const SizedBox(height: 20,),
                      Text('Hash',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text('Kk+EyKoF348cCtRU6BEm5fItHaE1IF8AfYz/OSE+1I=',
                          style:kMediumBoldTextStyle),
                      const SizedBox(height: 20,),
                      Text('Total',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text('1',
                          style:kMediumBoldTextStyle),
                      const SizedBox(height: 20,),
                      Text('Last Commit Hash',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text('BrqdCEv8NHBvpl0a5zllxrHyFmS/5ZYx+E9BjhJlL2g=',
                          style:kMediumBoldTextStyle),
                      const SizedBox(height: 20,),
                      Text('Data Hash',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text('BrqdCEv8NHBvpl0a5zllxrHyFmS/5ZYx+E9BjhJlL2g=',
                          style:kMediumBoldTextStyle),
                      const SizedBox(height: 20,),
                      Text('Validator Hash',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text('BrqdCEv8NHBvpl0a5zllxrHyFmS/5ZYx+E9BjhJlL2g=',
                          style:kMediumBoldTextStyle),
                      const SizedBox(height: 20,),
                      Text('Next Validator Hash',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text('BrqdCEv8NHBvpl0a5zllxrHyFmS/5ZYx+E9BjhJlL2g=',
                          style:kMediumBoldTextStyle),
                      const SizedBox(height: 20,),
                      Text('Consensus Hash',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text('BrqdCEv8NHBvpl0a5zllxrHyFmS/5ZYx+E9BjhJlL2g=',
                          style:kMediumBoldTextStyle),
                      const SizedBox(height: 20,),
                      Text('App Hash',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text('BrqdCEv8NHBvpl0a5zllxrHyFmS/5ZYx+E9BjhJlL2g=',
                          style:kMediumBoldTextStyle),
                      const SizedBox(height: 20,),
                      Text('Last Result Hash',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text('BrqdCEv8NHBvpl0a5zllxrHyFmS/5ZYx+E9BjhJlL2g=',
                          style:kMediumBoldTextStyle),
                      const SizedBox(height: 20,),
                      Text('Evidence Hash',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text('BrqdCEv8NHBvpl0a5zllxrHyFmS/5ZYx+E9BjhJlL2g=',
                          style:kMediumBoldTextStyle),
                      const SizedBox(height: 20,),
                      Text('Proposer Address',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text('BrqdCEv8NHBvpl0a5zllxrHyFmS/5ZYx+E9BjhJlL2g=',
                          style:kMediumBoldTextStyle),

                    ]),
              ),
            ),
            Container(margin: const EdgeInsets.only(right: 10,top: 10,left: 10),

              width: MediaQuery.of(context).size.width/1.1,
              decoration: kBoxDecorationWithGradient,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  <Widget>[
                     Text ('Information',
                    style:kMediumBoldTextStyle),
                  const SizedBox(height: 20,),
                  Text('IBC Acknowledgement',
                      style:kMediumBoldTextStyle ),
                  const SizedBox(height: 20,),
                  Text('Sequence',
                      style:kSmallTextStyle),
                  const SizedBox(height: 2,),
                      Text('5122',
                          style:kMediumBoldTextStyle ),
                      const SizedBox(height: 20,),
                      Text('Amount',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text('72.33 CMDX',
                          style:kMediumBoldTextStyle ),
                      const SizedBox(height: 20,),
                      Text('Origin Amount',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text('72,343,094',
                          style:kMediumBoldTextStyle ),
                      const SizedBox(height: 20,),
                      Text('Origin Denom',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text('ucmdx',
                          style:kMediumBoldTextStyle ),
                      const SizedBox(height: 20,),
                      Text('Reciever',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text('junohguyty6tr654667tugujijhoiyiyhukbgjkjiuj',
                          style:kMediumBoldTextStyle ),
                      const SizedBox(height: 20,),
                      Text('Sender',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text('Kk+EyKoF348cCtRU6BEm5fItHaE1IF8AfYz/OSE+1I=',
                          style:kMediumBoldTextStyle ),
                      const SizedBox(height: 20,),
                      Text('Source Port',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text('Transfer',
                          style:kMediumBoldTextStyle ),
                      const SizedBox(height: 20,),
                      Text('Source Channel',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text('channel-18',
                          style:kMediumBoldTextStyle ),
                      const SizedBox(height: 20,),
                      Text('Destination Port',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text('Transfer',
                          style:kMediumBoldTextStyle ),
                      const SizedBox(height: 20,),
                      Text('Destination Channel',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text('Channel-36',
                          style:kMediumBoldTextStyle ),
                      const SizedBox(height: 20,),
                      Text('Signer',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text('comdexESZwv+vBBk98dXYnzVGyz2gpB59Aycml0zWo=',
                          style:kMediumBoldTextStyle ),
                      const SizedBox(height: 20,),
                      Text('Effected',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text('0',
                          style:kMediumBoldTextStyle ),


                    ]),)),
            Container(margin: const EdgeInsets.only(right: 10,top: 10,left: 10),

                width: MediaQuery.of(context).size.width/1.1,
                decoration: kBoxDecorationWithGradient,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text('IBC Progress',
                    style:kMediumBoldTextStyle),
                      SizedBox(height:30),
                    Column(
                      children: [Row(
                        children: [
                          Text(''),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              Text('Transfer'),
                              SizedBox(height:10),
                              Container(
                                decoration: BoxDecoration (
                                  border: Border.all(
                                    color: Colors.lightGreenAccent,
                                    width: 1.0,
                                  ),
                                  color: Colors.lightGreenAccent.withOpacity(.1),
                                  borderRadius: const BorderRadius.all(Radius.circular(15.0),

                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.lightGreenAccent.withOpacity(.05),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: const Offset(-2, -2), // changes position of shadow
                                    ),],),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(12,2,12,2.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('COMDEX',
                                            style:kMediumBoldTextStyle),
                                        SizedBox(height: 5,),
                                        Text('CA07HYYGYG12....12334HGGVGG',
                                            style:kSmallTextStyle),
                                        SizedBox(height: 5,),

                                        Text('2h ago (2022-08-10 21:34:42)',
                                            style:kSmallTextStyle),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20,),
                              Text('Reciever'),
                              SizedBox(height:10),
                              Container(
                                decoration: BoxDecoration (
                                  border: Border.all(
                                    color: Colors.lightGreenAccent,
                                    width: 1.0,
                                  ),
                                  color: Colors.lightGreenAccent.withOpacity(.1),
                                  borderRadius: const BorderRadius.all(Radius.circular(15.0),

                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(.05),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: const Offset(-2, -2), // changes position of shadow
                                    ),],),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(12,2,12,2.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('JUNO',
                                            style:kMediumBoldTextStyle),
                                        SizedBox(height: 5,),
                                        Text('CA07HYYGYG12....12334HGGVGG',
                                            style:kSmallTextStyle),
                                        SizedBox(height: 5,),

                                        Text('2h ago (2022-08-10 21:34:42)',
                                            style:kSmallTextStyle),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height:20),
                              Text('Acknowledgement'),
                              SizedBox(height:10),
                              Container(
                                decoration: BoxDecoration (
                                  border: Border.all(
                                    color: Colors.lightGreenAccent,
                                    width: 1.0,
                                  ),
                                  color: Colors.lightGreenAccent.withOpacity(.1),
                                  borderRadius: const BorderRadius.all(Radius.circular(15.0),

                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(.05),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: const Offset(-2, -2), // changes position of shadow
                                    ),],),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(12,2,12,2.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('COMDEX',
                                            style:kMediumBoldTextStyle),
                                        SizedBox(height: 5,),
                                        Text('CA07HYYGYG12....12334HGGVGG',
                                            style:kSmallTextStyle),
                                        SizedBox(height: 5,),
                                        Text('2h ago (2022-08-10 21:34:42)',
                                            style:kSmallTextStyle),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ]
                          )
                        ],
                      )],
                    ),
                  ],)))
              ]
              ),

      ),
    );
  }
}
