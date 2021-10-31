// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer()
  ..id = json['id'] as int?
  ..ordering = json['ordering'] as int?
  ..extCreatedById = json['ext_created_by_id'] as int?
  ..uuid = json['uuid'] as String?
  ..hidden = json['hidden'] as int?
  ..name = json['name'] as String?
  ..address = json['address'] as String?
  ..phone = json['phone'] as String?
  ..email = json['email'] as String?
  ..userId = json['user_id'] as int?;

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'id': instance.id,
      'ordering': instance.ordering,
      'ext_created_by_id': instance.extCreatedById,
      'uuid': instance.uuid,
      'hidden': instance.hidden,
      'name': instance.name,
      'address': instance.address,
      'phone': instance.phone,
      'email': instance.email,
      'user_id': instance.userId,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item()
  ..id = json['id'] as int?
  ..ordering = json['ordering'] as int?
  ..extCreatedById = json['ext_created_by_id'] as int?
  ..uuid = json['uuid'] as String?
  ..hidden = json['hidden'] as int?
  ..name = json['name'] as String?
  ..price = (json['price'] as num?)?.toDouble()
  ..uomId = json['uom_id'] as int?
  ..uom = json['uom'] == null
      ? null
      : Uom.fromJson(json['uom'] as Map<String, dynamic>)
  ..description = json['description'] as String?;

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'ordering': instance.ordering,
      'ext_created_by_id': instance.extCreatedById,
      'uuid': instance.uuid,
      'hidden': instance.hidden,
      'name': instance.name,
      'price': instance.price,
      'uom_id': instance.uomId,
      'uom': instance.uom,
      'description': instance.description,
    };

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction()
  ..id = json['id'] as int?
  ..ordering = json['ordering'] as int?
  ..extCreatedById = json['ext_created_by_id'] as int?
  ..uuid = json['uuid'] as String?
  ..hidden = json['hidden'] as int?
  ..name = json['name'] as String?
  ..date = json['date'] as String?;

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ordering': instance.ordering,
      'ext_created_by_id': instance.extCreatedById,
      'uuid': instance.uuid,
      'hidden': instance.hidden,
      'name': instance.name,
      'date': instance.date,
    };

TransactionItem _$TransactionItemFromJson(Map<String, dynamic> json) =>
    TransactionItem()
      ..id = json['id'] as int?
      ..ordering = json['ordering'] as int?
      ..extCreatedById = json['ext_created_by_id'] as int?
      ..uuid = json['uuid'] as String?
      ..hidden = json['hidden'] as int?
      ..type = json['type'] as String?
      ..remark = json['remark'] as String?
      ..qty = (json['qty'] as num?)?.toDouble()
      ..transactionId = json['transaction_id'] as int?
      ..itemId = json['item_id'] as int?
      ..discountPrice = json['discount_price'] as int?;

Map<String, dynamic> _$TransactionItemToJson(TransactionItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ordering': instance.ordering,
      'ext_created_by_id': instance.extCreatedById,
      'uuid': instance.uuid,
      'hidden': instance.hidden,
      'type': instance.type,
      'remark': instance.remark,
      'qty': instance.qty,
      'transaction_id': instance.transactionId,
      'item_id': instance.itemId,
      'discount_price': instance.discountPrice,
    };

Uom _$UomFromJson(Map<String, dynamic> json) => Uom()
  ..id = json['id'] as int?
  ..ordering = json['ordering'] as int?
  ..extCreatedById = json['ext_created_by_id'] as int?
  ..uuid = json['uuid'] as String?
  ..hidden = json['hidden'] as int?
  ..name = json['name'] as String?;

Map<String, dynamic> _$UomToJson(Uom instance) => <String, dynamic>{
      'id': instance.id,
      'ordering': instance.ordering,
      'ext_created_by_id': instance.extCreatedById,
      'uuid': instance.uuid,
      'hidden': instance.hidden,
      'name': instance.name,
    };

User _$UserFromJson(Map<String, dynamic> json) => User()
  ..id = json['id'] as int?
  ..ordering = json['ordering'] as int?
  ..extCreatedById = json['ext_created_by_id'] as int?
  ..uuid = json['uuid'] as String?
  ..hidden = json['hidden'] as int?
  ..name = json['name'] as String?
  ..username = json['username'] as String?
  ..email = json['email'] as String?
  ..phone = json['phone'] as String?
  ..address = json['address'] as String?
  ..password = json['password'] as String?;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'ordering': instance.ordering,
      'ext_created_by_id': instance.extCreatedById,
      'uuid': instance.uuid,
      'hidden': instance.hidden,
      'name': instance.name,
      'username': instance.username,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
      'password': instance.password,
    };
