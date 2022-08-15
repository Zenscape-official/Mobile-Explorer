import 'package:flutter/material.dart';
import 'package:zenscape_app/Constants/constants.dart';
import '../Controller/product_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView(
        physics: const ClampingScrollPhysics(),
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height/2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(child: Image.asset('assets/images/akt.png')),
                              Text(' AKT',
                                style: TextStyle(color: Colors.black.withOpacity(1),
                                  fontSize: 25
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.access_time,
                              color:Colors.blue),
                              const SizedBox(width: 2,),
                              Text('BLOCK TIME',
                                  style: TextStyle(color: Colors.black.withOpacity(1),
                                      fontSize: 14,
                                      )
                              ),
                              Text('  6,079ms',
                                  style: TextStyle(color: Colors.black.withOpacity(1),
                                      fontSize: 13,
                                      )
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 90,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [Text('\$0.23',
                          style: TextStyle(color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),)],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text('CoinGecko',
                                style: TextStyle(color: Colors.black.withOpacity(0.6),
                                    fontSize: 15
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.trending_up,color:Colors.green),
                              const SizedBox(width: 5,),
                              ElevatedButton(
                                onPressed: ProductController.fetchProducts,
                                child: Text('+4.29%',
                                    style: TextStyle(color: Colors.black.withOpacity(1),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)
                                ),
                              ),
                              Text(' (24h)',
                                  style: TextStyle(color: Colors.black.withOpacity(1),
                                    fontSize: 13,
                                  ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Card(
                        color: Colors.grey[100],
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text('Market Cap'),
                                  Text('\$44,460,560.56')

                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text('24h Vol'),
                                  Text('\$1,478,971.56')
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
           InfoCard(title1:'Height',
             titleValue1:'6,690,889',
             icon1: Icons.terrain,),
           InfoCard(title1: 'Bonded Tokens',
               titleValue1: '146M / 197M',
               icon1:Icons.monetization_on_outlined,),
           InfoCard(title1: 'Inflation',
              titleValue1: '14.55%',
              icon1:Icons.trending_up,)
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
      final String title1;
      final String? titleValue1;
      final IconData? icon1;

      InfoCard({Key? key, required this.title1, this.titleValue1,this.icon1}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBoxDecorationWithoutGradient,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Icon(icon1),
            SizedBox(height: 4),
            Text(title1,
            style: kSmallTextStyle,),
            SizedBox(height: 4),
            Text(titleValue1!,
              style: kMediumTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
