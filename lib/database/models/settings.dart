import 'package:realm/realm.dart';

part 'settings.realm.dart';

@RealmModel()
class _Settings {
  @PrimaryKey()
  late ObjectId id;

  late String name;
  late String value;
}