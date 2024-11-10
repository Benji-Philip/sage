import 'package:flutter/material.dart';

class InputBox extends StatefulWidget {
  final Icon? buttonOneIcon;
  final FocusNode focusNode;
  final int? maxLines;
  final Function()? onButtonOneTap;
  final Function()? onButtonTwoTap;
  final String? hintText;
  final Color? hintColor;
  final bool? textFieldVisible;
  final Function(String)? onChanged;
  final String title;
  final TextEditingController tec;
  final String? Function(String?)? validator;
  final Color? color;
  const InputBox({
    super.key,
    required this.title,
    required this.tec,
    this.validator,
    this.color,
    this.onChanged,
    this.textFieldVisible,
    this.hintColor,
    this.hintText,
    this.onButtonOneTap,
    this.maxLines,
    this.onButtonTwoTap,
    required this.focusNode,
    this.buttonOneIcon,
  });

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: widget.color ?? Theme.of(context).colorScheme.onTertiary,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 5),
                color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
                blurRadius: 10,
                spreadRadius: 1)
          ],
        ),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: RichText(
                  text: TextSpan(
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                      children: [
                    TextSpan(text: widget.title),
                    const TextSpan(text: " : "),
                  ])),
            ),
            GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(widget.focusNode);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 5),
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.08),
                        blurRadius: 10,
                        spreadRadius: 1)
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: widget.textFieldVisible ?? true,
                      child: IntrinsicWidth(
                        child: TextFormField(
                          focusNode: widget.focusNode,
                          onChanged: widget.onChanged,
                          validator: widget.validator,
                          keyboardType: TextInputType.multiline,
                          maxLines: widget.maxLines,
                          controller: widget.tec,
                          style: TextStyle(
                            decorationColor:
                                Theme.of(context).colorScheme.secondary,
                            decorationThickness: 2,
                            decoration: TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.dotted,
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                              hintText: widget.hintText ?? "____________",
                              hintStyle: TextStyle(
                                  color: widget.hintColor ?? Colors.transparent),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              contentPadding: const EdgeInsets.all(0)),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: widget.onButtonOneTap != null && widget.onButtonTwoTap != null,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                          onTap: widget.onButtonOneTap,
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          offset: const Offset(0, 5),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(0.08),
                                          blurRadius: 10,
                                          spreadRadius: 1)
                                    ],
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(8)),
                                    color: Theme.of(context).colorScheme.primary),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: widget.buttonOneIcon ?? Icon(
                                    Icons.auto_fix_high_rounded,
                                    color: Theme.of(context).colorScheme.tertiary,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                          onTap: widget.onButtonTwoTap,
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          offset: const Offset(0, 5),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(0.08),
                                          blurRadius: 10,
                                          spreadRadius: 1)
                                    ],
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(8)),
                                    color: Theme.of(context).colorScheme.secondary),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(
                                    Icons.settings_rounded,
                                    color: Theme.of(context).colorScheme.tertiary,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
