import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DropDownMenuButtonLayout extends ConsumerStatefulWidget {
  final Function(String?)? onChanged;
  final String value;
  final List<DropdownMenuItem<String>> items;
  const DropDownMenuButtonLayout({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  @override
  ConsumerState<DropDownMenuButtonLayout> createState() => _DropDownMenuButtonState();
}

class _DropDownMenuButtonState extends ConsumerState<DropDownMenuButtonLayout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 5),
                color: Theme.of(context).colorScheme.primary.withOpacity(0.07),
                blurRadius: 10,
                spreadRadius: 1)
          ],
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      alignment: Alignment.center,
      child: DropdownButton(
        style: const TextStyle(
        ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          onTap: () {
            HapticFeedback.lightImpact();
          },
          dropdownColor: Theme.of(context).colorScheme.onSurface,
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          elevation: 4,
          underline: Container(
            color: Colors.transparent,
          ),
          value: widget.value,
          items: widget.items,
          onChanged: widget.onChanged),
    );
  }
}
