import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'schedule_record.g.dart';

abstract class ScheduleRecord
    implements Built<ScheduleRecord, ScheduleRecordBuilder> {
  static Serializer<ScheduleRecord> get serializer =>
      _$scheduleRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'time_available')
  DateTime get timeAvailable;

  @nullable
  DocumentReference get lawyer;

  @nullable
  DocumentReference get advice;

  @nullable
  BuiltList<bool> get booked;

  @nullable
  BuiltList<bool> get booked3;

  @nullable
  BuiltList<DateTime> get periods;

  @nullable
  BuiltList<DateTime> get periods3;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(ScheduleRecordBuilder builder) => builder
    ..booked = ListBuilder()
    ..booked3 = ListBuilder()
    ..periods = ListBuilder()
    ..periods3 = ListBuilder();

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('schedule');

  static Stream<ScheduleRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<ScheduleRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  ScheduleRecord._();
  factory ScheduleRecord([void Function(ScheduleRecordBuilder) updates]) =
      _$ScheduleRecord;

  static ScheduleRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createScheduleRecordData({
  DateTime timeAvailable,
  DocumentReference lawyer,
  DocumentReference advice,
}) =>
    serializers.toFirestore(
        ScheduleRecord.serializer,
        ScheduleRecord((s) => s
          ..timeAvailable = timeAvailable
          ..lawyer = lawyer
          ..advice = advice
          ..booked = null
          ..booked3 = null
          ..periods = null
          ..periods3 = null));
