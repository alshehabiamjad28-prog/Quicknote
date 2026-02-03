import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback onPressed;
  final VoidCallback onCancel;
  final RxBool showCancelButton;
  final ValueChanged<String> onChanged; // ✅ أضف

  const SearchWidget({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onPressed,
    required this.onCancel,
    required this.showCancelButton,
    required this.onChanged, // ✅ أضف
  });

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      height: isMobile ? 40 : 40,
      margin: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(width: 8),

          Icon(
            Icons.search,
            size: 20,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
          ),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              onTap: onPressed,
              onChanged: onChanged, // ✅ هنا
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                ),
              ),
              style: TextStyle(fontSize: 14),
            ),
          ),
          Obx(
                () => showCancelButton.value
                ? IconButton(
              onPressed: () {
                controller.clear();
                onCancel();
              },
              icon: Icon(
                Icons.close,
                size: 18,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              ),
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
            )
                : SizedBox(width: 8),
          ),
        ],
      ),
    );
  }
}