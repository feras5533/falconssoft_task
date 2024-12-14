import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/inventory_controller.dart';
import '../utils/theme.dart';

class AppBarLeading extends StatelessWidget {
  const AppBarLeading({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<InventoryController>();
    return IconButton(
      icon: Obx(
        () => Icon(
          controller.isSearchVisible.value ? Icons.close : Icons.search,
          color: AppTheme.textBlack,
        ),
      ),
      tooltip: 'Search',
      iconSize: 20,
      onPressed: () {
        if (controller.isSearchVisible.value) {
          controller.searchController.clear();
          controller.updateSearchQuery('');
          FocusScope.of(Get.context!).unfocus();
        }
        controller.toggleSearchVisibility();
      },
    );
  }
}
