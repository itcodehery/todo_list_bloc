import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list_bloc/model/todo_class.dart';
import 'package:todo_list_bloc/settings.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;
  static Database? _themeDatabase;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'todo_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<Database> get themeDatabase async {
    if (_themeDatabase != null) return _themeDatabase!;
    _themeDatabase = await _initThemeDatabase();
    return _themeDatabase!;
  }

  Future<Database> _initThemeDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'theme_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onThemeCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todos (
        id INTEGER PRIMARY KEY,
        title TEXT,
        description TEXT,
        isDone INTEGER,
        createdOn TEXT
      )
    ''');
  }

  Future<void> insertTheme(String theme) async {
    final db = await database;
    await db.insert(
      'settings',
      {'theme': theme},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> _onThemeCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE settings (
        id INTEGER PRIMARY KEY,
        theme TEXT
      )
    ''');
  }

  Future<void> fetchTheme() async {
    final db = await database;
    final theme = await db.query('settings');
    if (theme.isNotEmpty) {
      settings["theme"] = theme[0]["theme"];
    }
  }

  Future<int> insertTodo(Todo todo) async {
    final db = await database;
    return await db.insert('todos', todo.toMap());
  }

  Future<List<Todo>> fetchTodos() async {
    final db = await database;
    final maps = await db.query('todos');
    return List.generate(maps.length, (i) {
      return Todo.fromMap(maps[i]);
    });
  }

  Future<int> updateTodoStatus(int id, bool isDone) async {
    final db = await database;
    return await db.update(
      'todos',
      {'isDone': isDone ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteTodo(String title) async {
    final db = await database;
    return await db.delete(
      'todos',
      where: 'title = ?',
      whereArgs: [title],
    );
  }
}
