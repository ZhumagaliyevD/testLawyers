import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'users_record.g.dart';

abstract class UsersRecord implements Built<UsersRecord, UsersRecordBuilder> {
  static Serializer<UsersRecord> get serializer => _$usersRecordSerializer;

  @nullable
  String get email;

  @nullable
  @BuiltValueField(wireName: 'display_name')
  String get displayName;

  @nullable
  @BuiltValueField(wireName: 'photo_url')
  String get photoUrl;

  @nullable
  String get uid;

  @nullable
  @BuiltValueField(wireName: 'created_time')
  DateTime get createdTime;

  @nullable
  @BuiltValueField(wireName: 'phone_number')
  String get phoneNumber;

  @nullable
  String get role;

  @nullable
  BuiltList<double> get rating;

  @nullable
  String get proficiency;

  @nullable
  BuiltList<bool> get terms;

  @nullable
  bool get isLawyer;

  @nullable
  @BuiltValueField(wireName: 'license_number')
  String get licenseNumber;

  @nullable
  @BuiltValueField(wireName: 'expire_date')
  DateTime get expireDate;

  @nullable
  @BuiltValueField(wireName: 'license_photo_front')
  String get licensePhotoFront;

  @nullable
  @BuiltValueField(wireName: 'license_photo_back')
  String get licensePhotoBack;

  @nullable
  String get category;

  @nullable
  BuiltList<DocumentReference> get earned;

  @nullable
  @BuiltValueField(wireName: 'date_of_birth')
  DateTime get dateOfBirth;

  @nullable
  String get sex;

  @nullable
  @BuiltValueField(wireName: 'id_number')
  String get idNumber;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(UsersRecordBuilder builder) => builder
    ..email = ''
    ..displayName = ''
    ..photoUrl = ''
    ..uid = ''
    ..phoneNumber = ''
    ..role = ''
    ..rating = ListBuilder()
    ..proficiency = ''
    ..terms = ListBuilder()
    ..isLawyer = false
    ..licenseNumber = ''
    ..licensePhotoFront = ''
    ..licensePhotoBack = ''
    ..category = ''
    ..earned = ListBuilder()
    ..sex = ''
    ..idNumber = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  UsersRecord._();
  factory UsersRecord([void Function(UsersRecordBuilder) updates]) =
      _$UsersRecord;

  static UsersRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createUsersRecordData({
  String email,
  String displayName,
  String photoUrl,
  String uid,
  DateTime createdTime,
  String phoneNumber,
  String role,
  String proficiency,
  bool isLawyer,
  String licenseNumber,
  DateTime expireDate,
  String licensePhotoFront,
  String licensePhotoBack,
  String category,
  DateTime dateOfBirth,
  String sex,
  String idNumber,
}) =>
    serializers.toFirestore(
        UsersRecord.serializer,
        UsersRecord((u) => u
          ..email = email
          ..displayName = displayName
          ..photoUrl = photoUrl
          ..uid = uid
          ..createdTime = createdTime
          ..phoneNumber = phoneNumber
          ..role = role
          ..rating = null
          ..proficiency = proficiency
          ..terms = null
          ..isLawyer = isLawyer
          ..licenseNumber = licenseNumber
          ..expireDate = expireDate
          ..licensePhotoFront = licensePhotoFront
          ..licensePhotoBack = licensePhotoBack
          ..category = category
          ..earned = null
          ..dateOfBirth = dateOfBirth
          ..sex = sex
          ..idNumber = idNumber));
