import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:assignment_2/models/product.dart';

class DbHelper {
  //constants
  static final dbName = 'products.db';
  static final dbVersion = 11;
  //products table
  static final tbProduct = 'product';
  static final prodCode = 'code';
  static final prodName = 'nameDesc';
  static final prodPrice = 'price';
  static final prodisfav = 'isfav';
  static final prodiscart = 'iscart';
  static final prodquantity = 'quantity';

  static Future<Database> openDb() async {
    //join databases path + dbname file
    var path = join(await getDatabasesPath(), dbName);
    var sql =
        'CREATE TABLE IF NOT EXISTS $tbProduct ($prodCode TEXT PRIMARY KEY, $prodName TEXT NOT NULL, $prodPrice DECIMAL(10,2), $prodisfav BOOLEAN, $prodiscart BOOLEAN, $prodquantity INTEGER)';
    var db = await openDatabase(
      path,
      version: dbVersion,
      onCreate: (db, version) {
        db.execute(sql);
        print('table $tbProduct created');
      },
      onUpgrade: (db, oldVersion, newVersion) {
        if (newVersion > oldVersion) {
          db.execute('DROP TABLE IF EXISTS $tbProduct');
          db.execute(sql);
        }
      },
    );
    return db;
  }

  static void insertProduct(Product product) async {
    final db = await openDb();
    db.insert(tbProduct, product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> fetchProducts() async {
    final db = await openDb();
    return db.query(tbProduct);
  }

  static Future<List<Map<String, dynamic>>> fetchfav() async {
    final db = await DbHelper.openDb();
    var result =
        await db.rawQuery("SELECT * FROM $tbProduct where $prodisfav = true");
    return result;
  }

  static void updateProduct(Product product) async {
    final db = await openDb();
    db.update(tbProduct, product.toMap(),
        where: '$prodCode =?', whereArgs: [product.code]);
  }

  static void quantityProduct(Product product) async {
    final db = await openDb();
    if (product.quantity == 0) {
      product.quantity = 1;
    } else {
      product.quantity = product.quantity + 1;
    }

    db.update(tbProduct, product.toMap(),
        where: '$prodCode =?', whereArgs: [product.code]);
    print("db quantity: ${product.quantity}");
  }

  static void deleteCart(Product product) async {
    final db = await openDb();

    product.quantity = 0;
    db.update(tbProduct, product.toMap(),
        where: '$prodCode =?', whereArgs: [product.code]);
    print("db quantity: ${product.quantity}");
  }
}
