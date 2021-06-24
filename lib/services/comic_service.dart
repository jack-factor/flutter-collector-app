import 'package:comic_salvat/models/comic_model.dart';
import 'package:comic_salvat/models/comic_data.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ComicService {
  static Database? _database;
  static final ComicService db = ComicService._();
  ComicService._();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    print(await getDatabasesPath());

    return openDatabase(
      join(await getDatabasesPath(), 'comic_database.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        final result = db.execute(
          '''CREATE TABLE comics_marvel(
        id INTEGER PRIMARY KEY,
        title TEXT,
        description TEXT,
        path_image TEXT,
        is_exist BOOL DEFAULT false)''',
        );
        // charge data
        final data = ComicData().data;
        data.forEach((element) {
          String title = element['title'];
          List result = title.split(" ");
          element['title'] =
              title.replaceAll(" ${result[result.length - 1]}", "");
          db.insert('comics_marvel', element);
        });
        print('cargando datos');
        return result;
      },
      version: 1,
    );
  }

  Future<void> insertComic(ComicModel comic) async {
    // Get a reference to the database.
    final db = await database;
    await db!.insert(
      'comics_marvel',
      comic.toJson(),
    );
    await db.close();
  }

  Future<ComicTotalModel> getTotalRows() async {
    final db = await database;
    final data = await db!.rawQuery(
        'SELECT  count(id)  as total,  is_exist FROM  comics_marvel GROUP BY  is_exist');
    // await db.close();
    return ComicTotalModel.fromJson(data);
  }

  Future<List<ComicModel>> getAll(int isExist) async {
    String sql;
    switch (isExist) {
      case 0:
        sql = 'SELECT * FROM comics_marvel WHERE is_exist = 0';
        break;
      case 1:
        sql = 'SELECT * FROM comics_marvel WHERE is_exist = 1';
        break;
      case 2:
        sql = 'SELECT * FROM comics_marvel';
        break;
      default:
        sql = 'SELECT * FROM comics_marvel';
    }
    final db = await ComicService.db.database;
    final data = await db!.rawQuery(sql);
    // await db.close();
    return data.isNotEmpty
        ? data.map((s) => ComicModel.fromJson(s)).toList()
        : [];
  }

  Future<ComicModel?> getDetail(int pk) async {
    final db = await database;
    final data =
        await db!.query('comics_marvel', where: 'id=?', whereArgs: [pk]);
    // await db.close();
    return data.isNotEmpty ? ComicModel.fromJson(data.first) : null;
  }

  Future setExist(ComicModel comic) async {
    final db = await database;
    comic.isExist = (comic.isExist == 1) ? 0 : 1;
    await db!.update('comics_marvel', comic.toJson(),
        where: 'id=?', whereArgs: [comic.id]);
    // await db.close();
  }
}
