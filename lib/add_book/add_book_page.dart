import 'package:booklistsample/add_book/add_book_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBookPage extends StatelessWidget {
  const AddBookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddBookModel>(
      create: (_) => AddBookModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("本を追加"),
        ),
        body: Center(
          child: Consumer<AddBookModel>(builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'title',
                    ),
                    onChanged: (text) {
                      model.title = text;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'author',
                    ),
                    onChanged: (text) {
                      // TODO: ここで取得したtextを使う
                      model.author = text;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        try {
                          //追加処理
                          await model.addBook();
                          Navigator.of(context).pop(true);
                        } catch (e) {
                          final snackBar = SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(e.toString()));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: Text("add")),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
