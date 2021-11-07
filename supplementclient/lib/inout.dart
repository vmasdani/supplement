import 'package:flutter/material.dart';
import 'package:supplementclient/model.dart';

class InOutPage extends StatefulWidget {
  const InOutPage({Key? key}) : super(key: key);

  @override
  _InOutPageState createState() => _InOutPageState();
}

class _InOutPageState extends State<InOutPage> {
  var _search = '';
  List<Transaction> _transactions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('In & Out'),
      ),
      body: Container(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(15),
              child: Row(
                children: [
                  Expanded(
                    child: Text('Transactions total: ${_transactions.length}'),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      color: Colors.blue,
                      onPressed: () async {},
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
                    child: Container(
                      child: TextButton(
                        onPressed: () async {
                          final date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(DateTime.now().year - 10),
                              lastDate: DateTime(DateTime.now().year + 10));
                        },
                        child: Text('From'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text('until'),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: TextButton(
                        onPressed: () async {
                          final date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(DateTime.now().year - 10),
                              lastDate: DateTime(DateTime.now().year + 10));
                        },
                        child: Text('To'),
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
