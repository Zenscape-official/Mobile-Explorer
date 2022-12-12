

import 'package:flutter/material.dart';

errorHandler(var result, context, var net, var RxList ){
  if (result['success'] == false)
  {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(result['response']),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        );
      },
    );
  }

  if(result['success'] == true) {

    net = RxList;}

}

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
        .inSeconds}days ago';
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