import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:falconssoft_task/utils/theme.dart';

import '../controllers/inventory_controller.dart';

class AppBarActions extends StatelessWidget {
  final InventoryController controller;

  const AppBarActions({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(
            Icons.refresh,
            color: AppTheme.textBlack,
          ),
          iconSize: 20.0,
          onPressed: () =>
              controller.fetchAndStoreData(isRefreshTriggeredByUser: true),
          tooltip: 'Refresh Inventory',
        ),
        IconButton(
          icon: Obx(
            () => Icon(
              controller.sortingOrder.value == 'asc'
                  ? Icons.arrow_upward
                  : Icons.arrow_downward,
              color: AppTheme.textBlack,
            ),
          ),
          onPressed: controller.toggleSortingOrder,
          tooltip: 'Sort by Quantity',
          iconSize: 20.0,
        ),
      ],
    );
  }
}
