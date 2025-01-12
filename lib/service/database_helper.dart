import 'package:chatview/chatview.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'messages.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE conversations (
          id TEXT PRIMARY KEY,
          title TEXT,
          createdAt TEXT
        )
      ''');

        await db.execute('''
        CREATE TABLE messages (
          id TEXT PRIMARY KEY,
          conversationId TEXT,
          message TEXT,
          createdAt TEXT,
          sentBy TEXT,
          replyMessage TEXT,
          reaction TEXT,
          messageType TEXT,
          voiceMessageDuration INTEGER,
          status TEXT,
          FOREIGN KEY(conversationId) REFERENCES conversations(id) ON DELETE CASCADE
        )
      ''');
      },
    );
  }

  Future<void> insertConversation(String id, String title) async {
    final db = await database;
    await db.insert(
      'conversations',
      {
        'id': id,
        'title': title,
        'createdAt': DateTime.now().toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getConversations() async {
    final db = await database;
    return await db.query('conversations');
  }

  Future<void> deleteConversation(String id) async {
    final db = await database;
    await db.delete(
      'conversations',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> insertMessage(String conversationId, Message message) async {
    final db = await database;
    await db.insert(
      'messages',
      {
        'id': message.id,
        'conversationId': conversationId,
        'message': message.message,
        'createdAt': message.createdAt.toIso8601String(),
        'sentBy': message.sentBy,
        'replyMessage': message.replyMessage.toJson(),
        'reaction': message.reaction.toJson(),
        'messageType': message.messageType.name,
        'voiceMessageDuration': message.voiceMessageDuration?.inMicroseconds ?? 0,
        'status': message.status.name,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Message>> getMessagesByConversation(String conversationId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'messages',
      where: 'conversationId = ?',
      whereArgs: [conversationId],
    );

    return List.generate(maps.length, (i) {
      return Message.fromJson(maps[i]);
    });
  }

  Future<void> deleteMessage(String id) async {
    final db = await database;
    await db.delete(
      'messages',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateMessage(Message message) async {
    final db = await database;
    await db.update(
      'messages',
      message.toJson(),
      where: 'id = ?',
      whereArgs: [message.id],
    );
  }
}
