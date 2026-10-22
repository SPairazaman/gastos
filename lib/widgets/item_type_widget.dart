import 'package:flutter/material.dart';

class ItemTypeWidget extends StatelessWidget {
  final Map<String, dynamic> data;
  bool isSelected;
  final VoidCallback tap;

  ItemTypeWidget({
    super.key,
    required this.data,
    required this.isSelected,
    required this.tap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.cyan.withOpacity(0.3)
              : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/icons/${data["image"]}.webp",
              width: 40,
              height: 40,
            ),
            SizedBox(width: 8),
            Text(data["name"]),
          ],
        ),
      ),
    );
  }
}