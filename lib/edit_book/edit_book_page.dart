import 'package:booklistsample/domain/book.dart';
import 'package:booklistsample/edit_book/edit_book_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditBookPage extends StatelessWidget {
  final Book book;

  const EditBookPage(this.book, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditBookModel>(
      create: (_) => EditBookModel(book),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("本を更新"),
        ),
        body: Center(
          child: Consumer<EditBookModel>(builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: model.tittleController,
                    decoration: const InputDecoration(
                      hintText: 'title',
                    ),
                    onChanged: (text) {
                      model.setTitle(text);
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: model.authorController,
                    decoration: const InputDecoration(
                      hintText: 'author',
                    ),
                    onChanged: (text) {
                      // TODO: ここで取得したtextを使う
                      model.setAuthor(text);
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                      onPressed: model.isUpdated()
                          ? () async {
                              try {
                                //追加処理
                                await model.update();
                                Navigator.of(context).pop(model.title);
                              } catch (e) {
                                final snackBar = SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(e.toString()));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            }
                          : null,
                      child: const Text("update")),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
