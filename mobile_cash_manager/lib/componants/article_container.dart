import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:mobile_cash_manager/componants/article_detail.dart';
import 'package:mobile_cash_manager/models/article.dart';
import 'package:mobile_cash_manager/utils/app_theme.dart';

class ArticleContainer extends StatefulWidget {
  const ArticleContainer({Key? key, required this.article}) : super(key: key);
  final Article article;

  @override
  State<ArticleContainer> createState() => _ArticleContainerState();
}

class _ArticleContainerState extends State<ArticleContainer> {
  @override
  Widget build(BuildContext context) {
    ContainerTransitionType transitionType = ContainerTransitionType.fade;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OpenContainer<bool>(
        transitionType: transitionType,
        openBuilder: (BuildContext _, VoidCallback openContainer) {
          return ArticleDetail(
            article: widget.article,
          );
        },
        closedShape: const RoundedRectangleBorder(),
        closedElevation: 0.0,
        closedBuilder: (BuildContext _, VoidCallback openContainer) {
          return Container(
            decoration: BoxDecoration(
              color: AppTheme.of(context).secondaryBackground,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 4,
                  color: Color(0x3600000F),
                  offset: Offset(0, 2),
                )
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                    child: Image.network(
                      widget.article.image,
                      width: 182,
                      height: 182,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 12),
                  FittedBox(
                    child: Text(
                      widget.article.nom,
                      style: const TextStyle(
                        color: Color(0xFF212121),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${widget.article.prix} €',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF212121)),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
