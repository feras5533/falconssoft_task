import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../api/items_api.dart';
import '../api/quantity_api.dart';
import '../database/database_helper.dart';
import '../models/inventory_item.dart';
import '../widgets/custom_snack_bar.dart';

class InventoryController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isRefreshing = false.obs;
  RxBool isSearchVisible = false.obs;
  RxList<InventoryItem> items = <InventoryItem>[].obs;
  RxList<InventoryItem> filteredItems = <InventoryItem>[].obs;
  RxString sortingOrder = 'desc'.obs;
  RxString searchQuery = ''.obs;
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchAndStoreData();
  }

  Future<void> fetchAndStoreData(
      {bool showLoadingIndicator = true,
      bool isRefreshTriggeredByUser = false}) async {
    try {
      if (showLoadingIndicator) {
        isLoading.value = true;
      } else {
        isRefreshing.value = true;
      }

      final itemsData = await ItemsApi.fetchItems();
      final quantitiesData = await QuantityApi.fetchQuantities();

      final quantityMap = {for (var q in quantitiesData) q['ItemOCode']: q};
      final mergedData = itemsData.map((item) {
        final quantity = quantityMap[item['ITEMNO']];

        final roundedQuantity = quantity != null
            ? (double.tryParse(quantity['QUANTITY'].toString()) ?? 0)
            : 0;

        return InventoryItem.fromApi(
            item, {...quantity ?? {}, 'QUANTITY': roundedQuantity});
      }).toList();

      await _dbHelper.insertItems(mergedData);

      items.value = mergedData;
      filteredItems.value = mergedData;

      if (isRefreshTriggeredByUser) {
        showCustomSnackBar(
          title: 'Data Refreshed',
          message: 'Inventory list has been updated successfully.',
          isError: false,
        );
      }
    } catch (e) {
      showCustomSnackBar(
        title: 'Error',
        message: 'Failed to load data: $e',
        isError: true,
      );
    } finally {
      isLoading.value = false;
      isRefreshing.value = false;
    }
  }

  void sortItems() {
    if (sortingOrder.value == 'asc') {
      items.sort((a, b) => double.parse(a.qty).compareTo(double.parse(b.qty)));
    } else {
      items.sort((a, b) => double.parse(b.qty).compareTo(double.parse(a.qty)));
    }
    updateFilteredItems();

    showCustomSnackBar(
      title: 'Items Sorted',
      message:
          'Items have been sorted in ${sortingOrder.value.toUpperCase()} order.',
      isError: false,
    );
  }

  void toggleSortingOrder() {
    sortingOrder.value = sortingOrder.value == 'asc' ? 'desc' : 'asc';
    sortItems();
  }

  void toggleSearchVisibility() {
    isSearchVisible.value = !isSearchVisible.value;
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query.toLowerCase();
    updateFilteredItems();
  }

  void updateFilteredItems() {
    if (searchQuery.value.isEmpty) {
      filteredItems.value = List.from(items);
    } else {
      filteredItems.value = items
          .where((item) =>
              item.name.toLowerCase().contains(searchQuery.value) ||
              item.itemNo.toLowerCase().contains(searchQuery.value))
          .toList();
    }
  }
}
