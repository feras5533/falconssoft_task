import 'package:flutter/material.dart';

import '../models/inventory_item.dart';
import '../utils/theme.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.isLowStock,
    required this.item,
  });

  final bool isLowStock;
  final InventoryItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: isLowStock ? AppTheme.textRed : AppTheme.green,
            child: Icon(
              isLowStock ? Icons.warning : Icons.check,
              color: AppTheme.white,
            ),
          ),
          title: Text(
            item.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          subtitle: Text(
            'Qty: ${item.qty}',
            style: TextStyle(
              color: isLowStock ? AppTheme.textRed : AppTheme.textBlack,
            ),
          ),
          trailing: isLowStock
              ? const Text(
                  'Low Stock',
                  style: TextStyle(
                    color: AppTheme.textRed,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : const Text(
                  'In Stock',
                  style: TextStyle(
                    color: AppTheme.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}
