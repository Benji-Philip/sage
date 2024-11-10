import 'package:realm/realm.dart';

part 'patient.realm.dart';

@RealmModel()
class _Patient {
  @PrimaryKey()
  late ObjectId id;

  late String tags;
  late String name;
  late double age;
  late int ageUnit; // 0 = years, 1 = months, 2 = days, 3 = hours
  late String sex;
  late String occupation;
  late String address;
  late String chiefComplaints;
  late String hopi;
  late String examinations;
  late String diagnoses;
  late String summaryOfHopi;
  late String suggestedQuestions;
  late String previousSaves;
  late String suggestedTreatment; // saves previous patient history for when undo/redo is needed
}