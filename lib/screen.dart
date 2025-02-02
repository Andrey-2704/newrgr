import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rgr3/order_screen.dart';
import 'package:rgr3/purchase.dart';

class Screen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Screen({Key? key}) : super(key: key);

  Future<void> _createPurchase(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пользователь не авторизован')),
      );
      return;
    }

    final String title = _titleController.text;
    final String description = _descriptionController.text;

    if (title.isNotEmpty && description.isNotEmpty) {

      final newPurchase = Purchase(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        description: description,
        userId: userId,
      );



      print('Создана новая покупка: ${newPurchase.title}, ID: ${newPurchase.id}');


      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              OrderScreen(purchase: newPurchase),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('заполните все поля')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Создать Заказ')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Название товара'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Описание товара'),
            ),
            ElevatedButton(
              onPressed: () => _createPurchase(context),
              child: const Text('Сохранить заказ'),
            ),
          ],
        ),
      ),
    );
  }
}