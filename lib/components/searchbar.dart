import 'package:flutter/material.dart';

class Searchbar extends StatelessWidget {
  final TextEditingController searchTEC;
  final Function(String)? onChanged;
  final double screenWidth;
  const Searchbar({
    super.key,
    required this.screenWidth,
    required this.searchTEC,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).colorScheme.tertiary,
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
              constraints: BoxConstraints(maxWidth: screenWidth),
              height: 50,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IntrinsicWidth(
                      child: TextFormField(
                        onChanged: onChanged,
                        controller: searchTEC,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search",hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.primary)),
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                    Image(
                      image: const AssetImage(
                          'assets/images/magnifying-glass.png'),
                      color: Theme.of(context).colorScheme.primary,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
