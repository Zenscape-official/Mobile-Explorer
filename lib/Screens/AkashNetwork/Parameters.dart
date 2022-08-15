import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../Constants/constants.dart';
import '../../widgets/NavigationDrawerWidget.dart';
import '../home_screen.dart';
class Parameters extends StatefulWidget {
  const Parameters({Key? key}) : super(key: key);

  @override
  State<Parameters> createState() => _ParametersState();
}

class _ParametersState extends State<Parameters> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text('PARAMETERS',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Montserrat'
              ),),
          ],
        ),
      ),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        children: <Widget>[

          // SizedBox(
          //   height: MediaQuery.of(context).size.height/2.4,
          //   child: Padding(
          //     padding: const EdgeInsets.all(16.0),
          //     child: Container(
          //       decoration: kBoxDecorationWithGradient,
          //       child: Padding(
          //         padding: const EdgeInsets.all(16.0),
          //         child: Column(
          //           children: [
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 Row(
          //                   children: [
          //                     CircleAvatar(child: Image.asset('assets/images/akt.png'),
          //                         backgroundColor: Colors.transparent),
          //                     Text(' AKT',
          //                       style: TextStyle(color: Colors.black.withOpacity(1),
          //                           fontSize: 25,
          //                           fontFamily: 'Montserrat'
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //                 Row(
          //                   children: [
          //                     const Icon(Icons.access_time,
          //                         color:Colors.blue),
          //                     const SizedBox(width: 2,),
          //                     Text('BLOCK TIME',
          //                         style: TextStyle(color: Colors.black.withOpacity(1),
          //                           fontSize: 11,
          //                         )
          //                     ),
          //                     Text('  6,079ms',
          //                         style: TextStyle(color: Colors.black.withOpacity(1),
          //                           fontSize: 12,
          //                         )
          //                     ),
          //                   ],
          //                 ),
          //               ],
          //             ),
          //             const SizedBox(height: 20,),
          //             Container(
          //               decoration: BoxDecoration(
          //                 color: Colors.transparent,
          //                 borderRadius: const BorderRadius.all(Radius.circular(200.0)),
          //                 border: Border.all(
          //                   color: Colors.lightBlueAccent.withOpacity(.3),
          //                   width: 1.0,
          //                 ),
          //               ),
          //               child:Padding(
          //                 padding: const EdgeInsets.all(8.0),
          //                 child: (
          //                     Container(
          //                       decoration: BoxDecoration(
          //                         color: Colors.transparent,
          //                         borderRadius: const BorderRadius.all(Radius.circular(200.0)),
          //                         border: Border.all(
          //                           color: Colors.lightBlueAccent.withOpacity(.5),
          //                           width: 1.0,
          //                         ),
          //                       ),
          //                       child: Padding(
          //                         padding: const EdgeInsets.all(8.0),
          //                         child: Container(
          //                           child: Padding(
          //                             padding: const EdgeInsets.all(25.0),
          //                             child:Column(
          //                               children: const [
          //                                 Text('\$0.23',
          //                                     style: kBigTextStyle),
          //                                 SizedBox(height: 4,),
          //                                 Text('+4.29%',
          //                                     style:kSmallTextStyle
          //                                 ),
          //                               ],
          //                             ),
          //
          //                           ),
          //                           decoration: BoxDecoration(
          //                             color: Colors.transparent,
          //
          //                             borderRadius: const BorderRadius.all(Radius.circular(250.0)),
          //                             border: Border.all(
          //                               color: Colors.lightBlueAccent,
          //                               width: 1.0,
          //
          //                             ),
          //                           ),),
          //                       ),
          //                     )),
          //               ),),
          //
          //             const SizedBox(height: 20),
          //
          //             Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: Column(
          //                 children: [
          //                   Row(
          //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                     children: const [
          //                       Text('Market Cap',
          //                         style: kMediumTextStyle,),
          //                       SizedBox(height: 4,),
          //                       Text('\$44,460,560.56',
          //                         style: kMediumTextStyle,)
          //                     ],
          //                   ),
          //                   Row(
          //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                     children: const [
          //                       Text('24h Vol',
          //                         style: kMediumTextStyle,),
          //                       Text('\$1,478,971.56',
          //                         style: kMediumTextStyle,)
          //                     ],
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Minting Parameters',
                  style:kBigTextStyle),
                ),
                StaggeredGridView.countBuilder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    itemCount: 4,
                    itemBuilder: (context,index){
                      return InfoCard(title1: 'Height',icon1: Icons.manage_accounts_rounded,titleValue1: '8734872');
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
                      style:kBigTextStyle),
                ),
                StaggeredGridView.countBuilder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    itemCount: 6,
                    itemBuilder: (context,index){
                      return InfoCard(title1: 'Height',icon1: Icons.manage_accounts_rounded,titleValue1: '8734872');
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
                      style:kBigTextStyle),
                ),
                StaggeredGridView.countBuilder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    itemCount: 6,
                    itemBuilder: (context,index){
                      return InfoCard(title1: 'Height',icon1: Icons.manage_accounts_rounded,titleValue1: '8734872');
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
                      style:kBigTextStyle),
                ),
                StaggeredGridView.countBuilder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    itemCount: 6,
                    itemBuilder: (context,index){
                      return InfoCard(title1: 'Height',icon1: Icons.manage_accounts_rounded,titleValue1: '8734872');
                    },
                    staggeredTileBuilder: (index) => const StaggeredTile.fit(1)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
