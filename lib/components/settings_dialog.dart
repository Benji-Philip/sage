import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sage/components/inputbox.dart';
import 'package:sage/database/data/settings_database.dart';
import 'package:sage/database/models/settings.dart';

class SettingsDialog extends ConsumerStatefulWidget {
  const SettingsDialog({super.key});

  @override
  ConsumerState<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends ConsumerState<SettingsDialog> {
  FocusNode geminiSettingsFN = FocusNode();
  FocusNode chatGptSettingsFN = FocusNode();
  @override
  Widget build(BuildContext context) {
    List<Settings> settings = ref.read(settingsDatabaseProvider);
    TextEditingController settingsOneTEC = TextEditingController();
    Settings settingsOne =
        Settings(settings[0].id, settings[0].name, settings[0].value);
    settingsOneTEC.text = settingsOne.value;
    TextEditingController settingsTwoTEC = TextEditingController();
    Settings settingsTwo =
        Settings(settings[1].id, settings[1].name, settings[1].value);
    Settings settingsThree =
        Settings(settings[2].id, settings[2].name, settings[2].value);
    settingsTwoTEC.text = settingsTwo.value;
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        ref.read(settingsDatabaseProvider.notifier).updateSettings(settingsOne);
        ref.read(settingsDatabaseProvider.notifier).updateSettings(settingsTwo);
        ref
            .read(settingsDatabaseProvider.notifier)
            .updateSettings(settingsThree);
      },
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSurface,
                  borderRadius: const BorderRadius.all(Radius.circular(18)),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 5),
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 1)
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            HapticFeedback.lightImpact();
                            settingsThree.value = "gemini";
                            ref
                                .read(settingsDatabaseProvider.notifier)
                                .updateSettings(settingsThree);
                          },
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: InputBox(
                                  focusNode: geminiSettingsFN,
                                  maxLines: 3,
                                  hintColor:
                                      Theme.of(context).colorScheme.onTertiary,
                                  hintText: "enter key",
                                  textFieldVisible: ref
                                              .watch(
                                                  settingsDatabaseProvider)[2]
                                              .value ==
                                          "gemini"
                                      ? true
                                      : false,
                                  title: "Gemini",
                                  tec: settingsOneTEC,
                                  onChanged: (newvalue) {
                                    settingsOne.value = newvalue;
                                  },
                                  color: ref
                                              .watch(
                                                  settingsDatabaseProvider)[2]
                                              .value ==
                                          "gemini"
                                      ? null
                                      : Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                              Visibility(
                                  visible: ref
                                          .watch(settingsDatabaseProvider)[2]
                                          .value ==
                                      "gemini",
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.green[400],
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 2),
                                      child: Text(
                                        "selected",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            HapticFeedback.lightImpact();
                            settingsThree.value = "chatgpt";
                            ref
                                .read(settingsDatabaseProvider.notifier)
                                .updateSettings(settingsOne);
                            ref
                                .read(settingsDatabaseProvider.notifier)
                                .updateSettings(settingsTwo);
                            ref
                                .read(settingsDatabaseProvider.notifier)
                                .updateSettings(settingsThree);
                          },
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              InputBox(
                                focusNode: chatGptSettingsFN,
                                maxLines: 3,
                                hintColor:
                                    Theme.of(context).colorScheme.onTertiary,
                                hintText: "enter key",
                                textFieldVisible: ref
                                            .watch(settingsDatabaseProvider)[2]
                                            .value ==
                                        "chatgpt"
                                    ? true
                                    : false,
                                title: "ChatGPT",
                                tec: settingsTwoTEC,
                                onChanged: (newvalue) {
                                  settingsTwo.value = newvalue;
                                },
                                color: ref
                                            .watch(settingsDatabaseProvider)[2]
                                            .value ==
                                        "chatgpt"
                                    ? null
                                    : Theme.of(context).colorScheme.onSurface,
                              ),
                              Visibility(
                                  visible: ref
                                          .watch(settingsDatabaseProvider)[2]
                                          .value ==
                                      "chatgpt",
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.green[400],
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 2),
                                      child: Text(
                                        "selected",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 5),
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 1)
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    color: Theme.of(context).colorScheme.onSurface),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(0, 5),
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 1)
                        ],
                        color: Theme.of(context).colorScheme.tertiary,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100))),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.close,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
