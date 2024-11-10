import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sage/database/models/patient.dart';
import 'package:sage/database/test_data/temporary_patient.dart';
import 'package:sage/layouts/dropdownmenubutton_layout.dart';

class SexDropDownMenu extends ConsumerStatefulWidget {
  const SexDropDownMenu({super.key});

  @override
  ConsumerState<SexDropDownMenu> createState() => _SexDropDownMenuState();
}

class _SexDropDownMenuState extends ConsumerState<SexDropDownMenu> {
  @override
  Widget build(BuildContext context) {
    Patient patientProvider = ref.watch(temporaryPatient);
    String sex = patientProvider.sex;
    String sexDropDownValue = sex == "M"
        ? "male"
        : sex == "F"
            ? "female"
            : sex == "O"
                ? "other"
                : "";
    return DropDownMenuButtonLayout(
        onChanged: (newvalue) {
          setState(() {
            final temp = newvalue == "male"
                ? "M"
                : newvalue == "female"
                    ? "F"
                    : newvalue == "other"
                        ? "O"
                        : "";
            sex = temp;
            patientProvider.sex = temp;
          });
        },
        items: [
          DropdownMenuItem(
              value: "male",
              child: Text(
                "male",
                style: TextStyle(
                  height: 0.70,
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                ),
              )),
          DropdownMenuItem(
              value: "female",
              child: Text(
                "female",
                style: TextStyle(
                  height: 0.70,
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                ),
              )),
          DropdownMenuItem(
              value: "other",
              child: Text(
                "other",
                style: TextStyle(
                  height: 0.70,
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                ),
              )),
        ],
        value: sexDropDownValue);
  }
}
