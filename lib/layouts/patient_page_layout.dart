import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:realm/realm.dart';
import 'package:sage/ai/ai_controller.dart';
import 'package:sage/components/age_dropdown.dart';
import 'package:sage/components/ageunitdropdownmenu.dart';
import 'package:sage/components/confirm_dialog.dart';
import 'package:sage/components/inputbox.dart';
import 'package:sage/components/settings_dialog.dart';
import 'package:sage/components/sexdropdownmenu.dart';
import 'package:sage/components/tags_list.dart';
import 'package:sage/database/data/patient_database.dart';
import 'package:sage/database/models/patient.dart';
import 'package:sage/database/test_data/temporary_patient.dart';
import 'package:sage/json_processing/json_processor.dart';
import 'package:sage/layouts/base_layout.dart';

final forAddingProvider = StateProvider((state) => false);

final updateTagsListUi = StateProvider((ref) => true);
final updateOnGenerate = StateProvider((ref) => true);
final includeExaminations = StateProvider((state) => false);
final includeInvestigations = StateProvider((state) => false);

class PatientPageLayout extends ConsumerStatefulWidget {
  final bool forAdding;
  const PatientPageLayout({super.key, required this.forAdding});

  @override
  ConsumerState<PatientPageLayout> createState() => _PatientPageLayoutState();
}

class _PatientPageLayoutState extends ConsumerState<PatientPageLayout> {
  late bool forAdding;

  final TextEditingController tagsTEC = TextEditingController();

  final TextEditingController nameTEC = TextEditingController();

  final TextEditingController ageTEC = TextEditingController();

  final TextEditingController occupationTEC = TextEditingController();

  final TextEditingController addressTEC = TextEditingController();

  final TextEditingController chiefComplaintsTEC = TextEditingController();

  final TextEditingController hopiTEC = TextEditingController();

  final TextEditingController examinationsTEC = TextEditingController();

  final TextEditingController investigationsTEC = TextEditingController();

  final TextEditingController diagnosesTEC = TextEditingController();

  final TextEditingController summaryTEC = TextEditingController();

  final TextEditingController suggestedQuestionsTEC = TextEditingController();

  final TextEditingController suggestedTreatmentTEC = TextEditingController();

  final FocusNode cCFN = FocusNode();

  final FocusNode hopiFN = FocusNode();

  final FocusNode examFN = FocusNode();

  final FocusNode investigationsFN = FocusNode();

  final FocusNode diagnosesFN = FocusNode();

  final FocusNode sQFN = FocusNode();

  final FocusNode summaryFN = FocusNode();

  final FocusNode treatmentFN = FocusNode();

  final FocusNode tagsFN = FocusNode();

  final formKey = GlobalKey<FormState>();

