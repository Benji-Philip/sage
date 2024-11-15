import 'package:flutter/widgets.dart';
import 'package:sage/layouts/patient_page_layout.dart';

class AddPatientPage extends StatelessWidget {
  const AddPatientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PatientPageLayout(forEditing: false,);
  }
}