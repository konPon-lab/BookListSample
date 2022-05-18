import 'package:booklistsample/edit_book/edit_book_model.dart';
import 'package:booklistsample/mypage/my_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'edit_profile_model.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage(this.name, this.description);

  final String name;
  final String description;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditProfileModel>(
      create: (_) => EditProfileModel(name, description),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("プロフィール編集"),
        ),
        body: Center(
          child: Consumer<EditProfileModel>(builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: model.nameController,
                    decoration: const InputDecoration(
                      hintText: 'name',
                    ),
                    onChanged: (text) {
                      model.setName(text);
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: model.descriptionController,
                    decoration: const InputDecoration(
                      hintText: '自己紹介',
                    ),
                    onChanged: (text) {
                      // TODO: ここで取得したtextを使う
                      model.setDescription(text);
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
                                Navigator.of(context).pop();
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
