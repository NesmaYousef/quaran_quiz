import 'package:flutter/material.dart';

class SurahName extends StatelessWidget {
  const SurahName({
    super.key,
    required this.surah,
  });

  final Set<String?> surah;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${surah.first}',
      style: Theme.of(context).textTheme.labelLarge,
    );
  }
}
