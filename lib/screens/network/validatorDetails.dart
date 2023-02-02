import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:zenscape_app/backend_files/networkList.dart';
import 'package:zenscape_app/backend_files/validatorsModel.dart';
import 'package:zenscape_app/constants/constants.dart';
import 'package:zenscape_app/constants/functions.dart';
import 'package:zenscape_app/screens/network/searchDetailsScreen.dart';

import '../../backend_files/atomValidatorModel.dart';
import '../../widgets/searchBarWidget.dart';

class ValidatorDetails extends StatefulWidget {
  final ValidatorModel? validatorModel;
  final String? denom;
  var totalVoting;
  String? status;
  NetworkList networkList;
  ValidatorDetails({Key? key,this.validatorModel,this.totalVoting,this.status,this.denom,required this.networkList}) : super(key: key);
  @override
  State<ValidatorDetails> createState() => _ValidatorDetailsState();
}
class _ValidatorDetailsState extends State<ValidatorDetails> {
  TextEditingController nameController=TextEditingController();
  int summarySelected=0;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return
      ValidatorDetailsScreen(nameController: nameController,widget:widget);
  }
}

class ValidatorDetailsScreen extends StatelessWidget {
  const ValidatorDetailsScreen({
    Key? key,
    required this.nameController,
    required this.widget,

  }) : super(key: key);

  final TextEditingController nameController;
  final ValidatorDetails widget;


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
                'Validators Details',
                style: kBigBoldTextStyle,
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
                children: [
                  SearchBar(nameController:nameController,hintText: 'Enter Address..',networkList:widget.networkList),
                  Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        margin: const EdgeInsets.only(right: 10, top: 10, left: 10),
                        width: MediaQuery.of(context).size.width / 1.1,
                        // height:MediaQuery.of(context).size.height/ 1.1,
                        decoration: kBoxDecorationWithGradient,
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child:
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      child:widget.validatorModel!.avatarUrl==null?Image.asset('assets/images/groups_FILL0_wght400_GRAD0_opsz48.png'):
                                      ClipOval(
                                        child: CachedNetworkImage(
                                          imageUrl: widget.validatorModel!.avatarUrl ??
                                              widget.validatorModel!.avatarUrl!,
                                          height: 40,
                                          width: 40,
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),),
                                   widget.status!=null? Container(
                                      decoration: BoxDecoration(
                                        color:widget.status=='Active'? Colors.lightGreenAccent.withOpacity(.1):Colors.red.shade50,
                                        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                        border: Border.all(
                                          color: widget.status=='Active'? const Color(0xFF6BD68D):Colors.red.withOpacity(.5),
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 9.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children:[
                                            CircleAvatar(backgroundColor:  widget.status=='Active'? const Color(0xFF6BD68D):Colors.red.withOpacity(.5),
                                              radius: 3,),
                                            Padding(
                                              padding: const EdgeInsets.all(2.0),
                                              child: Text(widget.status!,
                                                style: kSmallTextStyle,),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ):Container(),
                                  ],
                                ),

                                const SizedBox(
                                  height: 20,
                                ),
                                Text('Moniker', style: kMediumTextStyle),
                                TextWithCopyIcon(copyTextValue: widget.validatorModel!.moniker!, copyTextName: 'Moniker copied to your clipboard!'),

                                const SizedBox(
                                  height: 20,
                                ),
                                SelectableText('Self Delegated Address',
                                    style: kMediumTextStyle),
                                const SizedBox(
                                  height: 2,
                                ),
                                InkWell(
                                  onTap:()=> PersistentNavBarNavigator.pushNewScreen(
                                    context,
                                    screen: SearchScreen (nameController: widget.validatorModel!.selfDelegateAddress!,networkList:widget.networkList),
                                    withNavBar: true,
                                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                  ),
                                  child:  Text(widget.validatorModel!.selfDelegateAddress!, style: kMediumBlueBoldTextStyle),),


                                const SizedBox(
                                  height: 20,
                                ),
                                Text('Operator Address', style: kMediumTextStyle),
                                const SizedBox(
                                  height: 2,
                                ),
                                TextWithCopyIcon(copyTextValue:widget.validatorModel!.operatorAddress!,copyTextName: 'Operator Address Copied to your clipboard'),

                                const SizedBox(
                                  height: 20,
                                ),
                               widget.totalVoting!=null? Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Voting Power', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      children: [
                                        Text('${truncateToDecimalPlaces(widget.validatorModel!.votingPower!/widget.totalVoting!,2)*100}%',
                                            style: kMediumBoldTextStyle),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 0.0),
                                          child: Text(' (${addComma(widget.validatorModel!.votingPower!.toString())}', style: kMediumTextStyle),
                                        ),
                                        Text(' ${widget.denom!})',style: kMediumTextStyle)
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ):Container(),

                                Text('Consensus Address', style: kMediumTextStyle),
                                TextWithCopyIcon(copyTextValue:widget.validatorModel!.consensusAddress!,copyTextName: 'Consensus Address Copied to your clipboard'),
                                const SizedBox(
                                  height: 20,
                                ),

                                widget.validatorModel!.details!=null? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Details', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text((widget.validatorModel!.details??''), style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ):Container(),



