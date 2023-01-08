import'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:zenscape_app/backend_files/ibcDenomModel.dart';
import '../constants/constants.dart';
import '../screens/network/searchDetailsScreen.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
    required this.nameController,
  }) : super(key: key);

  final TextEditingController nameController;

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
         
          controller: nameController,
          decoration: InputDecoration(
            hintText:'Enter Tx Hash, Block Height, Address...',
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
                  Get.snackbar('', 'Please enter Block Height/ Tx Hash /Address');
                 IBCMapping().readJson();
                }

                else{
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: SearchScreen(nameController: nameController.text ),
                    withNavBar: true, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                }},
              icon:Icon(Icons.search),
            ),
          ),
          // onChanged:
          //     (text) {
          //       filterList(text);
          // }
       onSubmitted: (name) {
         if(name.isEmpty){
           Get.snackbar('', 'Please enter Block Height/ Tx Hash/ Address');
         }

         else{
           PersistentNavBarNavigator.pushNewScreen(
             context,
             screen: SearchScreen(nameController: name),
             withNavBar: true, // OPTIONAL VALUE. True by default.
             pageTransitionAnimation: PageTransitionAnimation.cupertino,
           );
         }},
              //()=> Get.to(() => SearchScreen(nameController:nameController.text)) ,
        ),
      ),
    );
  }
}