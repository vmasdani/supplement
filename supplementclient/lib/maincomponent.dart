import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supplementclient/applicationstate.dart';
import 'package:supplementclient/customers.dart';
import 'package:supplementclient/dashboard.dart';
import 'package:provider/provider.dart';
import 'package:supplementclient/inventory.dart';
import 'package:supplementclient/loginpage.dart';

class MainComponent extends StatefulWidget {
  const MainComponent({Key? key}) : super(key: key);

  @override
  _MainComponentState createState() => _MainComponentState();
}

class _MainComponentState extends State<MainComponent> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(builder: (ctx, state, child) {
      if (state.apiKey != null) {
        switch (state.selectedPage) {
          case 0:
            return DashboardPage();
          case 1:
            return InventoryPage();
          case 2:
            return CustomersPage();

          default:
            return Scaffold();
        }
      } else {
        return LoginPage();
      }
    });
  }
}
