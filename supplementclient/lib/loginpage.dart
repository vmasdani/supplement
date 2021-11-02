import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:supplementclient/applicationstate.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _username = '';
  var _password = '';

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    final state = context.read<ApplicationState>();

    if (prefs.getString('apiKey') != null) {
      state.setApiKey(prefs.getString('apiKey'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(left: 25),
              alignment: Alignment.centerLeft,
              child: Text(
                'Supply App',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
              child: TextField(
                onChanged: (v) {
                  _username = v;
                },
                decoration: InputDecoration(
                    label: Text('Username'),
                    isDense: true,
                    border: OutlineInputBorder()),
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
              child: TextField(
                onChanged: (v) {
                  _password = v;
                },
                decoration: InputDecoration(
                    label: Text('Password'),
                    isDense: true,
                    border: OutlineInputBorder()),
              ),
            ),
            Container(
              child: MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () async {
                  // showDialog(
                  //     context: context,
                  //     builder: (_) => AlertDialog(
                  //           title: Text('Test'),
                  //           content: Container(
                  //             child: Text(jsonEncode({
                  //               'username': _username,
                  //               'password': _password
                  //             })),
                  //           ),
                  //         ));
                  if (_username == '') {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              title: Text('Failed'),
                              content: Text('Username must not be empty.'),
                            ));
                    return;
                  }

                  if (_password == '') {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              title: Text('Failed'),
                              content: Text('Password must not be empty.'),
                            ));
                    return;
                  }

                  try {
                    final res = await http.post(
                        Uri.parse('${dotenv.env['BASE_URL']}/api/v1/login'),
                        headers: {'content-type': 'application/json'},
                        body: jsonEncode(
                            {'username': _username, 'password': _password}));

                    if (res.statusCode != HttpStatus.ok) {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                title: Text('Failed'),
                                content: Text('Login failed: ${res.body}'),
                              ));

                      return;
                    }

                    final prefs = await SharedPreferences.getInstance();
                    final state = context.read<ApplicationState>();

                    state.setApiKey(jsonDecode(res.body)['token']);
                    prefs.setString('apiKey', jsonDecode(res.body)['token']);
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text('Login'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
