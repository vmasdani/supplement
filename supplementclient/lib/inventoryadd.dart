import 'package:flutter/material.dart';
import 'package:supplementclient/model.dart';

class InventoryAddPage extends StatefulWidget {
  const InventoryAddPage({Key? key, this.id}) : super(key: key);

  final int? id;

  @override
  _InventoryAddPageState createState() => _InventoryAddPageState();
}

class _InventoryAddPageState extends State<InventoryAddPage> {
  Item? _item = Item();

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    try {} catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory Editor'),
      ),
      body: Container(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(15),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
              child: TextField(
                onChanged: (v) {
                  _item?.name = v;
                },
                decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(),
                    label: Text('Name')),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
              child: TextField(
                onChanged: (v) {
                  _item?.description = v;
                },
                maxLines: null,
                decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(),
                    label: Text('Description')),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
              child: TextField(
                onChanged: (v) {
                  // _item?.name = v;
                },
                decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(),
                    label: Text('Price')),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
              child: TextField(
                onChanged: (v) {
                  // _item?.name = v;
                },
                decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(),
                    label: Text('uoM')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
