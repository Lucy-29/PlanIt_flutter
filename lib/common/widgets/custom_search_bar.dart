import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: GestureDetector(
        onTap: () {
          // TODO: Add search functionality when ready
          print('Search bar tapped - functionality not implemented yet');
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFdbc5c4).withOpacity(0.7),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.search,
                color: Colors.black,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Search here ...',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
