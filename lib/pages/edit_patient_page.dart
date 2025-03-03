import 'package:flutter/widgets.dart';
import 'package:sage/layouts/patient_page_layout.dart';

class EditPatientPage extends StatelessWidget {
  final bool forAdding;
  const EditPatientPage({super.key, required this.forAdding});

  @override
  Widget build(BuildContext context) {
    return PatientPageLayout(
      forAdding: forAdding,
    );
  }
}
