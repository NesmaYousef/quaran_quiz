import 'package:flutter/material.dart';

class pageOfAyahs extends StatelessWidget {
  const pageOfAyahs({
    super.key,
    required this.listTextSpan,
    required this.scale,
  });

  final List<InlineSpan> listTextSpan;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text.rich(
        TextSpan(children: listTextSpan),
        textScaleFactor: scale,
        textAlign: TextAlign.justify,
      ),
    );
  }
}
