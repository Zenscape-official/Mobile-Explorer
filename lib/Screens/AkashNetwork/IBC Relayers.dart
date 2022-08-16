import 'package:flutter/material.dart';

import '../../Constants/constants.dart';
import '../../widgets/NavigationDrawerWidget.dart';

class IBCRelayers extends StatefulWidget {
  const IBCRelayers({Key? key}) : super(key: key);

  @override
  State<IBCRelayers> createState() => _IBCRelayersState();
}

class _IBCRelayersState extends State<IBCRelayers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        foregroundColor: Colors.black,
        titleTextStyle: const TextStyle(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('IBC RELAYERS',
                style:kBigBoldTextStyle),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            ListView.builder(
                reverse: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) {
                  return
                    Container(
                      decoration: kBoxDecorationWithGradient,
                      margin: const EdgeInsets.all(14),
                      child: Column(
                          children:[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children:[
                                    Row(
                                      children: [
                                        CircleAvatar(radius:15,backgroundColor: Colors.transparent,child: Image.asset('assets/images/Kava.png',)),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('KAVA ',
                                              style:kMediumBoldTextStyle),
                                        ),],
                                    ),

                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.lightGreenAccent.withOpacity(.1),
                                        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                        border: Border.all(
                                          color:  const Color(0xFF6BD68D),
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(8,1.0,8,1),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const CircleAvatar(backgroundColor: Colors.green,
                                              radius: 3,),
                                            Padding(
                                              padding: const EdgeInsets.all(2.0),
                                              child: Text('Opened',
                                                style: kSmallTextStyle,),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ]
                              ),

                            ),
                            const SizedBox(height: 5,),

                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,

                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: kGradientColor,
                                      borderRadius: const BorderRadius.all(Radius.circular(60.0)),
                                      border: Border.all(
                                        color:  Colors.lightBlueAccent,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(8,1.0,8,1),
                                      child: Row(
                                        children:[
                                          Row(
                                            children: [
                                              CircleAvatar(child: Image.asset('assets/images/Kava.png'),),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,


                                                  children: [
                                                    Text(' Cosmos',
                                                      style: kMediumBoldTextStyle,),
                                                    Text(' channel-227',
                                                      style: kSmallTextStyle,),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Divider(color: Colors.lightBlueAccent,height: 2,thickness: 2,),
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: kGradientColor,
                                      borderRadius: const BorderRadius.all(Radius.circular(60.0)),
                                      border: Border.all(
                                        color:  Colors.lightBlueAccent,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(8,1.0,8,1),
                                      child: Row(
                                        children:[
                                          Row(
                                            children: [
                                              CircleAvatar(child: Image.asset('assets/images/Kava.png'),),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,


                                                  children: [
                                                    Text(' Cosmos',
                                                      style: kMediumBoldTextStyle,),
                                                    Text(' channel-227',
                                                      style: kSmallTextStyle,),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            SizedBox(height:10),

                            Padding(
                              padding: const EdgeInsets.fromLTRB(8,2,8,2),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children:[
                                    Text('Operational Period',
                                        style:kSmallTextStyle),
                                    Text('184 Days',
                                        style:kSmallBoldTextStyle)
                                  ]
                              ),

                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8,2,8,2),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('24 Txs',
                                        style:kSmallTextStyle),
                                    Text('110',
                                        style:kSmallBoldTextStyle)
                                  ]
                              ),

                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8,2,8,8),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('24h Value',
                                        style:kSmallTextStyle),
                                    Text('\$146,987,655',
                                        style:kSmallBoldTextStyle)
                                  ]
                              ),
                            ),
                          ]
                      ),
                    );
                }),
          ],
        ),
      ),
    );
  }
}
