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
          children: const [
            Text('Parameters',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontFamily: 'MontserratBold'
              ),),
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
              )),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Minting Parameters',
                  style:kMediumTextStyle),
                ),
                StaggeredGridView.countBuilder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
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
                      style:kMediumTextStyle),
                ),
                StaggeredGridView.countBuilder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
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
                      style:kMediumTextStyle),
                ),
                StaggeredGridView.countBuilder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
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
                      style:kMediumTextStyle),
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
