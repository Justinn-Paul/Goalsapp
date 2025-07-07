import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';
import '../../../models/verse.dart';

class VerseDisplay extends StatefulWidget {
  const VerseDisplay({super.key});

  @override
  State<VerseDisplay> createState() => _VerseDisplayState();
}

class _VerseDisplayState extends State<VerseDisplay> {
  Verse? _currentVerse;

  @override
  void initState() {
    super.initState();
    _loadRandomVerse();
  }

  Future<void> _loadRandomVerse() async {
    try {
      // Load verses from assets
      final String response = await DefaultAssetBundle.of(
        context,
      ).loadString('assets/verses.json');
      final List<dynamic> versesJson = json.decode(response);

      // Convert to Verse objects
      final List<Verse> verses = versesJson
          .map((json) => Verse.fromJson(json))
          .toList();

      // Select random verse
      final random = Random();
      final randomVerse = verses[random.nextInt(verses.length)];

      setState(() {
        _currentVerse = randomVerse;
      });
    } catch (e) {
      // Handle error - show default verse
      setState(() {
        _currentVerse = Verse(
          id: '1',
          text: 'The only way to do great work is to love what you do.',
          author: 'Steve Jobs',
          category: 'motivation',
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_currentVerse == null) {
      return const Card(
        margin: EdgeInsets.all(16),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.format_quote, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  'Daily Inspiration',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: _loadRandomVerse,
                  tooltip: 'New verse',
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              _currentVerse!.text,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            Text(
              '- ${_currentVerse!.author}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontStyle: FontStyle.italic,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
