import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:realm/realm.dart';
import 'package:sage/ai/ai_controller.dart';
import 'package:sage/components/ageunitdropdownmenu.dart';
import 'package:sage/components/inputbox.dart';
import 'package:sage/components/settings_dialog.dart';
import 'package:sage/components/sexdropdownmenu.dart';
import 'package:sage/components/tags_list.dart';
import 'package:sage/database/data/patient_database.dart';
import 'package:sage/database/models/patient.dart';
import 'package:sage/database/test_data/temporary_patient.dart';
import 'package:sage/json_processing/json_processor.dart';
import 'package:sage/layouts/base_layout.dart';

class PatientPageLayout extends ConsumerStatefulWidget {
  final bool forEditing;
  const PatientPageLayout({super.key, required this.forEditing});

  @override
  ConsumerState<PatientPageLayout> createState() => _PatientPageLayoutState();
}

class _PatientPageLayoutState extends ConsumerState<PatientPageLayout> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController tagsTEC = TextEditingController();
    FocusNode cCFN = FocusNode();
    FocusNode hopiFN = FocusNode();
    FocusNode examFN = FocusNode();
    FocusNode diagnosesFN = FocusNode();
    FocusNode sQFN = FocusNode();
    FocusNode summaryFN = FocusNode();
    FocusNode treatmentFN = FocusNode();
    double width = MediaQuery.of(context).size.width;
    StateProvider<Patient> patientProvider = temporaryPatient;
    Patient patient = ref.read(patientProvider);
    ObjectId id = widget.forEditing ? patient.id : ObjectId();
    List<String> tags = JsonProcessor().jsonToTags(patient.tags);
    TextEditingController nameTEC = TextEditingController();
    String name = patient.name;
    nameTEC.text = name;
    TextEditingController ageTEC = TextEditingController();
    double age = patient.age;
    ageTEC.text = age.toStringAsFixed(0);
    TextEditingController occupationTEC = TextEditingController();
    String occupation = patient.occupation;
    occupationTEC.text = occupation;
    TextEditingController addressTEC = TextEditingController();
    String address = patient.address;
    addressTEC.text = address;
    TextEditingController chiefComplaintsTEC = TextEditingController();
    String chiefComplaints = patient.chiefComplaints;
    chiefComplaintsTEC.text = chiefComplaints;
    TextEditingController hopiTEC = TextEditingController();
    String hopi = patient.hopi;
    hopiTEC.text = hopi;
    TextEditingController examinationsTEC = TextEditingController();
    String examinations = patient.examinations;
    examinationsTEC.text = examinations;
    TextEditingController diagnosesTEC = TextEditingController();
    String diagnoses = patient.diagnoses;
    diagnosesTEC.text = diagnoses;
    TextEditingController summaryTEC = TextEditingController();
    String summaryOfHopi = patient.summaryOfHopi;
    summaryTEC.text = summaryOfHopi;
    TextEditingController suggestedQuestionsTEC = TextEditingController();
    String suggestedQuestions = patient.suggestedQuestions;
    suggestedQuestionsTEC.text = suggestedQuestions;
    String previousSaves = patient.previousSaves;
    TextEditingController suggestedTreatmentTEC = TextEditingController();
    String suggestedTreatment = patient.suggestedTreatment;
    suggestedTreatmentTEC.text = suggestedTreatment;

    return BaseLayout(
        fab: FloatingActionButton(
            child: Icon(
              Icons.save_rounded,
              color: Theme.of(context).colorScheme.tertiary,
            ),
            onPressed: () {
              HapticFeedback.lightImpact();

              if (formKey.currentState!.validate()) {
                Patient patientToAdd = Patient(
                    id,
                    jsonEncode(tags),
                    nameTEC.text,
                    double.parse(ageTEC.text),
                    ref.read(patientProvider).ageUnit,
                    ref.read(patientProvider).sex,
                    occupationTEC.text,
                    addressTEC.text,
                    chiefComplaintsTEC.text,
                    hopiTEC.text,
                    examinationsTEC.text,
                    diagnosesTEC.text,
                    summaryTEC.text,
                    suggestedQuestionsTEC.text,
                    previousSaves,
                    suggestedTreatmentTEC.text);
                if (widget.forEditing) {
                  ref
                      .read(patientDatabaseProvider.notifier)
                      .updatePatient(patientToAdd);

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      "Saved!",
                      style: TextStyle(color: Colors.green[900]),
                    ),
                    backgroundColor: Colors.green[100],
                  ));
                } else {
                  ref
                      .read(patientDatabaseProvider.notifier)
                      .createPatient(patientToAdd);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      "Added!",
                      style: TextStyle(color: Colors.green[900]),
                    ),
                    backgroundColor: Colors.green[100],
                  ));
                  Navigator.of(context).pop();
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "* cannot be empty",
                    style: TextStyle(color: Colors.redAccent[700]),
                  ),
                  backgroundColor: Colors.red[50],
                ));
              }
            }),
        children: [
          Form(
            key: formKey,
            child: SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // top icons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () {
                                HapticFeedback.lightImpact();
                                Navigator.pop(context);
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(
                                    top: 8.0, bottom: 8, right: 8),
                                child: Icon(Icons.arrow_back_ios_new_rounded),
                              )),
                          Visibility(
                            visible: widget.forEditing,
                            child: GestureDetector(
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  ref
                                      .read(patientDatabaseProvider.notifier)
                                      .deletePatient(patient);
                                  Navigator.pop(context);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.delete_rounded,
                                    color: Colors.red,
                                  ),
                                )),
                          ),
                        ],
                      ),
                      // name
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 18.0, bottom: 6, right: 4, left: 4),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: SizedBox(
                                width: width / 1.1,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.trim() == "") {
                                      return 'cannot be empty';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  controller: nameTEC,
                                  style: TextStyle(
                                    decorationColor:
                                        Theme.of(context).colorScheme.secondary,
                                    decorationThickness: 2,
                                    decoration: TextDecoration.underline,
                                    decorationStyle: TextDecorationStyle.dotted,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  decoration: const InputDecoration(
                                      hintText: "__",
                                      hintStyle:
                                          TextStyle(color: Colors.transparent),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      contentPadding: EdgeInsets.all(0)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Container(
                          height: 2,
                          width: double.infinity,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      // age
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        height: 0.70,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                    children: [
                                  const TextSpan(text: "Age "),
                                  TextSpan(
                                      text: "(y/m/d/h)",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          fontSize: 12)),
                                  const TextSpan(text: " : "),
                                ])),
                            Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        offset: const Offset(0, 5),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withOpacity(0.07),
                                        blurRadius: 10,
                                        spreadRadius: 1)
                                  ],
                                  color: Theme.of(context).colorScheme.tertiary,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 0),
                                child: IntrinsicWidth(
                                  child: TextFormField(
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value.trim() == "") {
                                        return '*';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.number,
                                    controller: ageTEC,
                                    style: TextStyle(
                                      decorationColor: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      decorationThickness: 2,
                                      decoration: TextDecoration.underline,
                                      decorationStyle:
                                          TextDecorationStyle.dotted,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontSize: 16,
                                    ),
                                    decoration: const InputDecoration(
                                        hintText: "__",
                                        hintStyle: TextStyle(
                                            color: Colors.transparent),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        contentPadding: EdgeInsets.all(0)),
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                child: AgeUnitDropDownMenu()),
                          ],
                        ),
                      ),
                      // sex
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        height: 0.70,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                    children: [
                                  const TextSpan(text: "Sex "),
                                  TextSpan(
                                      text: "(M/F/O)",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          fontSize: 12)),
                                  const TextSpan(text: " : "),
                                ])),
                            const SexDropDownMenu()
                          ],
                        ),
                      ),
                      // occupation
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4),
                        child: SizedBox(
                          width: width,
                          child: Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.start,
                            runAlignment: WrapAlignment.center,
                            children: [
                              RichText(
                                  text: TextSpan(
                                      style: TextStyle(
                                          height: 2.5,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                      children: const [
                                    TextSpan(text: "Occupation"),
                                    TextSpan(text: " : "),
                                  ])),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 0),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          offset: const Offset(0, 5),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(0.07),
                                          blurRadius: 10,
                                          spreadRadius: 1)
                                    ],
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15))),
                                child: IntrinsicWidth(
                                  child: Container(
                                    constraints:
                                        BoxConstraints(maxWidth: width / 1.1),
                                    child: TextField(
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      controller: occupationTEC,
                                      style: TextStyle(
                                        decorationColor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        decorationThickness: 2,
                                        decoration: TextDecoration.underline,
                                        decorationStyle:
                                            TextDecorationStyle.dotted,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontSize: 16,
                                      ),
                                      decoration: const InputDecoration(
                                          hintText: "__",
                                          hintStyle: TextStyle(
                                              color: Colors.transparent),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                          contentPadding: EdgeInsets.all(0)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // address
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4),
                        child: SizedBox(
                          width: width,
                          child: Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.start,
                            runAlignment: WrapAlignment.center,
                            children: [
                              RichText(
                                  text: TextSpan(
                                      style: TextStyle(
                                          height: 2.5,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                      children: const [
                                    TextSpan(text: "Address"),
                                    TextSpan(text: " : "),
                                  ])),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 0),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          offset: const Offset(0, 5),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(0.07),
                                          blurRadius: 10,
                                          spreadRadius: 1)
                                    ],
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15))),
                                child: IntrinsicWidth(
                                  child: Container(
                                    constraints:
                                        BoxConstraints(maxWidth: width / 1.1),
                                    child: TextField(
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      controller: addressTEC,
                                      style: TextStyle(
                                        decorationColor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        decorationThickness: 2,
                                        decoration: TextDecoration.underline,
                                        decorationStyle:
                                            TextDecorationStyle.dotted,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontSize: 16,
                                      ),
                                      decoration: const InputDecoration(
                                          hintText: "__",
                                          hintStyle: TextStyle(
                                              color: Colors.transparent),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                          contentPadding: EdgeInsets.all(0)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // tags
                      Consumer(builder: (context, ref, child) {
                        bool updateThisTagsListUi = ref.watch(updateTagsListUi);
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 18.0),
                          child: TagsList(
                            onTap: () {
                              HapticFeedback.lightImpact();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  "hold to delete",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surface),
                                ),
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                              ));
                            },
                            onLongPress: () {
                              tags.removeAt(ref.read(tagsListIndex));
                              ref
                                  .read(updateTagsListUi.notifier)
                                  .update((state) => !updateThisTagsListUi);
                            },
                            tagsTEC: tagsTEC,
                            onFieldSubmitted: (value) {
                              if (value != null) {
                                if (value.trim() != "" &&
                                    !tags.contains(value)) {
                                  tags.add(value);
                                  tagsTEC.clear();
                                  ref
                                      .read(updateTagsListUi.notifier)
                                      .update((state) => !updateThisTagsListUi);
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      "Invalid or duplicate",
                                      style: TextStyle(color: Colors.red[900]),
                                    ),
                                    backgroundColor: Colors.red[100],
                                  ));
                                }
                              }
                            },
                            ableToAddTag: true,
                            tags: tags,
                            verticalDirection: VerticalDirection.down,
                          ),
                        );
                      }),
                      // chief complaints
                      InputBox(
                        hintColor: Theme.of(context).colorScheme.secondary,
                        hintText: "(complaint) for (duration)",
                        focusNode: cCFN,
                        title: "Chief Complaints",
                        tec: chiefComplaintsTEC,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.trim() == "") {
                            return '*';
                          }
                          return null;
                        },
                      ),
                      // hopi
                      Visibility(
                        visible: widget.forEditing,
                        child: InputBox(
                          buttonOneIcon: Icon(
                                      Icons.generating_tokens_outlined,
                                      color: Theme.of(context).colorScheme.tertiary,
                                      size: 20,
                                    ),
                          focusNode: hopiFN,
                          onButtonOneTap: () async {
                            HapticFeedback.lightImpact();
                            hopiTEC.text = "refactoring history .......";
                            hopiTEC.text = await AiController()
                                .refactorHistory(ref, patient);
                          },
                          onButtonTwoTap: () {
                            HapticFeedback.lightImpact();
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const SettingsDialog();
                                });
                          },
                          title: "History Of Chief Complaints",
                          tec: hopiTEC,
                          validator: (value) {
                            if (widget.forEditing) {
                              if (value == null ||
                                value.isEmpty ||
                                value.trim() == "") {
                              return '*';
                            }
                            }
                            return null;
                          },
                        ),
                      ),
                      // examinations
                      Visibility(
                        visible: widget.forEditing,
                        child: InputBox(
                          buttonOneIcon: Icon(
                                      Icons.generating_tokens_outlined,
                                      color: Theme.of(context).colorScheme.tertiary,
                                      size: 20,
                                    ),
                          focusNode: examFN,
                          onButtonOneTap: () async {
                            HapticFeedback.lightImpact();
                            examinationsTEC.text="refactoring examinations........";
                            examinationsTEC.text = await AiController()
                                .refactorExaminations(ref, patient);
                          },
                          onButtonTwoTap: () {
                            HapticFeedback.lightImpact();
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const SettingsDialog();
                                });
                          },
                          title: "Examinations",
                          tec: examinationsTEC,
                        ),
                      ),
                      // diagnoses
                      Visibility(
                        visible: widget.forEditing,
                        child: InputBox(
                          focusNode: diagnosesFN,
                          onButtonOneTap: () async {
                            HapticFeedback.lightImpact();
                            diagnosesTEC.text = "generating diagnoses.......";
                            diagnosesTEC.text = await AiController()
                                .generateDiagnoses(ref, patient);
                          },
                          onButtonTwoTap: () {
                            HapticFeedback.lightImpact();
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const SettingsDialog();
                                });
                          },
                          title: "Diagnoses",
                          tec: diagnosesTEC,
                        ),
                      ),
                      // suggested questions
                      Visibility(
                        visible: widget.forEditing,
                        child: InputBox(
                          focusNode: sQFN,
                          onButtonOneTap: () async {
                            HapticFeedback.lightImpact();
                            suggestedQuestionsTEC.text = "generating suggested questings..........";
                            suggestedQuestionsTEC.text = await AiController()
                                .generateSuggestedQuestions(ref, patient);
                          },
                          onButtonTwoTap: () {
                            HapticFeedback.lightImpact();
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const SettingsDialog();
                                });
                          },
                          title: "Suggested Questions",
                          tec: suggestedQuestionsTEC,
                        ),
                      ),
                      // summary of hopi
                      Visibility(
                        visible: widget.forEditing,
                        child: InputBox(
                          focusNode: summaryFN,
                          onButtonOneTap: () async {
                            HapticFeedback.lightImpact();
                            summaryTEC.text = "generating summary......";
                            summaryTEC.text = await AiController()
                                .generateSummary(ref, patient);
                          },
                          onButtonTwoTap: () {
                            HapticFeedback.lightImpact();
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const SettingsDialog();
                                });
                          },
                          title: "Summary",
                          tec: summaryTEC,
                        ),
                      ),
                      // suggested treatment
                      Visibility(
                        visible: widget.forEditing,
                        child: InputBox(
                          focusNode: treatmentFN,
                          onButtonOneTap: () async {
                            HapticFeedback.lightImpact();
                            suggestedTreatmentTEC.text = "generating suggested treatment/management........";
                            suggestedTreatmentTEC.text = await AiController()
                                .generateTreatments(ref, patient);
                          },
                          onButtonTwoTap: () {
                            HapticFeedback.lightImpact();
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const SettingsDialog();
                                });
                          },
                          title: "Suggested Treatment",
                          tec: suggestedTreatmentTEC,
                        ),
                      ),
                      const SizedBox(
                        height: 200,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ]);
  }
}
