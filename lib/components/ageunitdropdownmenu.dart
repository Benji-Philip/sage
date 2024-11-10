import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sage/database/models/patient.dart';
import 'package:sage/database/test_data/temporary_patient.dart';
import 'package:sage/layouts/dropdownmenubutton_layout.dart';

class AgeUnitDropDownMenu extends ConsumerStatefulWidget {
  const AgeUnitDropDownMenu({super.key});

  @override
  ConsumerState<AgeUnitDropDownMenu> createState() => _AgeUnitDropDownMenuState();
}

class _AgeUnitDropDownMenuState extends ConsumerState<AgeUnitDropDownMenu> {
  @override
  Widget build(BuildContext context) {
    Patient patientProvider = ref.watch(temporaryPatient);
    int ageUnit = patientProvider.ageUnit;
    String ageDropDownValue = ageUnit == 0
        ? "years"
        : ageUnit == 1
            ? "months"
            : ageUnit == 2
                ? "days"
                : ageUnit == 3
                    ? "hours"
                    : "";
    return DropDownMenuButtonLayout(
                                onChanged: (newvalue) {setState(() {
                                  
                                  final temp = newvalue == "years"
                                      ? 0
                                      : newvalue == "months"
                                          ? 1
                                          : newvalue == "days"
                                              ? 2
                                              : newvalue == "hours"
                                                  ? 3
                                                  : 0;
                                  ageUnit = temp;
                                  patientProvider.ageUnit = temp;
                                });
                                },
                                items: [
                                  DropdownMenuItem(
                                      value: "years",
                                      child: Text(
                                        "years",
                                        style: TextStyle(
                                          height: 0.70,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontSize: 16,
                                        ),
                                      )),
                                  DropdownMenuItem(
                                      value: "months",
                                      child: Text(
                                        "months",
                                        style: TextStyle(
                                          height: 0.70,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontSize: 16,
                                        ),
                                      )),
                                  DropdownMenuItem(
                                      value: "days",
                                      child: Text(
                                        "days",
                                        style: TextStyle(
                                          height: 0.70,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontSize: 16,
                                        ),
                                      )),
                                  DropdownMenuItem(
                                      value: "hours",
                                      child: Text(
                                        "hours",
                                        style: TextStyle(
                                          height: 0.70,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontSize: 16,
                                        ),
                                      )),
                                ],
                                value: ageDropDownValue);
  }
}