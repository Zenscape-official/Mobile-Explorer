import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:zenscape_app/Constants/constants.dart';
import '../../widgets/NavigationDrawerWidget.dart';
import '../home_screen.dart';
class NetworkDashBoard extends StatelessWidget {
  List<String> par=['Height','Transactions','Bonded Tokens','Community Pools','Inflation','Staking APR'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text('AKASH',
            style: TextStyle(
              fontWeight: FontWeight.w900,
                fontFamily: 'Montserrat'
            ),),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            Container(
              height: MediaQuery.of(context).size.height/2.4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                 // height:MediaQuery.of(context).size.height/1.2,
                  decoration: kBoxDecorationWithGradient,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(child: Image.asset('assets/images/akt.png'),
                                    backgroundColor: Colors.transparent),
                                Text(' AKT',
                                  style: TextStyle(color: Colors.black.withOpacity(1),
                                      fontSize: 25,
                                      fontFamily: 'Montserrat'
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.access_time,
                                    color:Colors.blue),
                                const SizedBox(width: 2,),
                                Text('BLOCK TIME',
                                    style: TextStyle(color: Colors.black.withOpacity(1),
                                      fontSize: 11,
                                    )
                                ),
                                Text('  6,079ms',
                                    style: TextStyle(color: Colors.black.withOpacity(1),
                                      fontSize: 12,
                                    )
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: const BorderRadius.all(Radius.circular(200.0)),
                            border: Border.all(
                              color: Colors.lightBlueAccent.withOpacity(.3),
                              width: 1.0,
                            ),
                          ),
                          child:Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: (
                                Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: const BorderRadius.all(Radius.circular(200.0)),
                              border: Border.all(
                                color: Colors.lightBlueAccent.withOpacity(.5),
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(25.0),
                                  child:Column(
                                    children: const [
                                      Text('\$0.23',
                                          style: kBigTextStyle),
                                      SizedBox(height: 4,),
                                      Text('+4.29%',
                                          style:kSmallTextStyle
                                      ),
                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: const BorderRadius.all(Radius.circular(250.0)),
                                    border: Border.all(
                                      color: Colors.lightBlueAccent,
                                      width: 1.0,
                                    ),
                              ),
                              ),
                            ),)
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text('Market Cap',
                                    style: kMediumTextStyle,),
                                  SizedBox(height: 4,),
                                  Text('\$44,460,560.56',
                                    style: kMediumTextStyle,)
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text('24h Vol',
                                    style: kMediumTextStyle,),
                                  Text('\$1,478,971.56',
                                    style: kMediumTextStyle,)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: StaggeredGridView.countBuilder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 12,
                  itemCount: par.length,
                  itemBuilder: (context,index){
                    return InfoCard(title1: par[index],icon1: Icons.manage_accounts_rounded,titleValue1: '8734872');
                  },
                  staggeredTileBuilder: (index) => StaggeredTile.fit(1)),
            ),
          Divider(color: Colors.lightBlueAccent.withOpacity(1),),
          Padding(
               padding: const EdgeInsets.fromLTRB(18,0,18,18),
               child: Container(
                   width:MediaQuery.of(context).size.width/1.1,
                   decoration: kBoxDecorationWithoutGradient,
                   child:Padding(
                 padding: const EdgeInsets.all(14.0),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: const [
                     Icon(Icons.how_to_vote_outlined),
                     SizedBox(height: 6),
                     Text('Voting Power',
                       style: kSmallTextStyle,),
                     SizedBox(height: 3),
                     Text('3/4',
                       style: kBigTextStyle,)
                   ],
                 ),
               )),
             ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18.0,0,18,18),
              child: Container(
                width:MediaQuery.of(context).size.width/1.1,
                decoration: kBoxDecorationWithoutGradient,
                child: Column(
                  children:[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Blocks',
                            style: kSmallTextStyle,),
                        ),
                      TextButton(onPressed: null, child: Text('See more'),
                      ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                        Card(
                            color: Colors.blueGrey.shade50,
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text('3446709',style: kSmallTextStyle,),
                                  Text('10s Ago',style: kSmallTextStyle,)
                                ],
                              ),
                              const SizedBox(height: 4,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text('Txs',style: kSmallTextStyle,),
                                  Text('0',style: kSmallTextStyle,)
                                ],
                              ),
                              const SizedBox(height: 4,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
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
                        padding: const EdgeInsets.all(8.0),
                        child:
                        Card(
                            color: Colors.blueGrey.shade50,
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text('3446709',style: kSmallTextStyle,),
                                  Text('10s Ago',style: kSmallTextStyle,)
                                ],
                              ),
                              const SizedBox(height: 4,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text('Txs',style: kSmallTextStyle,),
                                  Text('0',style: kSmallTextStyle,)
                                ],
                              ),
                              const SizedBox(height: 4,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
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
              padding: const EdgeInsets.fromLTRB(18.0,0,18,50),
              child: Container(
                decoration: kBoxDecorationWithoutGradient,

                child: Column(
                    children:[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Transaction',style: kSmallTextStyle,),
                          ),
                          TextButton(onPressed: null, child: Text('See more'),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                          Card(
                              color: Colors.blueGrey.shade50,
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text('3446709',style: kSmallTextStyle,),
                                    Text('10s Ago',style: kSmallTextStyle,)
                                  ],
                                ),
                                const SizedBox(height: 4,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text('Txs',style: kSmallTextStyle,),
                                    Text('0',style: kSmallTextStyle,)
                                  ],
                                ),
                                const SizedBox(height: 4,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text('Time',style: kSmallTextStyle,),
                                    Text('Yesterday, 12:49 PM',style: kSmallTextStyle,)
                                  ],
                                ),
                              ],
                            ),
                          )),
                        ),
                      ),Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                          Card(
                              color: Colors.blueGrey.shade50,
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text('3446709',style: kSmallTextStyle,),
                                    Text('10s Ago',style: kSmallTextStyle,)
                                  ],
                                ),
                                const SizedBox(height: 4,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text('Txs',style: kSmallTextStyle,),
                                    Text('0',style: kSmallTextStyle,)
                                  ],
                                ),
                                const SizedBox(height: 4,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const [
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
          ],
        ),
      ),
    );
  }
}
