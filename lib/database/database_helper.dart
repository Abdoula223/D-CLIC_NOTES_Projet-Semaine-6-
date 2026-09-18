import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../models/user.dart';
import '../models/note.dart';
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;
  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }
  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'notes_app.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }
  Future<void> _createDb(Database db, int version) async {
    // Table utilisateur
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL
      )
    ''');

    // Table notes
    await db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        updatedAt TEXT
      )
    ''');
    // Ajouter un utilisateur de test
    await db.insert('users', {
      'username': 'diallo@dclic.org',
      'password': _hashPassword('motdepasse123'),
    });
  }
  // ======PARTIE====== AUTHENTIFICATION ============
  String _hashPassword(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }

  Future<bool> login(String username, String password) async {
    final db = await database;
    final hashedPassword = _hashPassword(password);

    final result = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, hashedPassword],
    );
    return result.isNotEmpty;
  }
  Future<void> registerUser(String username, String password) async {
    final db = await database;
    final hashedPassword = _hashPassword(password);
    try {
      await db.insert('users', {
        'username': username,
        'password': hashedPassword,
      });
    } catch (e) {
      throw Exception('Utilisateur déjà existant');
    }
  }
  // ============ OPÉRATIONS SUR LES NOTES ============
  // Créer une note
  Future<int> insertNote(Note note) async {
    final db = await database;
    return await db.insert('notes', note.toMap());
  }
  // Récupérer toutes les notes
  Future<List<Note>> getAllNotes() async {
    final db = await database;
    final result = await db.query('notes', orderBy: 'createdAt DESC');
    return result.map((map) => Note.fromMap(map)).toList();
  }
  // Récupérer une note par ID
  Future<Note?> getNoteById(int id) async {
    final db = await database;
    final result = await db.query(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isEmpty) return null;
    return Note.fromMap(result.first);
  }
  // Mettre à jour une note
  Future<int> updateNote(Note note) async {
    final db = await database;
    final updatedNote = Note(
      id: note.id,
      title: note.title,
      content: note.content,
      createdAt: note.createdAt,
      updatedAt: DateTime.now(),
    );

    return await db.update(
      'notes',
      updatedNote.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  // Supprimer une note
  Future<int> deleteNote(int id) async {
    final db = await database;
    return await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ============ UTILITAIRES ============

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
