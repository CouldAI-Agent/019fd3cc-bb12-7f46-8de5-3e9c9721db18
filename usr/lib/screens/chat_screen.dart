import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [
    {
      'sender': 'assistant',
      'text': '¡Hola! Soy tu asistente comercial. ¿En qué te puedo ayudar hoy?'
    }
  ];

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    
    setState(() {
      _messages.add({
        'sender': 'user',
        'text': _controller.text,
      });
    });
    
    final query = _controller.text.toLowerCase();
    _controller.clear();
    
    // Simular respuesta del asistente
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      
      String response = 'Entiendo. Como asesor comercial, te puedo ayudar con más información. ¿Hay algún producto en particular que te interese?';
      
      if (query.contains('laptop') || query.contains('computadora')) {
        response = 'Tenemos excelentes laptops en nuestro catálogo. La Laptop Pro X es muy popular para profesionales, con 16GB de RAM y 512GB SSD. ¿Te gustaría ver sus características?';
      } else if (query.contains('precio') || query.contains('cuánto')) {
        response = 'Los precios varían según el producto. Puedes ver todos los precios detallados en nuestro catálogo principal. ¿Buscas algo en un rango específico?';
      } else if (query.contains('auriculares') || query.contains('audífonos')) {
        response = 'Los Auriculares Noise Cancelling son fantásticos para trabajar sin distracciones. Ofrecen 30 horas de batería. ¡Te los recomiendo!';
      }
      
      setState(() {
        _messages.add({
          'sender': 'assistant',
          'text': response,
        });
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Asistente Comercial'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg['sender'] == 'user';
                return _ChatBubble(
                  text: msg['text'] ?? '',
                  isUser: isUser,
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Escribe tu mensaje...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FloatingActionButton(
                    mini: true,
                    onPressed: _sendMessage,
                    child: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;

  const _ChatBubble({required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: isUser ? theme.colorScheme.primary : Colors.grey[200],
            borderRadius: BorderRadius.circular(16.0).copyWith(
              bottomRight: isUser ? const Radius.circular(0) : const Radius.circular(16.0),
              bottomLeft: !isUser ? const Radius.circular(0) : const Radius.circular(16.0),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isUser ? theme.colorScheme.onPrimary : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
