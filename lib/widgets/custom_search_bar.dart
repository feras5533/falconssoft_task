import 'package:falconssoft_task/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/inventory_controller.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<InventoryController>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller.searchController,
        onChanged: (query) {
          controller.updateSearchQuery(query);
        },
        onTapOutside: (event) {
          FocusScope.of(Get.context!).unfocus();
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
          hintText: 'Search by name or number...',
          hintStyle: const TextStyle(color: AppTheme.textGrey, fontSize: 12),
          prefixIcon: const Icon(Icons.search, color: AppTheme.textGrey),
          filled: true,
          fillColor: AppTheme.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: AppTheme.primaryBlue),
          ),
        ),
        style: const TextStyle(color: AppTheme.textBlack, fontSize: 14),
      ),
    );
  }
}
