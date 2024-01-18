import 'dart:io';

import 'package:dish_dash/common/style.dart';
import 'package:dish_dash/provider/preferences_provider.dart';
import 'package:dish_dash/provider/scheduling_provider.dart';
import 'package:dish_dash/widget/custom_dialog.dart';
import 'package:dish_dash/widget/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  static const String settingsTitle = 'Settings';

  const SettingsPage({Key? key}) : super(key: key);

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(color: primaryColor, fontFamily: 'Hero'),
        ),
        leading: const Icon(
          Icons.settings,
          color: primaryColor,
        ),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        leading: Icon(CupertinoIcons.settings),
        middle: Text(settingsTitle),
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder:
          (BuildContext context, PreferencesProvider provider, Widget? child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Material(
                child: ListTile(
                  title: const Text('Dark Theme'),
                  trailing: Switch.adaptive(
                    value: provider.isDarkTheme,
                    onChanged: (value) {
                      provider.enableDarkTheme(value);
                    },
                  ),
                ),
              ),
              Material(
                child: ListTile(
                  title: const Text('Schedule Restaurant Notification'),
                  trailing: Consumer<SchedulingProvider>(
                    builder: (context, scheduled, _) {
                      return Switch.adaptive(
                        value: scheduled.isScheduled,
                        onChanged: (value) async {
                          if (Platform.isIOS) {
                            customDialog(context);
                          } else {
                            scheduled.scheduledRestaurantNotification(value);
                          }
                        },
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
