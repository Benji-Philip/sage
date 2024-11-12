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
    List<Patient> temp = [];
    temp.addAll(realm.all<Patient>().query('name CONTAINS[c] \$0', [searchText]).toList());
    temp.addAll(realm.all<Patient>().query('tags CONTAINS[c] \$0', [searchText]).toList());
    temp.addAll(realm.all<Patient>().query('chiefComplaints CONTAINS[c] \$0', [searchText]).toList());
    return temp;
    
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
