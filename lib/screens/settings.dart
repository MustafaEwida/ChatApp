import 'package:flutter/material.dart';
import 'package:howru/helpers/Auth.dart';
import 'package:howru/models/ex.dart';
import 'package:howru/helpers/nav.dart';
import 'package:howru/providers/Main_provider.dart';
import 'package:howru/widgets/SettingsItems.dart';
import 'package:howru/widgets/Settings_group.dart';
import 'package:howru/widgets/maindrewer.dart';
import 'package:howru/widgets/settings_item.dart';
import 'package:provider/provider.dart';

class Settings_screen extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
body: SettingsItems()

    );
  }
}