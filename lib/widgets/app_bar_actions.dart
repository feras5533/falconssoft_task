import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          icon: const Icon(Icons.refresh),
          iconSize: 20.0,
          onPressed: () => controller.fetchAndStoreData(),
          tooltip: 'Refresh Inventory',
        ),
        IconButton(
          icon: Obx(() => Icon(
                controller.sortingOrder.value == 'asc'
                    ? Icons.arrow_upward
                    : Icons.arrow_downward,
              )),
          onPressed: controller.toggleSortingOrder,
          tooltip: 'Sort by Quantity',
          iconSize: 20.0,
        ),
      ],
    );
  }
}