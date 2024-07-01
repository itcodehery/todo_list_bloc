import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_bloc/bloc/theme_cubit.dart';
import 'package:todo_list_bloc/settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, theme) => Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              title: const Text("Toggle Theme"),
              subtitle: Text(
                  "Currently set to ${theme.brightness == Brightness.dark ? "Dark" : "Light"} Mode"),
              onTap: () {
                setState(() {
                  context.read<ThemeCubit>().toggleTheme();
                });
                context.read<ThemeCubit>().saveTheme(
                    context.read<ThemeCubit>().state.brightness ==
                            Brightness.dark
                        ? true
                        : false);
              },
            )
          ],
        ),
      ),
    );
  }
}
