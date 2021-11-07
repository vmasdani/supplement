import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supplementclient/applicationstate.dart';
import 'package:supplementclient/customers.dart';
import 'package:supplementclient/dashboard.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:supplementclient/inventory.dart';
import 'package:supplementclient/loginpage.dart';
import 'package:supplementclient/model.dart';
import 'package:supplementclient/users.dart';

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

          case 3:
            return UsersPage();

          default:
            return Scaffold();
        }
      } else {
        return LoginPage();
      }
    });
  }
}
