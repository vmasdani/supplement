import 'package:flutter/material.dart';

class CustomersPage extends StatefulWidget {
  const CustomersPage({Key? key}) : super(key: key);

  @override
  _CustomersPageState createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customers'),
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
