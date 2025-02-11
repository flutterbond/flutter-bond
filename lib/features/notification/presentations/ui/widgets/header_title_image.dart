import 'package:flutter/material.dart';
import 'package:bond_core/bond_core.dart';

class HeaderTitleImage extends StatelessWidget {
  const HeaderTitleImage({
    required this.senderName,
    required this.senderImage,
    super.key,
  });

  final String senderName;
  final String senderImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            senderName,
            style: context.textTheme.titleSmall,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
