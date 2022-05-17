import 'package:booklistsample/domain/book.dart';
import 'package:booklistsample/edit_book/edit_book_model.dart';
import 'package:booklistsample/register/register_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterBookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterBookModel>(
      create: (_) => RegisterBookModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("新規登録"),
        ),
        body: Center(
          child: Consumer<RegisterBookModel>(builder: (context, model, child) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: model.tittleController,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                        ),
                        onChanged: (text) {
                          model.setEmail(text);
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextField(
                        controller: model.authorController,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                        ),
                        onChanged: (text) {
                          // TODO: ここで取得したtextを使う
                          model.setPassword(text);
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            model.startLoading();
                            try {
                              //追加処理
                              await model.signup();
                              Navigator.of(context).pop();
                            } catch (e) {
                              final snackBar = SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(e.toString()));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } finally {
                              model.endLoading();
                            }
                          },
                          child: const Text("登録")),
                    ],
                  ),
                ),
                if (model.isLoading)
                  Container(
                    color: Colors.black54,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
              ],
            );
          }),
        ),
      ),
    );
  }
}
