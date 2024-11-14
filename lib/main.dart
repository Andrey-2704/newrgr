import 'package:flutter/material.dart';
import 'package:rgr3/register_screen.dart';
import 'package:rgr3/order_screen.dart';
import 'package:rgr3/screen.dart';
import 'package:rgr3/login_screen.dart';
import 'package:rgr3/purchase.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Работа',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RegisterScreen(),
    );
  }
}


class ProjectScreen extends StatelessWidget {
  ElevatedButton _buildButton(
      BuildContext context, String text, Widget screen) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Text(text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главный экран'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton(context, 'Перейти к регистрации', RegisterScreen()),
            const SizedBox(height: 10),

            _buildButton(
              context,
              'Перейти к заказам',
              OrderScreen(
                purchase: Purchase(
                  id: '1',
                  title: 'Демо Работа',
                  description: 'Описание работы',
                  userId: '1',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}