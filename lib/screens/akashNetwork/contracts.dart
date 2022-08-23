import'package:flutter/material.dart';

import '../../Constants/constants.dart';
import '../../widgets/navigationDrawerWidget.dart';
class Contracts extends StatefulWidget {
  const Contracts({Key? key}) : super(key: key);

  @override
  State<Contracts> createState() => _ContractsState();
}

class _ContractsState extends State<Contracts> {


  TextEditingController nameController=TextEditingController();
  String fullName = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:NavDraw(),
      appBar: AppBar(
        foregroundColor: Colors.black,
        titleTextStyle: const TextStyle(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('CONTRACTS',
                style:kBigTextStyle),
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
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: [
                  Text('Popular Contracts',style: kMediumTextStyle,),
                ],
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
                                        CircleAvatar(radius:10,backgroundColor: Colors.transparent,child: Image.asset('assets/images/neta.png',color: Colors.black,)),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('NETA TOKEN',
                                              style:kMediumTextStyle),
                                        ),],
                                    ),

                                    Container(
                                      decoration: kBoxDecorationWithoutGradient,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text('10s ago',
                                            style:TextStyle(
                                                color: Colors.black.withOpacity(.5),
                                                fontWeight: FontWeight.bold
                                            )),
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
                                    Text('Contract',
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
                                  children: [
                                    Text('Contract Address',
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
                                  children: [
                                    Text('Executes',
                                        style:kSmallTextStyle),
                                    Text('65221',
                                        style:kSmallTextStyle)
                                  ]
                              ),

                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8,4.0,8,12),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Instantiated at',
                                        style:kSmallTextStyle),
                                    Text('2022-4-12 19:55:26',
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
