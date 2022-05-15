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
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        child: SizedBox(
                          width: 100,
                          height: 160,
                          child: model.imageFile != null
                              ? Image.file(model.imageFile!)
                              : Container(
                                  color: Colors.grey,
                                ),
                        ),
                        onTap: () async {
                          //print("反応");
                          await model.pickImage();
                        },
                      ),
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
                              model.startLoading();
                              //追加処理
                              await model.addBook();
                              Navigator.of(context).pop(true);
                            } catch (e) {
                              print(e);
                              final snackBar = SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(e.toString()));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } finally {
                              model.endLoading();
                            }
                          },
                          child: Text("add")),
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
