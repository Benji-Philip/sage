import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:realm/realm.dart';
import 'package:sage/database/models/patient.dart';

final temporaryPatient = StateProvider((ref) => Patient(
    ObjectId(),
    '[]',
    "",
    22,
    0,
    "M",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    ""));

class TemporaryPatient {
  void updateTemporaryPatientProvider(WidgetRef ref, Patient patient){
    Patient tempPatient = ref.read(temporaryPatient);
    tempPatient.id = patient.id;
    tempPatient.name = patient.name;
    tempPatient.age = patient.age;
    tempPatient.ageUnit = patient.ageUnit;
    tempPatient.sex = patient.sex;
    tempPatient.address = patient.address;
    tempPatient.chiefComplaints = patient.chiefComplaints;
    tempPatient.hopi = patient.hopi;
    tempPatient.occupation = patient.occupation;
    tempPatient.examinations = patient.examinations;
    tempPatient.diagnoses = patient.diagnoses;
    tempPatient.suggestedQuestions = patient.suggestedQuestions;
    tempPatient.summaryOfHopi = patient.summaryOfHopi;
    tempPatient.tags = patient.tags;
    tempPatient.previousSaves = patient.previousSaves;
    tempPatient.suggestedTreatment = patient.suggestedTreatment;
  }
}