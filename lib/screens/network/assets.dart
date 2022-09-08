import 'package:flutter/material.dart';
import '../../Constants/constants.dart';
import '../../widgets/navigationDrawerWidget.dart';
import '../../widgets/filterTab.dart';

class Assets extends StatefulWidget {
  const Assets({Key? key}) : super(key: key);

  @override
  State<Assets> createState() => _AssetsState();
}

class _AssetsState extends State<Assets> {
  TextEditingController nameController=TextEditingController();
  String fullName = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  NavDraw(),
      appBar: AppBar(

        foregroundColor: Colors.black,
        titleTextStyle: const TextStyle(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Assets',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Filter(),
              ],
            ),
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
                                        padding: const EdgeInsets.all(6.0),
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
                          padding: const EdgeInsets.all(4.0),
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
                                        CircleAvatar(radius:15,backgroundColor: Colors.transparent,child: Image.asset('assets/images/kava.png',)),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('KAVA ',
                                              style:kMediumBoldTextStyle),
                                        ),],
                                    ),

                                    Container(
                                      decoration: kBoxDecorationWithoutGradient,
                                      child:  Padding(
                                        padding: const EdgeInsets.all(5.0),
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
