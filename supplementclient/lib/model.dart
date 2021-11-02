import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

abstract class BaseModel {
  int? id;
  int? ordering;
  @JsonKey(name: 'ext_created_by_id')
  int? extCreatedById;
  String? uuid;
  int? hidden;
}

@JsonSerializable()
class Customer with BaseModel {
  Customer();

  String? name;
  String? address;
  String? phone;
  String? email;
  @JsonKey(name: 'user_id')
  int? userId;

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}

@JsonSerializable()
class Item with BaseModel {
  Item();

  String? name;
  double? price;
  @JsonKey(name: 'uom_id')
  int? uomId;
  Uom? uom;
  String? description;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable()
class Transaction with BaseModel {
  Transaction();

  String? name;
  String? date;

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}

@JsonSerializable()
class TransactionItem with BaseModel {
  TransactionItem();

  String? type;
  String? remark;
  double? qty;
  @JsonKey(name: 'transaction_id')
  int? transactionId;
  @JsonKey(name: 'item_id')
  int? itemId;
  @JsonKey(name: 'discount_price')
  int? discountPrice;

  factory TransactionItem.fromJson(Map<String, dynamic> json) =>
      _$TransactionItemFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionItemToJson(this);
}

@JsonSerializable()
class Uom with BaseModel {
  Uom();

  String? name;

  factory Uom.fromJson(Map<String, dynamic> json) => _$UomFromJson(json);
  Map<String, dynamic> toJson() => _$UomToJson(this);
}

@JsonSerializable()
class User with BaseModel {
  User();

  String? name;
  String? username;
  String? email;
  String? phone;
  String? address;
  String? password;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
