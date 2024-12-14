import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/inventory_item.dart';
import '../utils/constants.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'inventory.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE inventory (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            companyNo TEXT,
            itemNo TEXT,
            name TEXT,
            categoryId TEXT,
            barcode TEXT,
            minPrice TEXT,
            lastSalePrice TEXT,
            qty TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertItems(List<InventoryItem> items) async {
    final db = await database;

    await db.delete(inventoryTable);

    for (var item in items) {
      await db.insert(inventoryTable, item.toMap());
    }
  }

  Future<List<InventoryItem>> fetchItems() async {
    final db = await database;
    final result = await db.query(inventoryTable);

    return result.map((map) {
      return InventoryItem(
        companyNo: map['companyNo'] as String? ?? '',
        itemNo: map['itemNo'] as String? ?? '',
        name: map['name'] as String? ?? '',
        categoryId: map['categoryId'] as String? ?? '',
        barcode: map['barcode'] as String? ?? '',
        minPrice: map['minPrice'] as String? ?? '',
        lastSalePrice: map['lastSalePrice'] as String? ?? '',
        qty: map['qty'] as String? ?? '0',
      );
    }).toList();
  }
}
