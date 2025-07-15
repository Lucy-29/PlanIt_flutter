import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<StatefulWidget> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController customSearchbarController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFdbc5c4).withOpacity(0.7),
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextField(
          controller: customSearchbarController,
          decoration: InputDecoration(
            icon: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
            hintText: 'Seach here ...',
            hintStyle: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
