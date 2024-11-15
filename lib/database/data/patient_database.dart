import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:realm/realm.dart';
import 'package:sage/database/models/patient.dart';

final patientDatabaseProvider =
    StateNotifierProvider<PatientDataBaseNotifier, List<Patient>>(
        (ref) => PatientDataBaseNotifier());

class PatientDataBaseNotifier extends StateNotifier<List<Patient>> {
  PatientDataBaseNotifier() : super([]) {
    intialiseDatabase();
  }
  var config = Configuration.local([Patient.schema]);
  late var realm = Realm(config);

  // initialise
  void intialiseDatabase() {
    state = fetchPatients().reversed.toList();
  }

  // update state
  void updateState(){
    state = [];
    state = fetchPatients().reversed.toList();
  }

  // used to check if the patient details are saved before exit
  bool areDetailsSaved(){
    
    return true;
  }

  // query a patient
  Patient? getPatient (ObjectId id){
    return realm.find<Patient>(id);
  }

  // create
  void createPatient(Patient patient) {
    realm.write(() {
      realm.add(patient);
    });
    state = [patient, ...state];
  }

  //read all patients
  List<Patient> fetchPatients() {
    return realm.all<Patient>().toList();
  }

  // query by search term, case-insensitive
  List<Patient> searchPatients (String searchText){
    return (realm.all<Patient>().query('name CONTAINS[c] \$0 OR tags CONTAINS[c] \$0 OR chiefComplaints CONTAINS[c] \$0', [searchText]).toList());  
  }

  // update
  void updatePatient(Patient patient) {
    realm.write(() {
      realm.add(patient,update: true);
    });
  updateState();
  }

  // delete
  void deletePatient(Patient patient) {
    Patient? patientToDelete = realm.find<Patient>(patient.id);
    realm.write(
      () {
        realm.delete(patientToDelete!);
      },
    );
    updateState();
  }
}
