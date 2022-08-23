import 'package:flutter/material.dart';

class NetworkList extends StatelessWidget {
  const NetworkList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.only(left: 20, right: 20),
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: Container(
                child: Text('Select Network',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.black
                ),),
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return Material(
                    child: ListTile(
                      onTap: null,
                        leading: const Icon(Icons.list),
                        trailing: const Text(
                          "GFG",
                          style: TextStyle(color: Colors.green, fontSize: 15),
                        ),
                        title: Text("Network $index")),
                  );
                }),
          ],
        ));
  }
}
