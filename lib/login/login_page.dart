import 'package:booklistsample/domain/book.dart';
import 'package:booklistsample/edit_book/edit_book_model.dart';
import 'package:booklistsample/register/register_model.dart';
import 'package:booklistsample/register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_model.dart';

class LoginBookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginBookModel>(
      create: (_) => LoginBookModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: Center(
          child: Consumer<LoginBookModel>(builder: (context, model, child) {
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
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            //追加処理
                            await model.login();
                            Navigator.of(context).pop();
                          } catch (e) {
                            final snackBar = SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(e.toString()));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: const Text("Login"),
                      ),
                      TextButton(
                        onPressed: () async {
                          model.startLoading();
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterBookPage(),
                              fullscreenDialog: true,
                            ),
                          );
                          model.endLoading();
                        },
                        child: const Text("新規登録の方はこちら"),
                      ),
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
