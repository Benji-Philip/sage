import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final Function() onConfirm;
  final String title;
  final String description;
  final String confirmButtonText;
  const ConfirmDialog({
    super.key,
    required this.title,
    required this.description,
    required this.onConfirm,
    required this.confirmButtonText,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.all(Radius.circular(12))),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, children: [
              Text(
                title,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
              const SizedBox(height: 10,),
              Text(
                description,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w300,
                    fontSize: 16),
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                          color: Theme.of(context).colorScheme.onTertiary,
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 5),
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.1),
                                blurRadius: 10,
                                spreadRadius: 1)
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ),
              const SizedBox(width: 15,),
                  GestureDetector(
                    onTap: onConfirm,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                          color: Colors.red,
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 5),
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.1),
                                blurRadius: 10,
                                spreadRadius: 1)
                          ]),
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text(
                          confirmButtonText,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ]),
          ),
        ));
  }
}
