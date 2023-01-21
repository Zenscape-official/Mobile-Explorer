import'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:zenscape_app/backend_files/ibcDenomModel.dart';
import 'package:zenscape_app/backend_files/networkList.dart';
import '../constants/constants.dart';
import '../screens/network/searchDetailsScreen.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
    required this.nameController,
    required this.hintText,
    this.networkList

  }) : super(key: key);

  final TextEditingController nameController;
  final String hintText;
  final NetworkList? networkList;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.1,
      height: 40,
      decoration: kBoxDecorationWithoutGradient,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: TextField(
          autofocus: false,
          controller: nameController,
          decoration: InputDecoration(
            hintText:hintText,
            contentPadding: const EdgeInsets.only(
                left: 8.0, bottom: 8.0, top: 8.0),
            filled: true,
            fillColor: Colors.transparent,
            focusedBorder: InputBorder.none,
            border: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
                borderRadius: BorderRadius.circular(20)),
            suffixIcon:  IconButton(
              color:Colors.blue,
              onPressed:(){
                if(nameController.text.isEmpty){
                  Get.snackbar('', 'Please $hintText');
                 IBCMapping().readJson();
                }
                else{
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: SearchScreen(nameController: nameController.text,
                        blockSearch: networkList!.blockSearchUrl!,
                        balanceFromAddress: networkList!.contractDetailsBalances!,
                        txSearch: networkList!.txSearchUrl!,
                        txFromAddress: networkList!.txFromAddress!,
                        rewardsFromAddress: networkList!.rewardFromAddress!,
                        delegationFromAddress:networkList!.delegationFromAddress!
                    ),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  ).then((value) {
                    nameController.clear();
                    FocusScope.of(context).requestFocus(FocusNode());
                  });
                }},
              icon:Icon(Icons.search),
            ),
          ),

       onSubmitted: (name) {
         if(name.isEmpty){
           Get.snackbar('', 'Please $hintText');
         }

         else{
           PersistentNavBarNavigator.pushNewScreen(
             context,
             screen: SearchScreen(nameController: name,
               blockSearch: networkList!.blockSearchUrl!,
               balanceFromAddress: networkList!.contractDetailsBalances!,
               txSearch: networkList!.txSearchUrl!,
               txFromAddress: networkList!.txFromAddress!,
               rewardsFromAddress: networkList!.rewardFromAddress!,
               delegationFromAddress:networkList!.delegationFromAddress! ,),
             withNavBar: true, // OPTIONAL VALUE. True by default.
             pageTransitionAnimation: PageTransitionAnimation.cupertino,
           ).then((value) {
             nameController.clear();
             FocusScope.of(context).requestFocus(FocusNode());
           });
         }},
        ),
      ),
    );
  }
}