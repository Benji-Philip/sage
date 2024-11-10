// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Patient extends _Patient with RealmEntity, RealmObjectBase, RealmObject {
  Patient(
    ObjectId id,
    String tags,
    String name,
    double age,
    int ageUnit,
    String sex,
    String occupation,
    String address,
    String chiefComplaints,
    String hopi,
    String examinations,
    String diagnoses,
    String summaryOfHopi,
    String suggestedQuestions,
    String previousSaves,
    String suggestedTreatment,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'tags', tags);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'age', age);
    RealmObjectBase.set(this, 'ageUnit', ageUnit);
    RealmObjectBase.set(this, 'sex', sex);
    RealmObjectBase.set(this, 'occupation', occupation);
    RealmObjectBase.set(this, 'address', address);
    RealmObjectBase.set(this, 'chiefComplaints', chiefComplaints);
    RealmObjectBase.set(this, 'hopi', hopi);
    RealmObjectBase.set(this, 'examinations', examinations);
    RealmObjectBase.set(this, 'diagnoses', diagnoses);
    RealmObjectBase.set(this, 'summaryOfHopi', summaryOfHopi);
    RealmObjectBase.set(this, 'suggestedQuestions', suggestedQuestions);
    RealmObjectBase.set(this, 'previousSaves', previousSaves);
    RealmObjectBase.set(this, 'suggestedTreatment', suggestedTreatment);
  }

  Patient._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get tags => RealmObjectBase.get<String>(this, 'tags') as String;
  @override
  set tags(String value) => RealmObjectBase.set(this, 'tags', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  double get age => RealmObjectBase.get<double>(this, 'age') as double;
  @override
  set age(double value) => RealmObjectBase.set(this, 'age', value);

  @override
  int get ageUnit => RealmObjectBase.get<int>(this, 'ageUnit') as int;
  @override
  set ageUnit(int value) => RealmObjectBase.set(this, 'ageUnit', value);

  @override
  String get sex => RealmObjectBase.get<String>(this, 'sex') as String;
  @override
  set sex(String value) => RealmObjectBase.set(this, 'sex', value);

  @override
  String get occupation =>
      RealmObjectBase.get<String>(this, 'occupation') as String;
  @override
  set occupation(String value) =>
      RealmObjectBase.set(this, 'occupation', value);

  @override
  String get address => RealmObjectBase.get<String>(this, 'address') as String;
  @override
  set address(String value) => RealmObjectBase.set(this, 'address', value);

  @override
  String get chiefComplaints =>
      RealmObjectBase.get<String>(this, 'chiefComplaints') as String;
  @override
  set chiefComplaints(String value) =>
      RealmObjectBase.set(this, 'chiefComplaints', value);

  @override
  String get hopi => RealmObjectBase.get<String>(this, 'hopi') as String;
  @override
  set hopi(String value) => RealmObjectBase.set(this, 'hopi', value);

  @override
  String get examinations =>
      RealmObjectBase.get<String>(this, 'examinations') as String;
  @override
  set examinations(String value) =>
      RealmObjectBase.set(this, 'examinations', value);

  @override
  String get diagnoses =>
      RealmObjectBase.get<String>(this, 'diagnoses') as String;
  @override
  set diagnoses(String value) => RealmObjectBase.set(this, 'diagnoses', value);

  @override
  String get summaryOfHopi =>
      RealmObjectBase.get<String>(this, 'summaryOfHopi') as String;
  @override
  set summaryOfHopi(String value) =>
      RealmObjectBase.set(this, 'summaryOfHopi', value);

  @override
  String get suggestedQuestions =>
      RealmObjectBase.get<String>(this, 'suggestedQuestions') as String;
  @override
  set suggestedQuestions(String value) =>
      RealmObjectBase.set(this, 'suggestedQuestions', value);

  @override
  String get previousSaves =>
      RealmObjectBase.get<String>(this, 'previousSaves') as String;
  @override
  set previousSaves(String value) =>
      RealmObjectBase.set(this, 'previousSaves', value);

  @override
  String get suggestedTreatment =>
      RealmObjectBase.get<String>(this, 'suggestedTreatment') as String;
  @override
  set suggestedTreatment(String value) =>
      RealmObjectBase.set(this, 'suggestedTreatment', value);

  @override
  Stream<RealmObjectChanges<Patient>> get changes =>
      RealmObjectBase.getChanges<Patient>(this);

  @override
  Stream<RealmObjectChanges<Patient>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Patient>(this, keyPaths);

  @override
  Patient freeze() => RealmObjectBase.freezeObject<Patient>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'tags': tags.toEJson(),
      'name': name.toEJson(),
      'age': age.toEJson(),
      'ageUnit': ageUnit.toEJson(),
      'sex': sex.toEJson(),
      'occupation': occupation.toEJson(),
      'address': address.toEJson(),
      'chiefComplaints': chiefComplaints.toEJson(),
      'hopi': hopi.toEJson(),
      'examinations': examinations.toEJson(),
      'diagnoses': diagnoses.toEJson(),
      'summaryOfHopi': summaryOfHopi.toEJson(),
      'suggestedQuestions': suggestedQuestions.toEJson(),
      'previousSaves': previousSaves.toEJson(),
      'suggestedTreatment': suggestedTreatment.toEJson(),
    };
  }

  static EJsonValue _toEJson(Patient value) => value.toEJson();
  static Patient _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'tags': EJsonValue tags,
        'name': EJsonValue name,
        'age': EJsonValue age,
        'ageUnit': EJsonValue ageUnit,
        'sex': EJsonValue sex,
        'occupation': EJsonValue occupation,
        'address': EJsonValue address,
        'chiefComplaints': EJsonValue chiefComplaints,
        'hopi': EJsonValue hopi,
        'examinations': EJsonValue examinations,
        'diagnoses': EJsonValue diagnoses,
        'summaryOfHopi': EJsonValue summaryOfHopi,
        'suggestedQuestions': EJsonValue suggestedQuestions,
        'previousSaves': EJsonValue previousSaves,
        'suggestedTreatment': EJsonValue suggestedTreatment,
      } =>
        Patient(
          fromEJson(id),
          fromEJson(tags),
          fromEJson(name),
          fromEJson(age),
          fromEJson(ageUnit),
          fromEJson(sex),
          fromEJson(occupation),
          fromEJson(address),
          fromEJson(chiefComplaints),
          fromEJson(hopi),
          fromEJson(examinations),
          fromEJson(diagnoses),
          fromEJson(summaryOfHopi),
          fromEJson(suggestedQuestions),
          fromEJson(previousSaves),
          fromEJson(suggestedTreatment),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Patient._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, Patient, 'Patient', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('tags', RealmPropertyType.string),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('age', RealmPropertyType.double),
      SchemaProperty('ageUnit', RealmPropertyType.int),
      SchemaProperty('sex', RealmPropertyType.string),
      SchemaProperty('occupation', RealmPropertyType.string),
      SchemaProperty('address', RealmPropertyType.string),
      SchemaProperty('chiefComplaints', RealmPropertyType.string),
      SchemaProperty('hopi', RealmPropertyType.string),
      SchemaProperty('examinations', RealmPropertyType.string),
      SchemaProperty('diagnoses', RealmPropertyType.string),
      SchemaProperty('summaryOfHopi', RealmPropertyType.string),
      SchemaProperty('suggestedQuestions', RealmPropertyType.string),
      SchemaProperty('previousSaves', RealmPropertyType.string),
      SchemaProperty('suggestedTreatment', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
