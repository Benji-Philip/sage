import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sage/ai/chatgpt.dart';
import 'package:sage/ai/gemini.dart';
import 'package:sage/database/data/settings_database.dart';
import 'package:sage/database/models/patient.dart';

class AiController {

  Future<String> generateDiagnoses(
      WidgetRef ref, Patient patient) async {
        String aiModel = ref.read(settingsDatabaseProvider)[2].value;
    String prompt = "You're part of an educational app that helps medical students understand different cases. A ${patient.sex == "M"? "male":patient.sex == "F"? "female":"non-binary"} patient of age ${patient.age} ${patient.ageUnit == 0 ? "years" : patient.ageUnit == 1 ? "months":patient.ageUnit == 2 ? "days":patient.ageUnit == 3 ? "hours" : ""}${patient.occupation.isEmpty?"":patient.occupation.trim() == "" ? "":" who is a ${patient.occupation}"}, with the following history: ${patient.hopi} ${patient.examinations.isNotEmpty && patient.examinations.trim() != "" ? " and examinations: ${patient.examinations}":""}. List 3 to 5 most probable differential diagnoses, each with a confidence score in percentage and ordered from the most confident to the least confident. Don't give any explanations. Just Give the Diagnoses in a numbered list with the confidence scores(not labelled). Don't use any headings. In plain text not markdown";
    if (aiModel == "gemini") {
      String response = await GeminiApi().promptGeminiText(prompt, ref);
      return response;
    } else if (aiModel == "chatgpt"){
      String response = await ChatGptApi().promptChatGptText(prompt, ref);
      return response;
    }
    return "Error";
  }

  Future<String> generateSuggestedQuestions(
      WidgetRef ref, Patient patient) async {
        String aiModel = ref.read(settingsDatabaseProvider)[2].value;
    String prompt = "You're part of an educational app that helps medical students understand different cases. A ${patient.sex == "M"? "male":patient.sex == "F"? "female":"non-binary"} patient of age ${patient.age} ${patient.ageUnit == 0 ? "years" : patient.ageUnit == 1 ? "months":patient.ageUnit == 2 ? "days":patient.ageUnit == 3 ? "hours" : ""}${patient.occupation.isEmpty?"":patient.occupation.trim() == "" ? "":" who is a ${patient.occupation}"}, with the following history: ${patient.hopi}${patient.examinations.isNotEmpty && patient.examinations.trim() != "" ? " and examinations: ${patient.examinations}":""}. List 3 to 5 recommended questions that they should ask with the current information, few to rule out organ systems or diseases not involved and few to help obtain patient history relevant to the most probable diagnoses. Don't give any explanations. Don't use any headings. In plain text not markdown";
    if (aiModel == "gemini") {
      String response = await GeminiApi().promptGeminiText(prompt, ref);
      return response;
    } else if (aiModel == "chatgpt"){
      String response = await ChatGptApi().promptChatGptText(prompt, ref);
      return response;
    }
    return "Error";
  }

  Future<String> generateTreatments(
      WidgetRef ref, Patient patient) async {
        String aiModel = ref.read(settingsDatabaseProvider)[2].value;
    String prompt = "You're part of an educational app that helps medical students understand different cases. A ${patient.sex == "M"? "male":patient.sex == "F"? "female":"non-binary"} patient of age ${patient.age} ${patient.ageUnit == 0 ? "years" : patient.ageUnit == 1 ? "months":patient.ageUnit == 2 ? "days":patient.ageUnit == 3 ? "hours" : ""}${patient.occupation.isEmpty?"":patient.occupation.trim() == "" ? "":" who is a ${patient.occupation}"}, with the following history: ${patient.hopi}${patient.examinations.isNotEmpty && patient.examinations.trim() != "" ? " and examinations: ${patient.examinations}":""}. List most probable treatments, management, or surgery including the name of the drugs class, methods, techniques, or surgeries, for the most likely diagnosis. Make it short. Don't use any headings. In points in plain text not markdown";
    if (aiModel == "gemini") {
      String response = await GeminiApi().promptGeminiText(prompt, ref);
      return response;
    } else if (aiModel == "chatgpt"){
      String response = await ChatGptApi().promptChatGptText(prompt, ref);
      return response;
    }
    return "Error";
  }

  Future<String> refactorHistory(
      WidgetRef ref, Patient patient) async {
        String aiModel = ref.read(settingsDatabaseProvider)[2].value;
    String prompt = "The history for a patient is as follows : ${patient.hopi}. Refactor the given patient history under seperate headings like you would see in hospital casesheets, under points in plain text and not in markdown. Only refactor the given history into what doctors would write in patient casesheets";
    if (aiModel == "gemini") {
      String response = await GeminiApi().promptGeminiText(prompt, ref);
      return response;
    } else if (aiModel == "chatgpt"){
      String response = await ChatGptApi().promptChatGptText(prompt, ref);
      return response;
    }
    return "Error";
  }

  Future<String> refactorExaminations(
      WidgetRef ref, Patient patient) async {
        String aiModel = ref.read(settingsDatabaseProvider)[2].value;
    String prompt = "The examinations for a patient is as follows : ${patient.examinations}. Refactor the given patient examinations under seperate headings like you would see in hospital casesheets, as points in plain text and not in markdown. Only refactor the given examinations into what doctors would write in patient casesheets";
    if (aiModel == "gemini") {
      String response = await GeminiApi().promptGeminiText(prompt, ref);
      return response;
    } else if (aiModel == "chatgpt"){
      String response = await ChatGptApi().promptChatGptText(prompt, ref);
      return response;
    }
    return "Error";
  }

  Future<String> generateSummary(
      WidgetRef ref, Patient patient) async {
        String aiModel = ref.read(settingsDatabaseProvider)[2].value;
    String prompt = "You're part of an educational app that helps medical students understand different cases. A ${patient.sex == "M"? "male":patient.sex == "F"? "female":"non-binary"} patient of age ${patient.age} ${patient.ageUnit == 0 ? "years" : patient.ageUnit == 1 ? "months":patient.ageUnit == 2 ? "days":patient.ageUnit == 3 ? "hours" : ""} with the following history: ${patient.hopi}${patient.examinations.isNotEmpty && patient.examinations.trim() != "" ? " and examinations: ${patient.examinations}":""}. Summarise this case into a singular paragraph which includes patient details, the positive findings from the history only and the most probable diagnosis. Don't give any explanations. Don't use any headings. In plain text not markdown";
    if (aiModel == "gemini") {
      String response = await GeminiApi().promptGeminiText(prompt, ref);
      return response;
    } else if (aiModel == "chatgpt"){
      String response = await ChatGptApi().promptChatGptText(prompt, ref);
      return response;
    }
    return "Error";
  }
  
}
