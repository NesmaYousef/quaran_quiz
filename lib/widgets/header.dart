import 'package:flutter/material.dart';

class header extends StatelessWidget {
  const header({
    super.key,
    required this.surah,
    required this.jozz,
  });

  final Set<String?> surah;
  final Set<int?> jozz;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${surah.first}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            '${jozz.first}',
          ),
        ],
      ),
    );
  }
}
