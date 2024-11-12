import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sage/components/patient_card.dart';
import 'package:sage/components/searchbar.dart';
import 'package:sage/components/settings_dialog.dart';
import 'package:sage/database/data/patient_database.dart';
import 'package:sage/database/data/settings_database.dart';
import 'package:sage/database/models/patient.dart';
import 'package:sage/database/test_data/template_patient.dart';
import 'package:sage/database/test_data/temporary_patient.dart';
import 'package:sage/layouts/base_layout.dart';
import 'package:sage/pages/add_patient_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
  TextEditingController searchTEC = TextEditingController();
    List<Patient> patients = ref.watch(patientDatabaseProvider);
    double screenWidth = MediaQuery.of(context).size.width;
    return BaseLayout(
      fab: FloatingActionButton(
          child: Icon(
            Icons.add_rounded,
            color: Theme.of(context).colorScheme.tertiary,
          ),
          onPressed: () {
            HapticFeedback.lightImpact();
            TemporaryPatient()
                .updateTemporaryPatientProvider(ref, ref.read(templatePatient));
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddPatientPage()),
            );
          }),
      children: [
        SliverToBoxAdapter(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // top row
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const SettingsDialog();
                              });
                        },
                        child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, bottom: 8, right: 8, left: 8),
                            child: ref
                                            .watch(settingsDatabaseProvider)[0]
                                            .value
                                            .trim() ==
                                        "" &&
                                    ref
                                            .watch(settingsDatabaseProvider)[1]
                                            .value
                                            .trim() ==
                                        ""
                                ? const Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  )
                                : Icon(
                                    Icons.settings,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ))),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, bottom: 8),
                child: Text(
                  'Patients',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0, top: 10),
                child: Searchbar(screenWidth: screenWidth, searchTEC: searchTEC,onChanged: (p0) {
                  
                },),
              ),
            ],
          ),
        ),
        SliverList.builder(
            itemCount: patients.length,
            itemBuilder: (context, index) {
              return PatientCard(
                  patient: Patient(
                      patients[index].id,
                      patients[index].tags,
                      patients[index].name,
                      patients[index].age,
                      patients[index].ageUnit,
                      patients[index].sex,
                      patients[index].occupation,
                      patients[index].address,
                      patients[index].chiefComplaints,
                      patients[index].hopi,
                      patients[index].examinations,
                      patients[index].diagnoses,
                      patients[index].summaryOfHopi,
                      patients[index].suggestedQuestions,
                      patients[index].previousSaves,
                      patients[index].suggestedTreatment));
            }),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 100,
          ),
        )
      ],
    );
  }
}
