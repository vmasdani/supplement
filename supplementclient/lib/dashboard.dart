import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:supplementclient/applicationstate.dart';
import 'package:supplementclient/customers.dart';
import 'package:supplementclient/inout.dart';
import 'package:supplementclient/inventory.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Supplement Page'),
      ),
      body: Container(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(15),
              child: Text('Welcome!'),
            ),
            Row(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    IconButton(
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => InventoryPage()));
                        },
                        icon: Icon(Icons.inventory)),
                    Text(
                      'Inventory',
                      style: TextStyle(fontSize: 11),
                    )
                  ],
                )),
                Expanded(
                    child: Column(
                  children: [
                    IconButton(
                        onPressed: () async {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => InOutPage()));
                        },
                        icon: Icon(Icons.swap_vert_circle_outlined)),
                    Text(
                      'In & Out',
                      style: TextStyle(fontSize: 11),
                    )
                  ],
                )),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    IconButton(
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => CustomersPage()));
                        },
                        icon: Icon(Icons.people)),
                    Text(
                      'Customer',
                      style: TextStyle(fontSize: 11),
                    )
                  ],
                )),
                Expanded(
                    child: Column(
                  children: [
                    IconButton(
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => CustomersPage()));
                        },
                        icon: Icon(Icons.account_box)),
                    Text(
                      'User',
                      style: TextStyle(fontSize: 11),
                    )
                  ],
                )),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 15),
              child: Divider(),
            ),
            Container(
              padding: EdgeInsets.all(25),
              child: MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  final state = context.read<ApplicationState>();

                  state.setApiKey(null);
                  prefs.remove('apiKey');
                },
                child: Text('Logout'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