                                Text('Commision', style: kSmallTextStyle),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                    '${truncateToDecimalPlaces(double.parse(widget.validatorModel!.commission!)*100,2).toString()}%',
                                    style: kMediumBoldTextStyle),


                              ]
                          ),
                        ),
                      ),
                  ),
                  SizedBox(height: 10,)
                ],
            ),
        ),
    );
  }
}


class AtomValidatorDetails extends StatefulWidget {
  final Validator? validatorModel;
  final String? denom;
  var totalVoting;
  String? status;
  NetworkList networkList;
  AtomValidatorDetails({Key? key,this.validatorModel,this.totalVoting,this.status,this.denom,required this.networkList}) : super(key: key);
  @override
  State<AtomValidatorDetails> createState() => _AtomValidatorDetailsState();
}
class _AtomValidatorDetailsState extends State<AtomValidatorDetails> {
  TextEditingController nameController=TextEditingController();
  int summarySelected=0;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return
      AtomValidatorDetailsScreen(nameController: nameController,widget:widget);
  }
}

class AtomValidatorDetailsScreen extends StatelessWidget {
  const AtomValidatorDetailsScreen({
    Key? key,
    required this.nameController,
    required this.widget,

  }) : super(key: key);

  final TextEditingController nameController;
  final AtomValidatorDetails widget;

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
              'Validators Details',
              style: kBigBoldTextStyle,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchBar(nameController:nameController,hintText: 'Enter Address..',networkList:widget.networkList),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                margin: const EdgeInsets.only(right: 10, top: 10, left: 10),
                width: MediaQuery.of(context).size.width / 1.1,
                // height:MediaQuery.of(context).size.height/ 1.1,
                decoration: kBoxDecorationWithGradient,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child:
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child:Image.asset('assets/images/groups_FILL0_wght400_GRAD0_opsz48.png'),),
                            widget.status!=null? Container(
                              decoration: BoxDecoration(
                                color:widget.status=='Active'? Colors.lightGreenAccent.withOpacity(.1):Colors.red.shade50,
                                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                border: Border.all(
                                  color: widget.status=='Active'? const Color(0xFF6BD68D):Colors.red.withOpacity(.5),
                                  width: 1.0,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 9.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children:[
                                    CircleAvatar(backgroundColor:  widget.status=='Active'? const Color(0xFF6BD68D):Colors.red.withOpacity(.5),
                                      radius: 3,),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(widget.status!,
                                        style: kSmallTextStyle,),
                                    ),
                                  ],
                                ),
                              ),
                            ):Container(),
                          ],
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        Text('Moniker', style: kMediumTextStyle),
                        TextWithCopyIcon(copyTextValue: widget.validatorModel!.description!.moniker!, copyTextName: 'Moniker copied to your clipboard!'),

                        const SizedBox(
                          height: 20,
                        ),
                        // Text('Self Delegated Address',
                        //     style: kMediumTextStyle),
                        // const SizedBox(
                        //   height: 2,
                        // ),
                        // InkWell(
                        //   onTap:()=> PersistentNavBarNavigator.pushNewScreen(
                        //     context,
                        //     screen: SearchScreen (nameController: widget.validatorModel!.operatorAddress!,networkList:widget.networkList),
                        //     withNavBar: true,
                        //     pageTransitionAnimation: PageTransitionAnimation.cupertino,
                        //   ),
                        //   child: Text(widget.validatorModel!.operatorAddress!, style: kMediumBlueBoldTextStyle),),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        Text('Operator Address', style: kMediumTextStyle),
                        const SizedBox(
                          height: 2,
                        ),
                        TextWithCopyIcon(copyTextValue:widget.validatorModel!.operatorAddress!,copyTextName: 'Operator Address Copied to your clipboard'),

                        const SizedBox(
                          height: 20,
                        ),
                        widget.totalVoting!=null? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Voting Power', style: kSmallTextStyle),
                            const SizedBox(
                              height: 2,
                            ),
                            Row(
                              children: [
                                // Text('${truncateToDecimalPlaces(widget.validatorModel!.votingPower!/widget.totalVoting!,2)*100}%',
                                //     style: kMediumBoldTextStyle),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                  child: Text(' (${addComma(widget.validatorModel!.tokens!.toString())}', style: kMediumTextStyle),
                                ),
                                Text(' ${widget.denom!})',style: kMediumTextStyle)
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ):Container(),

                        // Text('Consensus Address', style: kMediumTextStyle),
                        // TextWithCopyIcon(copyTextValue:widget.validatorModel!.consensusAddress!,copyTextName: 'Consensus Address Copied to your clipboard'),
                        // const SizedBox(
                        //   height: 20,
                        // ),

                        widget.validatorModel!.description!.details!=null||widget.validatorModel!.description!=null? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Details', style: kSmallTextStyle),
                            const SizedBox(
                              height: 2,
                            ),
                            Text((widget.validatorModel!.description!.details??''), style: kMediumBoldTextStyle),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ):Container(),



                        Text('Commision', style: kSmallTextStyle),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                            '${truncateToDecimalPlaces(double.parse(widget.validatorModel!.commission!.commissionRates!.rate!)*100,2).toString()}%',
                            style: kMediumBoldTextStyle),


                      ]
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }
}
