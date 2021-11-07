import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:supplementclient/applicationstate.dart';
import 'package:supplementclient/model.dart';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;

class InventoryAddPage extends StatefulWidget {
  const InventoryAddPage({Key? key, this.id, this.onSave}) : super(key: key);

  final int? id;
  final Function()? onSave;

  @override
  _InventoryAddPageState createState() => _InventoryAddPageState();
}

class _InventoryAddPageState extends State<InventoryAddPage> {
  Item? _item = Item();
  var _loading = false;

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

      setState(() {
        _loading = false;
      });
    } catch (e) {
      print('Error fetching item');
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _handleSave() async {
    try {
      setState(() {
        _loading = true;
      });

      final state = context.read<ApplicationState>();
      final res = await http.post(
          Uri.parse('${dotenv.env['BASE_URL']}/api/v1/items'),
          headers: {'authorization': state?.apiKey ?? ''},
          body: jsonEncode(_item));

      if (res.statusCode != HttpStatus.created) throw res.body;

      setState(() {
        _loading = false;
      });

      if (widget.onSave != null) {
        widget.onSave!();
      }
    } catch (e) {
      print('[Error saving inventory!] $e');
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
        title: Text('Inventory Editor'),
        actions: [
          TextButton(
            onPressed: () async {
              _handleSave();
            },
            child: Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.blue),
              ),
            )
          : Container(
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.all(15),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
                    child: TextField(
                      onChanged: (v) {
                        _item?.name = v;
                      },
                      controller: TextEditingController(text: _item?.name),
                      decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(),
                        label: Text('Name'),
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
                    child: TextField(
                      onChanged: (v) {
                        _item?.description = v;
                      },
                      controller:
                          TextEditingController(text: _item?.description),
                      maxLines: null,
                      decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(),
                        label: Text('Description'),
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged: (v) {
                              try {
                                _item?.price = double.parse(v);
                              } catch (e) {
                                print(e);
                              }
                            },
                            controller: TextEditingController(
                                text: '${_item?.price ?? ''}'),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(),
                              label: Text('Price'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text('Unit of Measurement'),
                        ),
                        Consumer<ApplicationState>(
                          builder: (ctx, state, child) {
                            return DropdownButton(
                              value: state.uoms?.firstWhereOrNull(
                                  (u) => u?.id == _item?.uomId),
                              onChanged: (v) {
                                setState(() {
                                  _item?.uomId = (v as Uom?)?.id;
                                });
                              },
                              items: (state.uoms
                                  ?.map(
                                    (u) => DropdownMenuItem(
                                      value: u,
                                      child: Text(u?.name ?? 'No name'),
                                    ),
                                  )
                                  .toList()),
                            );
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
