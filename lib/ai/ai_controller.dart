import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sage/ai/chatgpt.dart';
import 'package:sage/ai/gemini.dart';
import 'package:sage/database/data/settings_database.dart';

class AiController {
  Future<String> generateDiagnoses(
      WidgetRef ref,
      String patientSex,
      double patientAge,
      int patientAgeUnit,
      String patientOccupation,
      String patientHopi,
      String patientExaminations,
      String patientInvestigations) async {
    String aiModel = ref.read(settingsDatabaseProvider)[2].value;
    String prompt =
        "You're part of an educational app that helps medical students understand different cases. A ${patientSex == "M" ? "male" : patientSex == "F" ? "female" : "intersex"} patient of age $patientAge ${patientAgeUnit == 0 ? "years" : patientAgeUnit == 1 ? "months" : patientAgeUnit == 2 ? "days" : patientAgeUnit == 3 ? "hours" : ""}${patientOccupation.isEmpty ? "" : patientOccupation.trim() == "" ? "" : " who is a $patientOccupation"}, with the following history: $patientHopi ${patientExaminations.isNotEmpty && patientExaminations.trim() != "" ? ", examinations: $patientInvestigations" : ""} ${patientInvestigations.isNotEmpty && patientInvestigations.trim() != "" ? " and investigations: $patientInvestigations" : ""}. List 3 to 5 most probable differential diagnoses, each with a confidence score in percentage and ordered from the most confident to the least confident. Don't give any explanations. Just Give the Diagnoses in a numbered list with the confidence scores(not labelled). Don't use any headings. In plain text not markdown";
    if (aiModel == "gemini") {
      String response = await GeminiApi().promptGeminiText(prompt, ref);
      return response;
    } else if (aiModel == "chatgpt") {
      String response = await ChatGptApi().promptChatGptText(prompt, ref);
      return response;
    }
    return "Error";
  }

  Future<String> generateSuggestedQuestions(
      WidgetRef ref,
      String patientSex,
      double patientAge,
      int patientAgeUnit,
      String patientOccupation,
      String patientHopi,
      String patientExaminations,
      String patientInvestigations) async {
    String aiModel = ref.read(settingsDatabaseProvider)[2].value;
    String prompt =
        "You're part of an educational app that helps medical students understand different cases. A ${patientSex == "M" ? "male" : patientSex == "F" ? "female" : "non-binary"} patient of age $patientAge ${patientAgeUnit == 0 ? "years" : patientAgeUnit == 1 ? "months" : patientAgeUnit == 2 ? "days" : patientAgeUnit == 3 ? "hours" : ""}${patientOccupation.isEmpty ? "" : patientOccupation.trim() == "" ? "" : " who is a $patientOccupation"}, with the following history: $patientHopi${patientExaminations.isNotEmpty && patientExaminations.trim() != "" ? ", examinations: $patientExaminations" : ""} ${patientInvestigations.isNotEmpty && patientInvestigations.trim() != "" ? " and investigations: $patientInvestigations" : ""}. List 3 to 5 recommended questions that they should ask with the current information, few to rule out organ systems or diseases not involved and few to help obtain patient history relevant to the most probable diagnoses. Don't give any explanations. Don't use any headings. In plain text not markdown";
    if (aiModel == "gemini") {
      String response = await GeminiApi().promptGeminiText(prompt, ref);
      return response;
    } else if (aiModel == "chatgpt") {
      String response = await ChatGptApi().promptChatGptText(prompt, ref);
      return response;
    }
    return "Error";
  }

  Future<String> generateTreatments(
    WidgetRef ref,
    String patientSex,
    double patientAge,
    int patientAgeUnit,
    String patientOccupation,
    String patientHopi,
    String patientExaminations,
    String patientInvestigations,
  ) async {
    String aiModel = ref.read(settingsDatabaseProvider)[2].value;
    String prompt =
        "You're part of an educational app that helps medical students understand different cases. A ${patientSex == "M" ? "male" : patientSex == "F" ? "female" : "non-binary"} patient of age $patientAge ${patientAgeUnit == 0 ? "years" : patientAgeUnit == 1 ? "months" : patientAgeUnit == 2 ? "days" : patientAgeUnit == 3 ? "hours" : ""}${patientOccupation.isEmpty ? "" : patientOccupation.trim() == "" ? "" : " who is a $patientOccupation"}, with the following history: $patientHopi${patientExaminations.isNotEmpty && patientExaminations.trim() != "" ? ", examinations: $patientExaminations" : ""} ${patientInvestigations.isNotEmpty && patientInvestigations.trim() != "" ? " and investigations: $patientInvestigations" : ""}. List most probable treatments, management, or surgery including the name of the drugs class, methods, techniques, or surgeries, for the most likely diagnosis. Make it short. Don't use any headings. In points in plain text not markdown";
    if (aiModel == "gemini") {
      String response = await GeminiApi().promptGeminiText(prompt, ref);
      return response;
    } else if (aiModel == "chatgpt") {
      String response = await ChatGptApi().promptChatGptText(prompt, ref);
      return response;
    }
    return "Error";
  }

