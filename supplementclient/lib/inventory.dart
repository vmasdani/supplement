import 'package:flutter/material.dart';
import 'package:supplementclient/inventoryadd.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory'),
      ),
      body: Container(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(15),
              child: Row(
                children: [
                  Expanded(
                    child: Text('Inventory List'),
                  ),
                  Expanded(
                      child: Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      color: Colors.blue,
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => InventoryAddPage()));
                      },
                      icon: Icon(Icons.add),
                    ),
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
