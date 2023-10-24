import 'package:minerva/minerva.dart';

import 'builder/setting.dart';

Future<void> main(List<String> args) async {
  await Minerva.bind(args: args, settingBuilder: SettingBuilder());
}
