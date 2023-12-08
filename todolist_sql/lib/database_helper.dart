import 'package:sqlflite/sqlite.dart';
import 'package:path/path.dart';
import 'package: path_provider/path_provider.dart';
import 'dart:io' as io;
import 'TodoPage.dart';
import 'package:todolist_sql/todo.dart';


class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;
  static Database? _db;

  Future <Database?> get db async{
    if(_db !=null ) return _db;
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb async{
    io.Directory docDirectory = await getApplicationDocumentDirectory();
    String path = join(docDirectory.path, 'todolist.db');
    var localDb = await openDatabase(
      path,
      version: 1, onCreate: _onCreate
    );
    return localDb;
  }

  void onCreate(Database db, int version) async{
    await db.execute('''
      create table if not exists todos(
        id integer primary key autoincrement,
        nama text not null,
        deskripsi text not null,
        done integer not null default 0
      ''');
  }

  Future<List<Todo>> getAllTodos() async{
    var dbCLient = await db;
    var todos = await dbCLient!.query('todos');
    return todos.map((todo)=>Todo.fromMap(todo)).toList();
  }

  Future<List<Todo>> searchTodo(String keyword) async{
    var dbCLient = await db;
    var todos = await dbCLient!.query('todos', where: 'nama like ?', whereArgs: ['%$keyword%']);
    return todos.map((todo)=>Todo.fromMap(todo)).toList();
  }

  Future<int> addTodo(Todo todo) async{
    var dbCLient = await db;
    return await dbCLient!.insert('todos', todo.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateTodo(Todo todo) async{
    var dbCLient = await db;
    return await dbCLient!.update('todos', todo.toMap(), where:'id = ?', whereArgs : [todo.id]);
  }

  Future<int> deleteTodo (Todo todo) async {
    var dbCLient = await db;
    return await dbCLient!.delete('todo', where: 'id = ?', whereArgs : [id]);
  }
}