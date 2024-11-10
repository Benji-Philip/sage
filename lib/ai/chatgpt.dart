import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sage/database/data/settings_database.dart';

class ChatGptApi {
  late final dynamic openAI;

  void initialiseChatGpt(WidgetRef ref) {
    openAI = OpenAI.instance.build(
        token: ref.read(settingsDatabaseProvider)[1].value,
        baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 10)),
        enableLog: true);
  }

  Future<String> promptChatGptText(String prompt, WidgetRef ref) async {
    initialiseChatGpt(ref);
    final request = ChatCompleteText(messages: [
      Map.of({"role": "user", "content": prompt})
    ], maxToken: 200, model: Gpt4ChatModel());
    String responseString = "";
    late dynamic response;
    try {
      response = await openAI.onChatCompletion(request: request);
    for (var element in response!.choices) {
      responseString = "$responseString ${element.message?.content}";
    }
    } catch (e) {
      responseString = e.toString();
    }
    
    return responseString;
  }
}
