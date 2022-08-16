import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../Constants/constants.dart';
import '../widgets/Popup_model/hero_dialogue_route.dart';
import 'AkashNetwork/dashboard.dart';
import 'network_list.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  TextEditingController nameController=TextEditingController();
  String fullName = '';
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
              'Hey there!',
              style: kBigBoldTextStyle,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Networks',
                      style: TextStyle(color: Colors.white),),
                    SizedBox(width: 6,),
                    Icon(Icons.now_widgets_outlined,
                      color: Colors.white,),
                  ],
                ),
                  onPressed: () {
                    Navigator.of(context).push(
                      HeroDialogRoute( settings: const RouteSettings(),
                        builder: (context) => const Center(
                            child: NetworkList()),),);},
                ),
                const IconButton(onPressed: null, icon: Icon(Icons.notifications))
              ],
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
                      controller: nameController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 15, right: 15),
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
              Container(
                        margin: const EdgeInsets.only(right: 10,top: 10,left: 10),
                        height: 199,
                        width: MediaQuery.of(context).size.width/1.1,
                        decoration: kBoxDecorationWithGradient,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset('assets/images/img.png'),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0,10,0,10),
                              child: Text('India\'s Most Valued \n Crypto Company' ,
                                  style:TextStyle(
                                    fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                  ),),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 30.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Row(
                                      children: [
                                        const Text('1 ',
                                            style:TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w900,
                                                fontSize: 25,
                                                color: Colors.black
                                            )),
                                        Column(
                                          children: [
                                            Text('Crore +',
                                              style:kMediumBoldTextStyle),
                                            Text('Investors',
                                              style:kSmallTextStyle),


                                          ],),
                                      ],
                                    ),
                                  ),


                                  Column(children: [
                                    Text('100%',
                                        style:kMediumBoldTextStyle),
                                    Text('Transparent',
                                      style:kSmallTextStyle),


                                  ],),
                                  Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Row(
                                      children: [
                                        const Text('1 ',
                                            style:TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w900,
                                                fontSize: 25,
                                                color: Colors.black
                                            )),
                                        Column(
                                          children: [
                                            Text('Crore +',
                                                style:kMediumBoldTextStyle),
                                            Text('Investors',
                                                style:kSmallTextStyle),


                                          ],),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),



                        ]),
                    ),
              StaggeredGridView.countBuilder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                  itemCount: 10,
                  itemBuilder: (context,index){
                    return const NetworkCard();
                  },
                  staggeredTileBuilder: (index) => const StaggeredTile.fit(1)),
            ],
          ),

      ),
    );
  }
}

class NetworkCard extends StatefulWidget {
  const NetworkCard({Key? key}) : super(key: key);

  @override
  State<NetworkCard> createState() => _NetworkCardState();
}

class _NetworkCardState extends State<NetworkCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>Navigator.push(context, CupertinoPageRoute(builder: (context)=>NetworkDashBoard())),
      child: Container(
        width:MediaQuery.of(context).size.width/2,
        margin:const EdgeInsets.fromLTRB(15,10,15,10),
        decoration: kBoxDecorationWithoutGradient,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10,10,18,10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:  [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,5,15,5),
                    child: CircleAvatar(
                      child: Image.asset('assets/images/cmdx.png'),
                      radius: 15,
                      backgroundColor: Colors.white,
                    ),
                  ),
                   Text('CMDX \ncomdex',
                  style: kMediumBoldTextStyle),
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text('APY',
                      style:kExtraSmallTextStyle),
                      const SizedBox(height:2),
                      Text('160%',
                          style:kMediumBoldTextStyle),
                    ],),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Commission',
                            style:kExtraSmallTextStyle),
                        const SizedBox(height:2),
                        Text('160%',
                            style:kMediumBoldTextStyle),
                      ],)
                  ],
                ),
              ),

              // const CupertinoButton(onPressed: null, child: Text('Stake'))
            ],
          ),
        ),
      ),
    );
  }
}
