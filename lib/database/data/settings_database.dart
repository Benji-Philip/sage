import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:realm/realm.dart';
import 'package:sage/database/models/settings.dart';

final settingsDatabaseProvider =
    StateNotifierProvider<SettingsDataBaseNotifier, List<Settings>>(
        (ref) => SettingsDataBaseNotifier());

class SettingsDataBaseNotifier extends StateNotifier<List<Settings>> {
  SettingsDataBaseNotifier() : super([]) {
    intialiseDatabase();
  }
  var config = Configuration.local([Settings.schema]);
  late var realm = Realm(config);

  // initialise
  void intialiseDatabase() {
    List<Settings> temp = fetchSettings().toList();
    if (temp.isEmpty) {
      // settings 1
      Settings settingsOne = Settings(ObjectId(), "geminiApiKey", "");
      // settings 2
      Settings settingsTwo = Settings(ObjectId(), "chatGptApiKey", "");
      // settings 3
      Settings settingsThree = Settings(ObjectId(), "chosenAiModel", "gemini");

      // add to state
      state = [settingsOne, settingsTwo, settingsThree];
    } else {
      state = temp;
    }
  }

  // update state
  void updateState() {
    state = [];
    state = fetchSettings().toList();
  }

  // read all patients
  List<Settings> fetchSettings() {
    return realm.all<Settings>().toList();
  }

  // update
  void updateSettings(Settings settings) {
    realm.write(() {
      realm.add(settings, update: true);
    });
    updateState();
  }
}
