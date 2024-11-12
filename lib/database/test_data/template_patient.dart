import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:realm/realm.dart';
import 'package:sage/database/models/patient.dart';

final templatePatient = StateProvider((ref) => Patient(
    ObjectId(),
    '["patient"]',
    "John Doe",
    22,
    0,
    "M",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    ""));
