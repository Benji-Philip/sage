import 'package:flutter/material.dart';

class Searchbar extends StatefulWidget {
  final FocusNode searchFocusNode;
  final TextEditingController searchTEC;
  final Function(String)? onChanged;
  final double screenWidth;
  const Searchbar({
    super.key,
    required this.screenWidth,
    required this.searchTEC,
    required this.onChanged,
    required this.searchFocusNode,
  });

  @override
  State<Searchbar> createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(widget.searchFocusNode);
              },
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
                constraints: BoxConstraints(maxWidth: widget.screenWidth),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width/1.4),
                        child: IntrinsicWidth(
                          child: TextFormField(
                            focusNode: widget.searchFocusNode,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            onChanged: widget.onChanged,
                            controller: widget.searchTEC,
                            decoration: InputDecoration(
                              isDense: true,
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
                      ),
                      SizedBox(
                        height: 20,
                        child: Image(
                          image: const AssetImage(
                              'assets/images/magnifying-glass.png'),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
