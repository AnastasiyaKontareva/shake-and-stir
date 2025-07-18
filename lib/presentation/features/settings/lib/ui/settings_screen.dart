import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:settings/settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoaded) {
            return ListView(
              children: [
                SwitchListTile(
                  title: const Text('Dark Mode'),
                  value: state.settings.isDarkMode,
                  onChanged: (value) {
                    BlocProvider.of<SettingsBloc>(context).add(
                      SaveSettings(
                        state.settings.copyWith(isDarkMode: value),
                      ),
                    );
                  },
                ),
                // ListTile(
                //   title: const Text('Language'),
                //   trailing: DropdownButton<String>(
                //     value: state.settings.language,
                //     items: const [
                //       DropdownMenuItem(value: 'en', child: Text('English')),
                //       DropdownMenuItem(value: 'pl', child: Text('Polish')),
                //     ],
                //     onChanged: (value) {
                //       if (value != null) {
                //         BlocProvider.of<SettingsBloc>(context).add(
                //           SaveSettings(
                //             state.settings.copyWith(language: value),
                //           ),
                //         );
                //       }
                //     },
                //   ),
                // ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
