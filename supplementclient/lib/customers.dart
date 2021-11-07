import 'package:flutter/material.dart';
import 'package:supplementclient/customeradd.dart';
import 'package:supplementclient/model.dart';

class CustomersPage extends StatefulWidget {
  const CustomersPage({Key? key}) : super(key: key);

  @override
  _CustomersPageState createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  var _search = '';
  List<Customer> _customers = [];

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
        title: Text('Customers'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: Container(
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Expanded(
                      child: Text('Customers total: ${_customers.length}'),
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
                          hintText:
                              'Search customer (by name, address, phone, etc)...',
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
      ),
    );
  }
}
