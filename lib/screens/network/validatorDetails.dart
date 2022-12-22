import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zenscape_app/backend_files/validatorsModel.dart';
import 'package:zenscape_app/constants/constants.dart';

class ValidatorDetails extends StatefulWidget {
  final ValidatorModel? validatorModel;
  var totalVoting;
  ValidatorDetails({Key? key,this.validatorModel,this.totalVoting}) : super(key: key);
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
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child:widget.validatorModel!.avatarUrl==null?Image.asset('assets/images/groups_FILL0_wght400_GRAD0_opsz48.png'):
                                    CachedNetworkImage(
                                      imageUrl: widget.validatorModel!.avatarUrl ??
                                          widget.validatorModel!.avatarUrl!,
                                      height: 40,
                                      width: 40,
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),),

                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text('Moniker', style: kSmallTextStyle),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(widget.validatorModel!.moniker!, style: kMediumBoldTextStyle),

                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text('Validator Address', style: kSmallTextStyle),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(widget.validatorModel!.validatorAddress!, style: kMediumBoldTextStyle),

                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text('Operator Address', style: kSmallTextStyle),
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
                                  Text('${truncateToDecimalPlaces(widget.validatorModel!.votingPower!/widget.totalVoting!,2)*100}%',
                                      style: kMediumBoldTextStyle),
                                  Text(widget.validatorModel!.votingPower!.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},'), style: kMediumTextStyle),

                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text('Consensus Address', style: kSmallTextStyle),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(widget.validatorModel!.consensusAddress!.toString(), style: kMediumBoldTextStyle),

                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text('Minimum Self Delegation', style: kSmallTextStyle),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(widget.validatorModel!.minSelfDelegation!.toString(), style: kMediumBoldTextStyle),

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
