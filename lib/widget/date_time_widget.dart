import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todoist/provider/radio_provider.dart';

import '../constants/app_style.dart';

class DateTimeWidget extends ConsumerWidget {
  const DateTimeWidget({
    super.key,
    required this.titleText,
    required this.valueText,
    required this.iconSelection,
    required this.onTap,

  });

  final String titleText;
  final String valueText;
  final IconData iconSelection;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateProv = ref.watch(radioProvider);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            titleText,
            style: AppStyle.headingOne,
          ),
          const Gap(6),
          Material(
            child: Ink(
              
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadiusDirectional.circular(10),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap:() => onTap(),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Row(children: [
                    Icon(iconSelection),
                    Gap(6),
                    Text(valueText),
                  ],)
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
