import 'package:flutter/material.dart';

import '../../Constants/constants.dart';
import '../../widgets/NavigationDrawerWidget.dart';

class Assets extends StatelessWidget {
  const Assets({Key? key}) : super(key: key);

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
            Text('ASSETS',
                style:kBigTextStyle),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(
              width: MediaQuery.of(context).size.width/1,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: kBoxDecorationWithGradient,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [

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
                            padding: const EdgeInsets.all(3.0),
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
                                    padding: const EdgeInsets.all(3.0),
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child:Column(
                                          children: [
                                            CircleAvatar(child: Image.asset('assets/images/cmdx.png',),radius: 15,)
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
                                      ),),
                                  ),
                                )),
                          ),),

                        const SizedBox(height: 20),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children:  [
                              Text('Chain Value',
                                style: kMediumTextStyle,),
                              const SizedBox(height: 4,),
                              Text('\$,460,560.56',
                                style: kBigBoldTextStyle,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
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
                                      decoration: kBoxDecorationWithoutGradient,
                                      child:  Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Text('\$ 9.38',
                                            style:kBigBoldTextStyle,)
                                      ),
                                    )
                                  ]
                              ),

                            ),
                            const SizedBox(height: 5,),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8,4.0,8,8),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children:[
                                    Text('Total Supply',
                                        style:kSmallTextStyle),
                                    Text('CW20 Contract',
                                        style:kSmallTextStyle)
                                  ]
                              ),

                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8,4.0,8,8),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children:[
                                    Text('IBC OUT',
                                        style:kSmallTextStyle),
                                    Text('cmdx..12367s',
                                        style:kSmallTextStyle)
                                  ]
                              ),

                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8,4.0,8,8),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children:[
                                    Text('IN Chain Supply',
                                        style:kSmallTextStyle),
                                    Text('65221',
                                        style:kSmallTextStyle)
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