  StateProvider<Patient> patientProvider = temporaryPatient;
  late ObjectId id;
  late List<String> tags;
  late String name;
  late double age;
  late String occupation;
  late String address;
  late String chiefComplaints;
  late String hopi;
  late String examinations;
  late String investigations;
  late String diagnoses;
  late String summaryOfHopi;
  late String suggestedQuestions;
  late String previousSaves;
  late String suggestedTreatment;
  late Patient patient;
  @override
  void initState() {
    super.initState();
    forAdding = widget.forAdding;
    patient = ref.read(patientProvider);
    id = patient.id;
    tags = JsonProcessor().jsonToList(patient.tags);
    name = patient.name;
    nameTEC.text = name;
    age = patient.age;
    ageTEC.text = age.toStringAsFixed(0);
    occupation = patient.occupation;
    occupationTEC.text = occupation;
    address = patient.address;
    addressTEC.text = address;
    chiefComplaints = patient.chiefComplaints;
    chiefComplaintsTEC.text = chiefComplaints;
    hopi = patient.hopi;
    hopiTEC.text = hopi;
    examinations = patient.examinations;
    examinationsTEC.text = examinations;
    investigations = patient.investigations;
    investigationsTEC.text = investigations;
    diagnoses = patient.diagnoses;
    diagnosesTEC.text = diagnoses;
    summaryOfHopi = patient.summaryOfHopi;
    summaryTEC.text = summaryOfHopi;
    suggestedQuestions = patient.suggestedQuestions;
    suggestedQuestionsTEC.text = suggestedQuestions;
    previousSaves = patient.previousSaves;
    suggestedTreatment = patient.suggestedTreatment;
    suggestedTreatmentTEC.text = suggestedTreatment;
    tagsFN.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (!tagsFN.hasFocus) {
      if (tagsTEC.text.trim() != "" && !tags.contains(tagsTEC.text)) {
        tags.add(tagsTEC.text);
        tagsTEC.clear();
        ref
            .read(updateTagsListUi.notifier)
            .update((state) => !ref.read(updateTagsListUi));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Invalid or duplicate",
            style: TextStyle(color: Colors.red[900]),
          ),
          backgroundColor: Colors.red[100],
        ));
      }
    }
  }

  @override
  void dispose() {
    tagsTEC.dispose();

    nameTEC.dispose();

    ageTEC.dispose();

    occupationTEC.dispose();

    addressTEC.dispose();

    chiefComplaintsTEC.dispose();

    hopiTEC.dispose();

    examinationsTEC.dispose();

    investigationsTEC.dispose();

    diagnosesTEC.dispose();

    summaryTEC.dispose();

    suggestedQuestionsTEC.dispose();

    suggestedTreatmentTEC.dispose();

    cCFN.dispose();

    hopiFN.dispose();

    examFN.dispose();

    diagnosesFN.dispose();

    sQFN.dispose();

    summaryFN.dispose();

    treatmentFN.dispose;
    super.dispose();
  }

  void checkIfPatientDetailsAreSaved() {
    Patient patient = Patient(
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
        investigationsTEC.text,
        diagnosesTEC.text,
        summaryTEC.text,
        suggestedQuestionsTEC.text,
        previousSaves,
        suggestedTreatmentTEC.text);
    Patient? patientToCheck =
        ref.read(patientDatabaseProvider.notifier).getPatient(id);
    if (ref
        .read(patientDatabaseProvider.notifier)
        .isPatientInfoSaved(patient, patientToCheck) && forAdding == false) {
      Navigator.pop(context);
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return ConfirmDialog(
                confirmButtonText: "Exit",
                title: "You've made changes",
                description: "Are you sure you want to exit without saving?",
                onConfirm: () {
                  HapticFeedback.lightImpact();
                  if (forAdding) {
                    ref
                        .read(patientDatabaseProvider.notifier)
                        .deletePatient(patient);
                  }
                  Navigator.pop(context);
                  Navigator.pop(context);
                });
          });
    }
  }

  void savePatientDetails() {
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
          investigationsTEC.text,
          diagnosesTEC.text,
          summaryTEC.text,
          suggestedQuestionsTEC.text,
          previousSaves,
          suggestedTreatmentTEC.text);
      ref.read(patientDatabaseProvider.notifier).updatePatient(patientToAdd);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Saved changes",
          style: TextStyle(color: Colors.green[900]),
        ),
        backgroundColor: Colors.green[100],
      ));
      forAdding = false;
      ref.read(forAddingProvider.notifier).update((state) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "* cannot be empty",
          style: TextStyle(color: Colors.redAccent[700]),
        ),
        backgroundColor: Colors.red[50],
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            return;
          }
          HapticFeedback.lightImpact();
          checkIfPatientDetailsAreSaved();
        },
        child: LayoutBuilder(builder: (contex, constraints) {
          double width = constraints.maxWidth;
          return BaseLayout(
              fab: FloatingActionButton(
                  child: Icon(
                    Icons.save_rounded,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    savePatientDetails();
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
                                      checkIfPatientDetailsAreSaved();
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                          top: 8.0, bottom: 8, right: 8),
                                      child: Icon(
                                          Icons.arrow_back_ios_new_rounded),
                                    )),
                                Consumer(builder: (context, ref, child) {
                                  final invisible =
                                      ref.watch(forAddingProvider);
                                  return Visibility(
                                    visible: !invisible,
                                    child: GestureDetector(
                                        onTap: () {
                                          HapticFeedback.lightImpact();
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return ConfirmDialog(
                                                  confirmButtonText: "Delete",
                                                  title: "Delete",
                                                  description:
                                                      "Are you sure you want to delete?",
                                                  onConfirm: () {
                                                    HapticFeedback
                                                        .lightImpact();
                                                    ref
                                                        .read(
                                                            patientDatabaseProvider
                                                                .notifier)
                                                        .deletePatient(patient);
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                      content: const Text(
                                                        "Deleted Patient",
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      ),
                                                      backgroundColor:
                                                          Colors.red[100],
                                                    ));
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                  },
                                                );
                                              });
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.delete_rounded,
                                            color: Colors.red,
                                          ),
                                        )),
                                  );
                                }),
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
                                          fontSize: 28,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: "John Doe",
                                          hintStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary),
                                          border: const OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                        ),
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
                                  const AgeDropDownMenu(),
                                  const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      child: AgeUnitDropDownMenu()),
                                ],
                              ),
                            ),
                            // sex
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
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
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(15))),
                                      child: IntrinsicWidth(
                                        child: Container(
                                          constraints: BoxConstraints(
                                              maxWidth: width / 1.1),
                                          child: TextField(
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            controller: occupationTEC,
                                            style: TextStyle(
                                              decorationColor: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              decorationThickness: 2,
                                              decoration:
                                                  TextDecoration.underline,
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
                                                    borderSide:
                                                        BorderSide.none),
                                                contentPadding:
                                                    EdgeInsets.all(0)),
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
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(15))),
                                      child: IntrinsicWidth(
                                        child: Container(
                                          constraints: BoxConstraints(
                                              maxWidth: width / 1.1),
                                          child: TextField(
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            controller: addressTEC,
                                            style: TextStyle(
                                              decorationColor: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              decorationThickness: 2,
                                              decoration:
                                                  TextDecoration.underline,
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
                                                    borderSide:
                                                        BorderSide.none),
                                                contentPadding:
                                                    EdgeInsets.all(0)),
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
                              bool updateThisTagsListUi =
                                  ref.watch(updateTagsListUi);
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 18.0),
                                child: TagsList(
                                  focusNode: tagsFN,
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
                                    ref.read(updateTagsListUi.notifier).update(
                                        (state) => !updateThisTagsListUi);
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
                                            .update((state) =>
                                                !updateThisTagsListUi);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                            "Invalid or duplicate",
                                            style: TextStyle(
                                                color: Colors.red[900]),
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
                            // hopi
                            InputBox(
                              hintColor:
                                  Theme.of(context).colorScheme.secondary,
                              hintText: "enter history to be refactored",
                              buttonOneIcon: Icon(
                                Icons.generating_tokens_outlined,
                                color: Theme.of(context).colorScheme.tertiary,
                                size: 20,
                              ),
                              focusNode: hopiFN,
                              onButtonOneTap: () async {
                                HapticFeedback.lightImpact();
                                final history = hopiTEC.text;
                                hopiTEC.text = "refactoring history .......";
                                hopiTEC.text = await AiController()
                                    .refactorHistory(ref, history);
                              },
                              onButtonTwoTap: () {
                                HapticFeedback.lightImpact();
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const SettingsDialog();
                                    });
                              },
                              title: "History",
                              tec: hopiTEC,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.trim() == "") {
                                  return '*';
                                }
                                return null;
                              },
                            ),
                            // include examinations button
                            Visibility(
                              visible:
                                  ref.watch(includeExaminations) == false &&
                                      examinationsTEC.text == "",
                              child: Consumer(builder: (context, ref, child) {
                                return GestureDetector(
                                  onTap: () {
                                    HapticFeedback.lightImpact();
                                    ref
                                        .read(includeExaminations.notifier)
                                        .update((state) => true);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Flex(
                                      direction: Axis.horizontal,
                                      children: [
                                        Icon(
                                          Icons.add_box_rounded,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Include Examinations",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                            // examinations
                            Consumer(builder: (context, ref, child) {
                              // ignore: unused_local_variable
                              var localvar = ref.watch(updateOnGenerate);
                              return Visibility(
                                visible:
                                    ref.watch(includeExaminations) == true ||
                                        examinationsTEC.text != "",
                                child: InputBox(
                                  hintColor:
                                      Theme.of(context).colorScheme.secondary,
                                  hintText:
                                      "enter examinations to be refactored",
                                  buttonOneIcon: Icon(
                                    Icons.generating_tokens_outlined,
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    size: 20,
                                  ),
                                  focusNode: examFN,
                                  onButtonOneTap: () async {
                                    HapticFeedback.lightImpact();
                                    final examinations = examinationsTEC.text;
                                    examinationsTEC.text =
                                        "refactoring examinations........";
                                    examinationsTEC.text = await AiController()
                                        .refactorExaminations(
                                            ref, examinations);
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
                              );
                            }),
                            // include investigations button
                            Visibility(
                              visible:
                                  ref.watch(includeInvestigations) == false &&
                                      investigationsTEC.text == "",
                              child: Consumer(builder: (context, ref, child) {
                                return GestureDetector(
                                  onTap: () {
                                    HapticFeedback.lightImpact();
                                    ref
                                        .read(includeInvestigations.notifier)
                                        .update((state) => true);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Flex(
                                      direction: Axis.horizontal,
                                      children: [
                                        Icon(
                                          Icons.add_box_rounded,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Include Investigations",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                            // investigations
                            Consumer(builder: (context, ref, child) {
                              // ignore: unused_local_variable
                              var localvar = ref.watch(updateOnGenerate);
                              return Visibility(
                                visible:
                                    ref.watch(includeInvestigations) == true ||
                                        investigationsTEC.text != "",
                                child: InputBox(
                                  hintColor:
                                      Theme.of(context).colorScheme.secondary,
                                  hintText:
                                      "enter investigations to be refactored",
                                  buttonOneIcon: Icon(
                                    Icons.generating_tokens_outlined,
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    size: 20,
                                  ),
                                  focusNode: investigationsFN,
                                  onButtonOneTap: () async {
                                    HapticFeedback.lightImpact();
                                    final investigations =
                                        investigationsTEC.text;
                                    investigationsTEC.text =
                                        "refactoring investigations........";
                                    investigationsTEC.text =
                                        await AiController()
                                            .refactorInvestigations(
                                                ref, investigations);
                                  },
                                  onButtonTwoTap: () {
                                    HapticFeedback.lightImpact();
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const SettingsDialog();
                                        });
                                  },
                                  title: "Investigations",
                                  tec: investigationsTEC,
                                ),
                              );
                            }),
                            // generate button
                            Consumer(builder: (context, ref, child) {
                              // ignore: unused_local_variable
                              var localvar = ref.watch(updateOnGenerate);
                              return Visibility(
                                visible: diagnosesTEC.text == "",
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          HapticFeedback.lightImpact();
                                          diagnosesTEC.text =
                                              "generating diagnoses.......";
                                          ref
                                              .read(updateOnGenerate.notifier)
                                              .update((state) =>
                                                  !ref.read(updateOnGenerate));
                                          diagnosesTEC.text =
                                              await AiController()
                                                  .generateDiagnoses(
                                                      ref,
                                                      ref
                                                          .read(patientProvider)
                                                          .sex,
                                                      double.parse(ageTEC.text),
                                                      ref
                                                          .read(patientProvider)
                                                          .ageUnit,
                                                      occupationTEC.text,
                                                      hopiTEC.text,
                                                      examinationsTEC.text,
                                                      investigationsTEC.text);
                                          suggestedQuestionsTEC.text =
                                              "generating suggested questings..........";
                                          ref
                                              .read(updateOnGenerate.notifier)
                                              .update((state) =>
                                                  !ref.read(updateOnGenerate));
                                          suggestedQuestionsTEC.text =
                                              await AiController()
                                                  .generateSuggestedQuestions(
                                                      ref,
                                                      ref
                                                          .read(patientProvider)
                                                          .sex,
                                                      double.parse(ageTEC.text),
                                                      ref
                                                          .read(patientProvider)
                                                          .ageUnit,
                                                      occupationTEC.text,
                                                      hopiTEC.text,
                                                      examinationsTEC.text,
                                                      investigationsTEC.text);
                                          suggestedTreatmentTEC.text =
                                              "generating suggested treatment/management........";
                                          ref
                                              .read(updateOnGenerate.notifier)
                                              .update((state) =>
                                                  !ref.read(updateOnGenerate));
                                          suggestedTreatmentTEC.text =
                                              await AiController()
                                                  .generateTreatments(
                                                      ref,
                                                      ref
                                                          .read(patientProvider)
                                                          .sex,
                                                      double.parse(ageTEC.text),
                                                      ref
                                                          .read(patientProvider)
                                                          .ageUnit,
                                                      occupationTEC.text,
                                                      hopiTEC.text,
                                                      examinationsTEC.text,
                                                      investigationsTEC.text);
                                          summaryTEC.text =
                                              "generating summary......";
                                          ref
                                              .read(updateOnGenerate.notifier)
                                              .update((state) =>
                                                  !ref.read(updateOnGenerate));
                                          summaryTEC.text = await AiController()
                                              .generateSummary(
                                                  ref,
                                                  ref.read(patientProvider).sex,
                                                  double.parse(ageTEC.text),
                                                  ref
                                                      .read(patientProvider)
                                                      .ageUnit,
                                                  occupationTEC.text,
                                                  hopiTEC.text,
                                                  examinationsTEC.text,
                                                  investigationsTEC.text);
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(12)),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0, horizontal: 20),
                                            child: Flex(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              direction: Axis.horizontal,
                                              children: [
                                                Text(
                                                  "Generate",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .surface,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 18),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Icon(
                                                  Icons.auto_awesome_rounded,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .surface,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                            // diagnoses
                            Consumer(builder: (context, ref, child) {
                              // ignore: unused_local_variable
                              var localvar = ref.watch(updateOnGenerate);
                              return Visibility(
                                visible: diagnosesTEC.text != "",
                                child: InputBox(
                                  hintColor:
                                      Theme.of(context).colorScheme.secondary,
                                  hintText: "..............................",
                                  focusNode: diagnosesFN,
                                  onButtonOneTap: () async {
                                    HapticFeedback.lightImpact();
                                    diagnosesTEC.text =
                                        "generating diagnoses.......";
                                    diagnosesTEC.text = await AiController()
                                        .generateDiagnoses(
                                            ref,
                                            ref.read(patientProvider).sex,
                                            double.parse(ageTEC.text),
                                            ref.read(patientProvider).ageUnit,
                                            occupationTEC.text,
                                            hopiTEC.text,
                                            examinationsTEC.text,
                                            investigationsTEC.text);
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
                              );
                            }),
                            // suggested questions
                            Consumer(builder: (context, ref, child) {
                              // ignore: unused_local_variable
                              var localvar = ref.watch(updateOnGenerate);
                              return Visibility(
                                visible: suggestedQuestionsTEC.text != "",
                                child: InputBox(
                                  hintColor:
                                      Theme.of(context).colorScheme.secondary,
                                  hintText: "..............................",
                                  focusNode: sQFN,
                                  onButtonOneTap: () async {
                                    HapticFeedback.lightImpact();
                                    suggestedQuestionsTEC.text =
                                        "generating suggested questings..........";
                                    suggestedQuestionsTEC.text =
                                        await AiController()
                                            .generateSuggestedQuestions(
                                                ref,
                                                ref.read(patientProvider).sex,
                                                double.parse(ageTEC.text),
                                                ref
                                                    .read(patientProvider)
                                                    .ageUnit,
                                                occupationTEC.text,
                                                hopiTEC.text,
                                                examinationsTEC.text,
                                                investigationsTEC.text);
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
                              );
                            }),
                            // suggested treatment
                            Consumer(builder: (context, ref, child) {
                              // ignore: unused_local_variable
                              var localvar = ref.watch(updateOnGenerate);
                              return Visibility(
                                visible: suggestedTreatmentTEC.text != "",
                                child: InputBox(
                                  hintColor:
                                      Theme.of(context).colorScheme.secondary,
                                  hintText: "..............................",
                                  focusNode: treatmentFN,
                                  onButtonOneTap: () async {
                                    HapticFeedback.lightImpact();
                                    suggestedTreatmentTEC.text =
                                        "generating suggested treatment/management........";
                                    suggestedTreatmentTEC.text =
                                        await AiController().generateTreatments(
                                            ref,
                                            ref.read(patientProvider).sex,
                                            double.parse(ageTEC.text),
                                            ref.read(patientProvider).ageUnit,
                                            occupationTEC.text,
                                            hopiTEC.text,
                                            examinationsTEC.text,
                                            investigationsTEC.text);
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
                              );
                            }),
                            // summary of hopi
                            Consumer(builder: (context, ref, child) {
                              // ignore: unused_local_variable
                              var localvar = ref.watch(updateOnGenerate);
                              return Visibility(
                                visible: summaryTEC.text != "",
                                child: InputBox(
                                  hintColor:
                                      Theme.of(context).colorScheme.secondary,
                                  hintText: "tap button to generate summary",
                                  focusNode: summaryFN,
                                  onButtonOneTap: () async {
                                    HapticFeedback.lightImpact();
                                    summaryTEC.text =
                                        "generating summary......";
                                    summaryTEC.text = await AiController()
                                        .generateSummary(
                                            ref,
                                            ref.read(patientProvider).sex,
                                            double.parse(ageTEC.text),
                                            ref.read(patientProvider).ageUnit,
                                            occupationTEC.text,
                                            hopiTEC.text,
                                            examinationsTEC.text,
                                            investigationsTEC.text);
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
                              );
                            }),
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
        }),
      );
    });
  }
}
