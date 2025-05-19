import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_2/generated/l10n.dart';
import '../Provider/language_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.settings),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizations.language,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: languageProvider.locale.languageCode,
              decoration: InputDecoration(
                labelText: localizations.selectLanguage,
                border: const OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem(
                  value: 'en',
                  child: Text(localizations.english),
                ),
                DropdownMenuItem(
                  value: 'kk',
                  child: Text(localizations.kazakh),
                ),
                DropdownMenuItem(
                  value: 'ru',
                  child: Text(localizations.russian),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  languageProvider.setLocale(Locale(value));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}