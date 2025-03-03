import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sage/database/models/patient.dart';
import 'package:sage/database/test_data/temporary_patient.dart';
import 'package:sage/layouts/dropdownmenubutton_layout.dart';

class AgeDropDownMenu extends ConsumerStatefulWidget {
  const AgeDropDownMenu({super.key});

  @override
  ConsumerState<AgeDropDownMenu> createState() => _AgeUnitDropDownMenuState();
}

class _AgeUnitDropDownMenuState extends ConsumerState<AgeDropDownMenu> {
  @override
  Widget build(BuildContext context) {
    Patient patientProvider = ref.watch(temporaryPatient);
    double age = patientProvider.age;
    String ageDropDownValue = age.toStringAsFixed(0);
    return DropDownMenuButtonLayout(
                                onChanged: (newvalue) {setState(() {
                                  final temp = newvalue;
                                  age = double.parse(temp??"22");
                                  patientProvider.age = double.parse(temp??"22");
                                });
                                },
                                items: [...List.generate(200, (index) {
                                  return DropdownMenuItem(
                                      value: (index + 1).toStringAsFixed(0),
                                      child: Text(
                                        (index + 1).toStringAsFixed(0),
                                        style: TextStyle(
                                          height: 0.70,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontSize: 16,
                                        ),
                                      ));
                                })],
                                value: ageDropDownValue);
  }
}