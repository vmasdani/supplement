import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import 'package:supplementclient/applicationstate.dart';
import 'package:supplementclient/inventoryadd.dart';
import 'package:supplementclient/model.dart';

import 'package:http/http.dart' as http;

class InventoryPage extends StatefulWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  var _loading = false;
  List<Item> _items = [];
  var _search = '';

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    try {
      setState(() {
        _loading = true;
      });
      final state = context.read<ApplicationState>();
      final res = await http.get(
          Uri.parse('${dotenv.env['BASE_URL']}/api/v1/items'),
          headers: {'authorization': state.apiKey ?? ''});

      if (res.statusCode != HttpStatus.ok) throw res.body;

      setState(() {
        _items = (jsonDecode(res.body) as Iterable)
            .map((j) => Item.fromJson(j))
            .toList();
        _loading = false;
      });
    } catch (e) {
      print("[Error fetching items] $e");
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _init();
        },
        child: (() {
          final filteredItems = _items.where(
            (i) =>
                '${i.name ?? ''}${i.description ?? ''}'.toLowerCase().contains(
                      _search.toLowerCase(),
                    ),
          );
          return Container(
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('Items total: ${filteredItems.length}'),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          color: Colors.blue,
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => InventoryAddPage(
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
                            hintText: 'Search item (by name, desc)...',
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
                _loading
                    ? Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.blue),
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.all(15),
                        child: Column(
                          children: filteredItems.mapIndexed((index, i) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => InventoryAddPage(
                                      id: i.id,
                                      onSave: () async {
                                        Navigator.pop(context);
                                        _init();
                                      },
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              child: Text(
                                                '${index + 1}. ${i.name != null && i.name != '' ? i.name! : ''}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                                '${NumberFormat.decimalPattern().format(i.price ?? 0)}'),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              child: Text(
                                                  i.description != null &&
                                                          i.description != ''
                                                      ? i.description!
                                                      : 'No description'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                              color: Colors.blue,
                                              padding: EdgeInsets.all(5),
                                              margin: EdgeInsets.only(
                                                top: 5,
                                                bottom: 5,
                                              ),
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                'In stock: ${0} ${i?.uom?.name ?? ''}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ))
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      )
              ],
            ),
          );
        })(),
      ),
    );
  }
}
