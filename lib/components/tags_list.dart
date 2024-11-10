import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final updateTagsListUi = StateProvider((ref) => true);
final tagsListIndex = StateProvider((ref) => 0);

class TagsList extends ConsumerWidget {
  final Function()? onTap;
  final Function? onLongPress;
  final Function(String?)? onFieldSubmitted;
  final TextEditingController? tagsTEC;
  final bool ableToAddTag;
  final VerticalDirection? verticalDirection;
  final List<String> tags;
  const TagsList({
    super.key,
    required this.tags,
    this.verticalDirection,
    required this.ableToAddTag,
    this.tagsTEC,
    this.onFieldSubmitted,
    this.onLongPress,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> tagsWidgets = List.generate(
      tags.length,
      (int index) => GestureDetector(
        onTap: onTap,
        onLongPress: () {
          HapticFeedback.heavyImpact();
          ref.read(tagsListIndex.notifier).update((state) => index);
          if (onLongPress != null) {
            onLongPress!();
          }
        },
        child: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 5),
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.05),
                    blurRadius: 10,
                    spreadRadius: 1)
              ],
              color: Theme.of(context).colorScheme.tertiary,
              borderRadius: const BorderRadius.all(Radius.circular(100))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
            child: Text(
              tags[index],
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 2, right: 2),
      child: Wrap(
          verticalDirection: verticalDirection ?? VerticalDirection.up,
          spacing: 6,
          runSpacing: 6,
          direction: Axis.horizontal,
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.center,
          children: [
            ...tagsWidgets,
            Visibility(
              visible: ableToAddTag,
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 5),
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 1)
                    ],
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.all(Radius.circular(100))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
                  child: IntrinsicWidth(
                    child: TextFormField(
                      onFieldSubmitted: onFieldSubmitted,
                      decoration: const InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          hintText: "+ add tag"),
                      controller: tagsTEC,
                      style: TextStyle(
                          height: 0.70,
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.tertiary,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ),
          ]),
    );
  }
}
