import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sage/database/data/settings_database.dart';

class GeminiApi {
  Future<String> promptGeminiText(String prompt, WidgetRef ref) async {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: ref.read(settingsDatabaseProvider)[0].value,
    );
    final content = [Content.text(prompt)];
    try {
      final response = await model.generateContent(content);
      return response.text ?? "Failed";
    } catch (e) {
      return e.toString();
    }
  }
}
