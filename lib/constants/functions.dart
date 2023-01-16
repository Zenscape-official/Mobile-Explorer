


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Constants/constants.dart';


timeDifferenceFunction(timeDifference){
  var finalTimeDiff= DateTime.now().toLocal()
      .difference(DateTime.parse(timeDifference).toLocal())
      .inSeconds;
  if(finalTimeDiff<60){
    return '${DateTime.now().toLocal()
        .difference(DateTime.parse(timeDifference).toLocal())
        .inSeconds}secs ago';
  }
  if(finalTimeDiff>60 && finalTimeDiff<3600){
    return '${DateTime.now().toLocal()
        .difference(DateTime.parse(timeDifference).toLocal())
        .inMinutes}mins ago';
  }
  if(finalTimeDiff>3600 && finalTimeDiff<86400){
    return '${DateTime.now().toLocal()
        .difference(DateTime.parse(timeDifference).toLocal())
        .inHours}hours ago';
  }
  if(finalTimeDiff>86400){
    return '${DateTime.now().toLocal()
        .difference(DateTime.parse(timeDifference).toLocal())
        .inDays}days ago';
  }
}

getImage(String id){
  switch(id){
    case 'akash-network':
      return 'assets/images/zenscape_logos/akash.png';
    case 'assetmantle':
      return 'assets/images/zenscape_logos/assetmantle.jpeg';
    case 'cosmos':
      return 'assets/images/zenscape_logos/cosmos-atom-logo.png';
    case 'chihuahua':
      return 'assets/images/zenscape_logos/chihuahua.png';
      case 'comdex':
    return 'assets/images/zenscape_logos/cmdx.png';
    case 'injective':
      return 'assets/images/zenscape_logos/injective-protocol-inj-logo.png';
    case 'juno-network':
      return 'assets/images/zenscape_logos/juno.jpeg';
    case 'kava':
      return 'assets/images/zenscape_logos/kava.png';
    case 'omniflix':
      return 'assets/images/zenscape_logos/omniFlix.webp';
    case 'osmosis':
      return 'assets/images/zenscape_logos/osmo.png';
    case 'persistence':
      return 'assets/images/zenscape_logos/xprt.jpeg';
    case 'secret':
      return 'assets/images/zenscape_logos/scrt.png';
    case 'umee':
      return 'assets/images/zenscape_logos/umee.png';

    default:
      return '';



  }
}
bool isNumeric(String s) => double.tryParse(s) != null;

addComma(String input){
  return  input .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
}
String removeFirstChar(String str) {

  if (str.isNotEmpty && str[0] == 'u') {
    return str.substring(1);
  }
  else if(str[0]=='i'){

  }
  return str;
}
class TextWithCopyIcon extends StatelessWidget {
  const TextWithCopyIcon({
    Key? key,

    required this.copyTextValue,
    required this.copyTextName
  }) : super(key: key);


  final String copyTextValue;
  final String copyTextName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Clipboard.setData(ClipboardData(
            text: copyTextValue,
          )).then((_) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(
                content: Text(
                    '${copyTextName} Copied to your clipboard !')));
          }),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(child: Text(copyTextValue, style: kMediumBoldTextStyle,)),
          const SizedBox(width: 4),
          const Icon(
            Icons.copy,
            color: Colors.black54,
            size: 15,
          ),
        ],
      ),
    );
  }
}
