import 'package:booklistsample/add_book/add_book_page.dart';
import 'package:booklistsample/book_list/book_list_model.dart';
import 'package:booklistsample/domain/book.dart';
import 'package:booklistsample/edit_book/edit_book_page.dart';
import 'package:booklistsample/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class BookListPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookListModel>(
      create: (_) => BookListModel()..fechBookList(),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text("本一覧"),
          actions: [
            IconButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginBookPage(),
                    fullscreenDialog: true,
                  ),
                );
              },
              icon: Icon(Icons.person),
            ),
          ],
        ),
        body: Center(
          child: Consumer<BookListModel>(builder: (context, model, child) {
            final List<Book>? books = model.books;

            if (books == null) {
              return const CircularProgressIndicator();
            }

            final List<Widget> widgets = books
                .map(
                  (book) => Slidable(
                    endActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (value) async {
                            final String? title = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditBookPage(book),
                              ),
                            );
                            if (title != null) {
                              final snackBar = SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text("$titleを更新しました"));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }

                            model.fechBookList();
                          },
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          icon: Icons.edit,
                          label: 'edit',
                        ),
                        SlidableAction(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'delete',
                          onPressed: (value) async {
                            await showConfirmDialog(context, book, model);
                          },
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: book.imgURL != null
                          ? Image.network(book.imgURL!)
                          : null,
                      title: Text(book.title),
                      subtitle: Text(book.author),
                    ),
                  ),
                )
                .toList();
            return ListView(
              children: widgets,
            );
          }),
        ),
        floatingActionButton:
            Consumer<BookListModel>(builder: (context, model, child) {
          return FloatingActionButton(
            onPressed: () async {
              final bool? added = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddBookPage(),
                  fullscreenDialog: true,
                ),
              );
              if (added != null && added) {
                final snackBar = SnackBar(
                    backgroundColor: Colors.green, content: Text("本を追加しました"));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }

              model.fechBookList();
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          );
        }),
      ),
    );
  }

  Future showConfirmDialog(
      BuildContext context, Book book, BookListModel model) {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("削除の確認"),
          content: Text("【${book.title}】を削除しますか？"),
          actions: [
            // ボタン領域
            TextButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text("OK"),
              onPressed: () async {
                await model.delete(book);
                Navigator.pop(context);
                final snackBar = SnackBar(
                  backgroundColor: Colors.red,
                  content: Text("${book.title}を削除しました"),
                );
                model.fechBookList();
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
          ],
        );
      },
    );
  }
}
