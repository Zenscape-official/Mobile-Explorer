import 'package:flutter/material.dart';
import 'package:zenscape_app/Constants/constants.dart';
import 'package:zenscape_app/widgets/NavigationDrawerWidget.dart';
import 'package:zenscape_app/widgets/onboardingwidgets/ToggleButton.dart';

class Validators extends StatefulWidget {
  const Validators({Key? key}) : super(key: key);

  @override
  State<Validators> createState() => _ValidatorsState();
}
class _ValidatorsState extends State<Validators> {
  TextEditingController nameController=TextEditingController();
  String fullName = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDraw(),
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:  [
            Text('Validators',
            style:kBigBoldTextStyle),
            CircleAvatar(
                radius:15,
                child: Image.asset('assets/images/cmdx.png'),
                backgroundColor: Colors.transparent),
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
                  padding: const EdgeInsets.all(0.0),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(15),
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
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [ToggleButton(leftTitle: 'Active',rightTitle: 'Inactive',)],),
            ),
          ListView.builder(
          reverse: true,
    physics: const NeverScrollableScrollPhysics(),
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemCount: 6,
    itemBuilder: (BuildContext context, int index) {
    return Container(
      decoration:BoxDecoration(
        borderRadius: BorderRadius.circular(20)
      ),
        //height: MediaQuery.of(context).size.height/2.6,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
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
                            backgroundColor: Colors.transparent,),
                          Text('  AUDIT.ONE',
                            style: kBigBoldTextStyle
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[Container(
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
                                      children: [
                                        Text('4407336',
                                            style: kMediumBoldTextStyle),
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
                                  ),),
                              ),
                            )),
                      ),),],
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12,4,12,4),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Uptime',
                            style: kSmallTextStyle,),
                            Text('100%',
                              style: kSmallBoldTextStyle,)
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text('Partcipation',
                                style: kSmallTextStyle
                            ),
                            Text(' 5/7',
                                style: kSmallBoldTextStyle,
                                ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Commission',
                              style: kSmallTextStyle,),
                            Text('7%',style: kSmallBoldTextStyle,)
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
    );


    }),
    ]),
      ));
  }
}
