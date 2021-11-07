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
    if (widget.id != null) {
      try {
        setState(() {
          _loading = true;
        });

        final state = context.read<ApplicationState>();
        final res = await http.get(
            Uri.parse('${dotenv.env['BASE_URL']}/api/v1/items/${widget.id}'),
            headers: {'authorization': state.apiKey ?? ''});

        if (res.statusCode != HttpStatus.ok) throw res.body;

        setState(() {
          _item = Item.fromJson(jsonDecode(res.body));
        });
      } catch (e) {
        print('Error fetching item');
      } finally {
        setState(() {
          _loading = false;
        });
      }
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

  Future<void> _handleDeleteItem() async {
    try {
      setState(() {
        _loading = true;
      });

      final state = context.read<ApplicationState>();
      final res = await http.delete(
        Uri.parse('${dotenv.env['BASE_URL']}/api/v1/items/${_item?.id}'),
        headers: {'authorization': state?.apiKey ?? ''},
      );

      if (res.statusCode != HttpStatus.ok) throw res.body;

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
                  ),
                  _item?.id != null && _item?.id != 0
                      ? Container(
                          margin: EdgeInsets.only(bottom: 5, top: 5),
                          child: Container(
                            child: Row(
                              children: [
                                MaterialButton(
                                  onPressed: () async {
                                    await showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                              title: Text('Confirm deletion'),
                                              content: Text(
                                                'Really delete item ${_item?.name}? This action cannot be undone.',
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () async {
                                                    _handleDeleteItem();
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'Yes, really delete',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'No',
                                                    style: TextStyle(
                                                        color: Colors.green),
                                                  ),
                                                ),
                                              ],
                                            ));
                                  },
                                  child: Text(
                                    'Delete item',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
    );
  }
}