  Future<String> refactorHistory(WidgetRef ref, String patientHopi) async {
    String aiModel = ref.read(settingsDatabaseProvider)[2].value;
    String prompt =
        "The history for a patient is as follows : $patientHopi. Refactor the given patient history under seperate headings like you would see in hospital casesheets, under points in plain text and not in markdown. Only refactor the given history into what doctors would write in patient casesheets";
    if (aiModel == "gemini") {
      String response = await GeminiApi().promptGeminiText(prompt, ref);
      return response;
    } else if (aiModel == "chatgpt") {
      String response = await ChatGptApi().promptChatGptText(prompt, ref);
      return response;
    }
    return "Error";
  }

  Future<String> refactorExaminations(
      WidgetRef ref, String patientExaminations) async {
    String aiModel = ref.read(settingsDatabaseProvider)[2].value;
    String prompt =
        "The examinations for a patient is as follows : $patientExaminations. Refactor the given patient examinations under seperate headings like you would see in hospital casesheets, as points in plain text and not in markdown. Only refactor the given examinations into what doctors would write in patient casesheets";
    if (aiModel == "gemini") {
      String response = await GeminiApi().promptGeminiText(prompt, ref);
      return response;
    } else if (aiModel == "chatgpt") {
      String response = await ChatGptApi().promptChatGptText(prompt, ref);
      return response;
    }
    return "Error";
  }

  Future<String> refactorInvestigations(
      WidgetRef ref, String patientInvestigations) async {
    String aiModel = ref.read(settingsDatabaseProvider)[2].value;
    String prompt =
        "The investigations for a patient is as follows : $patientInvestigations. Refactor the given patient investigations under seperate headings like you would see in hospital casesheets, as points in plain text and not in markdown. Only refactor the given investigations into what doctors would write in patient casesheets";
    if (aiModel == "gemini") {
      String response = await GeminiApi().promptGeminiText(prompt, ref);
      return response;
    } else if (aiModel == "chatgpt") {
      String response = await ChatGptApi().promptChatGptText(prompt, ref);
      return response;
    }
    return "Error";
  }

  Future<String> generateSummary(
      WidgetRef ref,
      String patientSex,
      double patientAge,
      int patientAgeUnit,
      String patientOccupation,
      String patientHopi,
      String patientExaminations,
      String patientInvestigations) async {
    String aiModel = ref.read(settingsDatabaseProvider)[2].value;
    String prompt =
        "You're part of an educational app that helps medical students understand different cases. A ${patientSex == "M" ? "male" : patientSex == "F" ? "female" : "non-binary"} patient of age $patientAge ${patientAgeUnit == 0 ? "years" : patientAgeUnit == 1 ? "months" : patientAgeUnit == 2 ? "days" : patientAgeUnit == 3 ? "hours" : ""} with the following history: $patientHopi${patientExaminations.isNotEmpty && patientExaminations.trim() != "" ? ", examinations: $patientExaminations" : ""} ${patientInvestigations.isNotEmpty && patientInvestigations.trim() != "" ? " and investigations: $patientInvestigations" : ""}. Summarise this case into a singular paragraph which includes patient details, the positive findings from the history only and the most probable diagnosis. Don't give any explanations. Don't use any headings. In plain text not markdown";
    if (aiModel == "gemini") {
      String response = await GeminiApi().promptGeminiText(prompt, ref);
      return response;
    } else if (aiModel == "chatgpt") {
      String response = await ChatGptApi().promptChatGptText(prompt, ref);
      return response;
    }
    return "Error";
  }
}
