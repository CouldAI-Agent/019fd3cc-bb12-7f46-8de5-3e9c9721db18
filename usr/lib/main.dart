import 'package:flutter/material.dart';
import 'screens/catalog_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/chat_screen.dart';

void main() {
  runApp(const AssistantApp());
}

class AssistantApp extends StatelessWidget {
  const AssistantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asistente Comercial',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const CatalogScreen(),
        '/chat': (context) => const ChatScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/product') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) {
              return ProductDetailScreen(productId: args['id'] as String);
            },
          );
        }
        return null;
      },
    );
  }
}
