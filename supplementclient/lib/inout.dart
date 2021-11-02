import 'package:flutter/material.dart';

class InOutPage extends StatefulWidget {
  const InOutPage({Key? key}) : super(key: key);

  @override
  _InOutPageState createState() => _InOutPageState();
}

class _InOutPageState extends State<InOutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('In & Out'),
      ),
      body: Container(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 15, left: 15, right: 15),
            )
          ],
        ),
      ),
    );
  }
}
