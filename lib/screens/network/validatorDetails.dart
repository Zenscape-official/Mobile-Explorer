import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zenscape_app/backend_files/networkList.dart';
import 'package:zenscape_app/backend_files/validatorsModel.dart';
import 'package:zenscape_app/constants/constants.dart';
import 'package:zenscape_app/constants/functions.dart';

class ValidatorDetails extends StatefulWidget {
  final ValidatorModel? validatorModel;
  final String? denom;
  var totalVoting;
  String? status;
  ValidatorDetails({Key? key,this.validatorModel,this.totalVoting,this.status,this.denom}) : super(key: key);
  @override
  State<ValidatorDetails> createState() => _ValidatorDetailsState();
}
class _ValidatorDetailsState extends State<ValidatorDetails> {
  int summarySelected=0;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return
      Scaffold(
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
                                      Container(
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
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Text('Moniker', style: kMediumTextStyle),
                                      InkWell(
                                        onTap: () =>
                                            Clipboard.setData(ClipboardData(
                                              text: widget.validatorModel!.moniker!,
                                            )).then((_) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Moniker Address to your clipboard !')));
                                            }),
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 4),
                                            const Icon(
                                              Icons.copy,
                                              color: Colors.black54,
                                              size: 15,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(widget.validatorModel!.moniker!, style: kMediumBoldTextStyle),

                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Text('Self Delegated Address', style: kMediumTextStyle),
                                      InkWell(
                                        onTap: () =>
                                            Clipboard.setData(ClipboardData(
                                              text: widget.validatorModel!.selfDelegateAddress!,
                                            )).then((_) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Self Delegated Address to your clipboard !')));
                                            }),
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 4),
                                            const Icon(
                                              Icons.copy,
                                              color: Colors.black54,
                                              size: 15,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(widget.validatorModel!.selfDelegateAddress!, style: kMediumBoldTextStyle),

                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Text('Operator Address', style: kMediumTextStyle),
                                      InkWell(
                                        onTap: () =>
                                            Clipboard.setData(ClipboardData(
                                              text: widget.validatorModel!.operatorAddress!,
                                            )).then((_) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Operator Address to your clipboard !')));
                                            }),
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 4),
                                            const Icon(
                                              Icons.copy,
                                              color: Colors.black54,
                                              size: 15,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(widget.validatorModel!.operatorAddress!, style: kMediumBoldTextStyle),

                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text('Voting Power', style: kSmallTextStyle),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Row(
                                    children: [
                                      Text('${truncateToDecimalPlaces(widget.validatorModel!.votingPower!/widget.totalVoting!,2)*100}%',
                                          style: kMediumBoldTextStyle),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                        child: Text(' (${addComma(widget.validatorModel!.votingPower!.toString())}', style: kMediumTextStyle),
                                      ),
                                      Text(' ${widget.denom!})',style: kMediumTextStyle)
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Text('Consensus Address', style: kMediumTextStyle),
                                      InkWell(
                                        onTap: () =>
                                            Clipboard.setData(ClipboardData(
                                              text: widget.validatorModel!.consensusAddress!,
                                            )).then((_) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Consensus Address to your clipboard !')));
                                            }),
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 4),
                                            const Icon(
                                              Icons.copy,
                                              color: Colors.black54,
                                              size: 15,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(widget.validatorModel!.consensusAddress!.toString(), style: kMediumBoldTextStyle),

                                  const SizedBox(
                                    height: 20,
                                  ),

                                  Text('Details', style: kSmallTextStyle),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text((widget.validatorModel!.details??''), style: kMediumBoldTextStyle),

                                  const SizedBox(
                                    height: 20,
                                  ),
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
                  ],
              ),
          ),
      );
  }
}
