import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final tagsListIndex = StateProvider((ref) => 0);

class TagsList extends ConsumerStatefulWidget {
  final FocusNode? focusNode;
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
    this.focusNode,
  });

  @override
  ConsumerState<TagsList> createState() => _TagsListState();
}

class _TagsListState extends ConsumerState<TagsList> {

  @override
  Widget build(BuildContext context) {
    List<Widget> tagsWidgets = List.generate(
      widget.tags.length,
      (int index) => GestureDetector(
        onTap: widget.onTap,
        onLongPress: () {
          HapticFeedback.heavyImpact();
          ref.read(tagsListIndex.notifier).update((state) => index);
          if (widget.onLongPress != null) {
            widget.onLongPress!();
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
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.all(Radius.circular(100))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
            child: Text(
              widget.tags[index],
              style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 2, right: 2),
      child: Wrap(
          verticalDirection: widget.verticalDirection ?? VerticalDirection.up,
          spacing: 6,
          runSpacing: 6,
          direction: Axis.horizontal,
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.center,
          children: [
            ...tagsWidgets,
            Visibility(
              visible: widget.ableToAddTag,
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
                    color: Theme.of(context).colorScheme.tertiary,
                    borderRadius: const BorderRadius.all(Radius.circular(100))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
                  child: IntrinsicWidth(
                    child: TextFormField(
                      focusNode: widget.focusNode,
                      cursorColor: Theme.of(context).colorScheme.primary,
                      onFieldSubmitted: widget.onFieldSubmitted,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          height: 0.70,
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w700),
                          isDense: true,
                          border: InputBorder.none,
                          hintText: "+ add tag"),
                      controller: widget.tagsTEC,
                      style: TextStyle(
                          height: 0.70,
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary,
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
