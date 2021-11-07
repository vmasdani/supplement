import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:supplementclient/applicationstate.dart';
import 'package:supplementclient/customers.dart';
import 'package:http/http.dart' as http;
import 'package:supplementclient/inout.dart';
import 'package:supplementclient/inventory.dart';
import 'package:supplementclient/model.dart';
import 'package:supplementclient/users.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    try {
      final state = context.read<ApplicationState>();

      final dataFutures = await Future.wait([
        (() async {
          try {
            print('${dotenv.env['BASE_URL']}/api/v1/uoms: ${state.apiKey} ');
            final res = await http.get(
                Uri.parse('${dotenv.env['BASE_URL']}/api/v1/uoms'),
                headers: {'authorization': state.apiKey ?? ''});

            if (res.statusCode != HttpStatus.ok) throw res.body;
            state.setUoms((jsonDecode(res.body) as Iterable)
                .map((j) => Uom.fromJson(j))
                .toList());
          } catch (e) {
            print("[Fetch uoms error] $e");
            return null;
          }
        })()
      ]);
    } catch (e) {
    } finally {}
  }

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
                              builder: (_) => UsersPage(),
                            ),
                          );
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
