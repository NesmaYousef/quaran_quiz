import 'package:flutter/material.dart';
import 'package:quaran_quiz/widgets/surah_name.dart';

class SurahFrame extends StatelessWidget {
  const SurahFrame({
    super.key,
    required this.surah,
  });

  final Set<String?> surah;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 70,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/1.png',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: SurahName(surah: surah),
    );
  }
}
