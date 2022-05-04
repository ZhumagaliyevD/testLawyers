import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'advices_record.g.dart';

abstract class AdvicesRecord
    implements Built<AdvicesRecord, AdvicesRecordBuilder> {
  static Serializer<AdvicesRecord> get serializer => _$advicesRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'created_by')
  DocumentReference get createdBy;

  @nullable
  DocumentReference get lawyer;

  @nullable
  @BuiltValueField(wireName: 'created_at')
  DateTime get createdAt;

  @nullable
  String get status;

  @nullable
  String get advice;

  @nullable
  DocumentReference get schedule;

  @nullable
  @BuiltValueField(wireName: 'pdf_document')
  String get pdfDocument;

  @nullable
  String get pdf;

  @nullable
  int get paid;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(AdvicesRecordBuilder builder) => builder
    ..status = ''
    ..advice = ''
    ..pdfDocument = ''
    ..pdf = ''
    ..paid = 0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('advices');

  static Stream<AdvicesRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<AdvicesRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  AdvicesRecord._();
  factory AdvicesRecord([void Function(AdvicesRecordBuilder) updates]) =
      _$AdvicesRecord;

  static AdvicesRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createAdvicesRecordData({
  DocumentReference createdBy,
  DocumentReference lawyer,
  DateTime createdAt,
  String status,
  String advice,
  DocumentReference schedule,
  String pdfDocument,
  String pdf,
  int paid,
}) =>
    serializers.toFirestore(
        AdvicesRecord.serializer,
        AdvicesRecord((a) => a
          ..createdBy = createdBy
          ..lawyer = lawyer
          ..createdAt = createdAt
          ..status = status
          ..advice = advice
          ..schedule = schedule
          ..pdfDocument = pdfDocument
          ..pdf = pdf
          ..paid = paid));
