import 'package:flutter/widgets.dart';
import 'package:sage/layouts/patient_page_layout.dart';

class EditPatientPage extends StatelessWidget {
  const EditPatientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PatientPageLayout(forEditing: true,);
  }
}