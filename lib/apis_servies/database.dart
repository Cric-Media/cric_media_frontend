import 'dart:io' as io;

import 'package:cricket_app/models/get_player_list.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDatabase();
    return _db!;
  }

  Future<Database> initDatabase() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'Cricket.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
   CREATE TABLE Cricket(
  id INTEGER PRIMARY KEY,
  image TEXT,
  location TEXT,
  name TEXT,
  age INTEGER,
  type TEXT,
  additional_information TEXT,
  createdBy INTEGER
)
  ''');
  }

  Future<void> insertAll(List<getPlayerList> playerList) async {
    try {
      var dbClient = await db;

      var batch = dbClient.batch();
      for (var player in playerList) {
        if (player.name != null &&
            player.createdBy != null &&
            player.id != null &&
            player.type != null &&
            player.age != null &&
            player.image != null &&
            player.additional_information != null) {
          print('Player Image URI: ${player.image}');
          var existingPlayer = await dbClient.query(
            'Cricket',
            where: 'id = ?',
            whereArgs: [player.id],
          );

          if (existingPlayer.isEmpty) {
            batch.insert('Cricket', {
              'id': player.id,
              'image': player.image,
              'location': player.location,
              'name': player.name,
              'age': player.age,
              'type': player.type,
              'additional_information': player.additional_information,
              'createdBy': player.createdBy,
            });
          } else {
            print('Skipping duplicate player data: ${player.toJson()}');
          }
        } else {
          print('Skipping player data with null values: ${player.toJson()}');
        }
      }
      await batch.commit();
      print('Insertion completed successfully.');
    } catch (e) {
      print('An error occurred during insertion: $e');
    }
  }

  Stream<List<getPlayerList>> getPlayerDataStream() async* {
    var dbClient =
        await db; // Assuming 'db' is previously initialized and is an instance of your database client
    final List<Map<String, Object?>> queryResult =
        await dbClient.query('Cricket');

    // Assuming you only want to emit the list once after fetching all entries
    // If you wanted to stream data as each record is fetched, modifications would be needed

    // Printing image URIs - you can remove this if not needed
    for (var entry in queryResult) {
      var imageUri = entry['image'];
      print('Image URI: $imageUri');
    }

    // Emitting the final list of players as a single stream event
    yield queryResult.map((e) => getPlayerList.fromJson(e)).toList();
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete('Cricket', where: 'id=?', whereArgs: [id]);
  }

  Future<void> deleteAll() async {
    var dbClient = await db;
    await dbClient.rawDelete('DELETE FROM Cricket');
    // Or you can use:
    // await db.rawDelete('DELETE FROM $_tableName');
  }

  Future<void> printAllDataAndCheckEmpty() async {
    var dbClient = await db;
    List<Map<String, dynamic>> result = await dbClient.query('Cricket');

    if (result.isNotEmpty) {
      print('Table Data:');
      result.forEach((row) {
        print(row);
      });
    } else {
      print('Table is empty.');
    }
  }
}
