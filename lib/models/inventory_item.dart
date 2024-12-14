class InventoryItem {
  final String companyNo;
  final String itemNo;
  final String name;
  final String categoryId;
  final String barcode;
  final String minPrice;
  final String lastSalePrice;
  final String qty;

  InventoryItem({
    required this.companyNo,
    required this.itemNo,
    required this.name,
    required this.categoryId,
    required this.barcode,
    required this.minPrice,
    required this.lastSalePrice,
    required this.qty,
  });

  factory InventoryItem.fromApi(
      Map<String, dynamic> itemData, Map<String, dynamic>? quantityData) {
    return InventoryItem(
      companyNo: itemData['COMAPNYNO'],
      itemNo: itemData['ITEMNO'],
      name: itemData['NAME'],
      categoryId: itemData['CATEOGRYID'] ?? '',
      barcode: itemData['BARCODE'],
      minPrice: itemData['MINPRICE'],
      lastSalePrice: itemData['LSPRICE'],
      qty: quantityData?['QTY'] ?? '0',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'companyNo': companyNo,
      'itemNo': itemNo,
      'name': name,
      'categoryId': categoryId,
      'barcode': barcode,
      'minPrice': minPrice,
      'lastSalePrice': lastSalePrice,
      'qty': qty,
    };
  }
}
