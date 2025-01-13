import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:vcs_hackathon/chat_screen.dart';
import 'package:vcs_hackathon/service/database_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> conversations = [];
  final uuid = Uuid();
  final _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _loadConversations();
  }

  void _loadConversations() async {
    final loadedConversations = await _databaseHelper.getConversations();
    setState(() {
      conversations.clear();
      conversations.addAll(loadedConversations);
    });
  }

  void _createNewConversation() async {
    final title = await showDialog<String>(
      context: context,
      builder: (context) {
        final TextEditingController controller = TextEditingController();
        return AlertDialog(
          title: const Text('Tên cuộc hội thoại:'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: "Nhập tên cuộc hội thoại",
              hintStyle: TextStyle(
                color: Color(0xFFE6DBDB)
              )
            )
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(controller.text.trim()),
              child: const Text('Xác nhận'),
            ),
          ],
        );
      },
    );

    if (title != null && title.isNotEmpty) {
      final newConversation = {
        'id': uuid.v4(),
        'title': title,
        'createdAt': DateTime.now().toIso8601String(),
      };

      await _databaseHelper.insertConversation(newConversation['id'].toString(), newConversation['title'].toString());

      _loadConversations();

      _openConversation(newConversation);
    }
  }

  void _openConversation(Map<String, dynamic> conversation) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          conversationId: conversation['id'].toString(),
          conversationName: conversation['title'],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'NBT Chatbot',
                      style: TextStyle(
                        fontFamily: 'FSPFBeauSansPro',
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.8,
                        color: Color.fromRGBO(239,0,57,1),
                      ),
                    ),
                    Text(
                      'Cái gì bạn cần, chúng tôi thường có',
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        letterSpacing: 1,
                        color: Color(0xFF331f1f),
                      ),
                    ),
                    const SizedBox(height: 22)
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: conversations.length,
                  itemBuilder: (context, index) {
                    final conversation = conversations[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                        title: Text(
                          conversation['title'],
                          style: const TextStyle(
                            fontFamily: 'FSPFBeauSansPro',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Tạo lúc: ${conversation['createdAt']}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF331f1f),
                          ),
                        ),
                        onTap: () => _openConversation(conversation),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewConversation,
        backgroundColor: Color.fromRGBO(239,0,57,1),
        child: Transform.scale(
          scale: 1.5,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
