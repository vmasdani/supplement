import 'package:flutter/material.dart';
import 'package:supplementclient/customeradd.dart';
import 'package:supplementclient/model.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  var _search = '';
  List<User> _users = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> _init() async {
    try {} catch (e) {
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: Container(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(15),
              child: Row(
                children: [
                  Expanded(
                    child: Text('Users total: ${_users.length}'),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      color: Colors.blue,
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CustomerAddPage(
                              onSave: () async {
                                Navigator.pop(context);
                                _init();
                              },
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.add),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: TextEditingController(text: _search),
                      onChanged: (v) {
                        _search = v;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        hintText: 'Search user (by name, username)...',
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        setState(() {});
                      },
                      icon: const Icon(Icons.search)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
