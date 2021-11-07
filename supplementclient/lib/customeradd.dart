import 'package:flutter/material.dart';

class CustomerAddPage extends StatefulWidget {
  const CustomerAddPage({Key? key, this.id, this.onSave}) : super(key: key);

  final int? id;
  final Function()? onSave;

  @override
  _CustomerAddPageState createState() => _CustomerAddPageState();
}

class _CustomerAddPageState extends State<CustomerAddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Customer Editor'),
          actions: [
            TextButton(onPressed: () async {}, child: const Text('Save'))
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {},
          child: Container(
            child: ListView(
              children: [],
            ),
          ),
        ));
  }
}
