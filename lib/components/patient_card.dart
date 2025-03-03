import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sage/components/tags_list.dart';
import 'package:sage/database/models/patient.dart';
import 'package:sage/database/test_data/temporary_patient.dart';
import 'package:sage/json_processing/json_processor.dart';
import 'package:sage/layouts/patient_page_layout.dart';
import 'package:sage/pages/edit_patient_page.dart';

class PatientCard extends ConsumerWidget {
  final Patient patient;
  const PatientCard({
    super.key,
    required this.patient,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> tags = JsonProcessor().jsonToList(patient.tags);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
            ref.read(forAddingProvider.notifier).update((state)=>false);
            ref.read(includeExaminations.notifier).update((state)=>false);
            ref.read(includeInvestigations.notifier).update((state)=>false);
          TemporaryPatient().updateTemporaryPatientProvider(ref, patient);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EditPatientPage(forAdding: false,)),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 5),
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.08),
                    blurRadius: 10,
                    spreadRadius: 1)
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 18.0,bottom: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text(patient.name,
                                  style: TextStyle(
                                      height: 0.92,
                                      color: Theme.of(context).colorScheme.primary,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700)),
                            ),
                            RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        height: 0.70,
                                        color:
                                            Theme.of(context).colorScheme.secondary,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                    children: [
                                  const TextSpan(text: " "),
                                  TextSpan(text: patient.sex),
                                  const TextSpan(text: "  "),
                                  TextSpan(text: patient.age.toStringAsFixed(0)),
                                  TextSpan(
                                      text: patient.ageUnit == 0
                                          ? "y"
                                          : patient.ageUnit == 1
                                              ? "m"
                                              : patient.ageUnit == 2
                                                  ? "d"
                                                  : patient.ageUnit == 3
                                                      ? "hrs"
                                                      : " "),
                                ]))
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0,left: 2),
                          child: Row(
                            children: [
                              Container(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width / 1.2),
                                child: Text(patient.hopi,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color:
                                            Theme.of(context).colorScheme.primary,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: JsonProcessor().jsonToList(patient.tags).isEmpty? 0.0 : 8.0),
                      child: TagsList(
                        verticalDirection: VerticalDirection.down,
                        tags: tags,
                        ableToAddTag: false,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
