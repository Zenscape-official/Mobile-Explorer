import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:zenscape_app/constants/constString.dart';
import '../../Screens/homeScreen.dart';
import '../../constants/constants.dart';
import '../../widgets/navigationDrawerWidget.dart';

class IBCDetails extends StatefulWidget {
  const IBCDetails({Key? key}) : super(key: key);
  @override
  State<IBCDetails> createState() => _IBCDetailsState();
}
class _IBCDetailsState extends State<IBCDetails> {
  var details = ['0', '0', '0', '0'];
  TextEditingController nameController=TextEditingController();
  String fullName = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDraw(),
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('IBC Retailer Details',
              style:kBigBoldTextStyle
              ),
          ],
        ),
      ),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        children: <Widget>[
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
              )
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0,15,15,0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StaggeredGridView.countBuilder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    itemCount: details.length,
                    itemBuilder: (context,index){
                      return InfoCard(title1: IBCdetails[index],icon1: image[index],titleValue1: details[index]);
                    },
                    staggeredTileBuilder: (index) => const StaggeredTile.fit(1)
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: kBoxDecorationWithGradient,
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                        children:[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:[
                                  Row(
                                    children: [
                                      CircleAvatar(),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('COSMOS',
                                                style:kMediumBoldTextStyle),
                                            Text('channel-227',
                                            style: kExtraSmallTextStyle,)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    decoration: BoxDecoration (
                                      border: Border.all(
                                        color: Color(0xFFDEA30F).withOpacity(.5),
                                        width: 1.0,
                                      ),
                                      color: Colors.transparent,
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
                                      child: Text('Pending',
                                          style:TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFDEA30F).withOpacity(.5),
                                          )
                                      ),
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
                                  Text('IBC Send Txs',
                                      style:kSmallTextStyle),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text('23,508',
                                          style:kSmallBoldTextStyle),
                                      Text('\$ 46,295,550.72',
                                          style:kSmallTextStyle),
                                    ],
                                  )
                                ]
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8,4.0,8,8),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('IBC Receive Txs',
                                      style:kSmallTextStyle),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('97,508',
                                      style:kSmallBoldTextStyle),
                                  Text('\$ 82,295,840.72',
                                      style:kSmallTextStyle),]
                            )]
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8,4.0,8,8),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:[
                                  Text('IBC Timeout Txs',
                                      style:kSmallTextStyle),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('11,508',
                                      style:kSmallBoldTextStyle),
                                  Text('\$ 4,825,550.72',
                                      style:kSmallTextStyle),
                                ])]
                            ),
                          ),
                        ]
                    ),
                  ),
                ),
                Container(
                  decoration: kBoxDecorationWithGradient,
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                        children:[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(

                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:[

                                 
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('KAVA',
                                                    style:kMediumBoldTextStyle),
                                                Text('channel-227',
                                                  style: kExtraSmallTextStyle,)
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                    decoration: BoxDecoration (
                                      border: Border.all(
                                        color: Color(0xFFDEA30F).withOpacity(.5),
                                        width: 1.0,
                                      ),
                                      color: Colors.transparent,
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
                                      child: Text('Pending',
                                          style:TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFDEA30F).withOpacity(.5),
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
                                  Text('IBC Send Txs',
                                      style:kSmallTextStyle),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text('23,508',
                                          style:kSmallBoldTextStyle),
                                      Text('\$ 46,295,550.72',
                                          style:kSmallTextStyle),
                                    ],
                                  )
                                ]
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8,4.0,8,8),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('IBC Receive Txs',
                                      style:kSmallTextStyle),
                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text('97,508',
                                            style:kSmallBoldTextStyle),
                                        Text('\$ 82,295,840.72',
                                            style:kSmallTextStyle),]
                                  )]
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8,4.0,8,8),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:[
                                  Text('IBC Timeout Txs',
                                      style:kSmallTextStyle),
                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text('11,508',
                                            style:kSmallBoldTextStyle),
                                        Text('\$ 4,825,550.72',
                                            style:kSmallTextStyle),
                                      ]
                                  )
                                ]
                            ),
                          ),
                        ]
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
