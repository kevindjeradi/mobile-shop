import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_cash_manager/api/article_api.dart';
import 'package:mobile_cash_manager/componants/article_container.dart';
import 'package:mobile_cash_manager/componants/article_detail.dart';
import 'package:mobile_cash_manager/models/article.dart';

class ArticlesList extends StatefulWidget {
  const ArticlesList({Key? key}) : super(key: key);

  @override
  State<ArticlesList> createState() => _ArticlesListState();
}

class _ArticlesListState extends State<ArticlesList> {
  Future<List<Article>> getArticles() async {
    late List<Article> articles;
    final resp = await ArticleApi.getAllArticles();
    final list = jsonDecode(resp.body);

    try {
      articles = list.map<Article>((e) => Article.fromJson(e)).toList();
    } catch (e, s) {
      print("Error ---------------> " + e.toString());
      print("Stacktrace ---------------> " + s.toString());
    }
    return articles;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getArticles(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final articlesList = snapshot.data!;

          return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 15.0,
                  childAspectRatio: 2 / 3),
              itemCount: articlesList.length,
              itemBuilder: (BuildContext ctx, int index) {
                print(articlesList[index]);
                return InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArticleDetail(
                          article: articlesList[index],
                        ),
                      ),
                      (route) => false,
                    );
                  },
                  child: ArticleContainer(
                    article: articlesList[index],
                  ),
                );
              });
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.yellow,
          ),
        );
      },
    );
  }
}
