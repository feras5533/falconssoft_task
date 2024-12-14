import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../controllers/inventory_controller.dart';
import '../utils/theme.dart';
import '../widgets/app_bar_actions.dart';
import '../widgets/app_bar_leading.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/item_card.dart';

class HomeView extends StatelessWidget {
  final InventoryController controller =
      Get.put<InventoryController>(InventoryController());

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: controller.isSearchVisible.value
                ? const CustomSearchBar()
                : const Text('Inventory List'),
          ),
        ),
        backgroundColor: AppTheme.primaryBlue,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppTheme.textBlack,
        ),
        leading: const AppBarLeading(),
        actions: [
          Obx(
            () {
              if (controller.isSearchVisible.value) {
                return Container();
              } else {
                return AppBarActions(controller: controller);
              }
            },
          )
        ],
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(
                child: CircularProgressIndicator(
              color: AppTheme.primaryBlue,
            ));
          }

          return LiquidPullToRefresh(
            onRefresh: () async {
              await controller.fetchAndStoreData(showLoadingIndicator: false);
            },
            color: AppTheme.primaryBlue,
            backgroundColor: AppTheme.background,
            height: Get.height * 0.1,
            animSpeedFactor: 2,
            showChildOpacityTransition: true,
            child: controller.filteredItems.isEmpty
                ? SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: SizedBox(
                      height: Get.height * 0.8,
                      child: const Center(
                        child: Text(
                          'No items available',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppTheme.textGrey,
                          ),
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: controller.filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = controller.filteredItems[index];
                      final isLowStock = double.parse(item.qty) < 5;

                      return ItemCard(isLowStock: isLowStock, item: item);
                    },
                  ),
          );
        },
      ),
    );
  }
}
