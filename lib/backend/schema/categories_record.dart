import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'categories_record.g.dart';

abstract class CategoriesRecord
    implements Built<CategoriesRecord, CategoriesRecordBuilder> {
  static Serializer<CategoriesRecord> get serializer =>
      _$categoriesRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'category_name')
  String get categoryName;

  @nullable
  @BuiltValueField(wireName: 'category_img')
  String get categoryImg;

  @nullable
  DocumentReference get lawyer;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(CategoriesRecordBuilder builder) => builder
    ..categoryName = ''
    ..categoryImg = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('categories');

  static Stream<CategoriesRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<CategoriesRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  CategoriesRecord._();
  factory CategoriesRecord([void Function(CategoriesRecordBuilder) updates]) =
      _$CategoriesRecord;

  static CategoriesRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createCategoriesRecordData({
  String categoryName,
  String categoryImg,
  DocumentReference lawyer,
}) =>
    serializers.toFirestore(
        CategoriesRecord.serializer,
        CategoriesRecord((c) => c
          ..categoryName = categoryName
          ..categoryImg = categoryImg
          ..lawyer = lawyer));
