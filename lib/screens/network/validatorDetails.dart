import 'package:flutter/material.dart';
import 'package:zenscape_app/backend_files/validatorsModel.dart';
import 'package:zenscape_app/constants/constants.dart';

class ValidatorDetails extends StatefulWidget {
  final ValidatorModel? validatorModel;
  ValidatorDetails({Key? key,this.validatorModel}) : super(key: key);
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
                                  Text('Information', style: kMediumBoldTextStyle),

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
                                  Text('Voting Power', style: kSmallTextStyle),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(widget.validatorModel!.votingPower!, style: kMediumBoldTextStyle),

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
