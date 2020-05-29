import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapplication/constants/Constants.dart';
import 'package:newsapplication/model/responseNews/NewsResponse.dart';
import 'package:newsapplication/model/responseNews/articles.dart';
import 'package:newsapplication/ui/DescriptionPage.dart';

class NewsCard extends StatelessWidget {
  final Articles newsResponse;

  const NewsCard({
    Key key,
    this.newsResponse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (context) => Description(
                    url: newsResponse.url,
                  )));
        },
        child: Card(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(7))),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      child: Image.network(
                        newsResponse.urlToImage,
                        height: 200,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                        height: 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                          color: Colors.black38
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            newsResponse.publishedAt.substring(0, 10),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(children: [
                        TextSpan(
                            text: newsResponse.title + "\n",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 14)),
                        TextSpan(
                            text: newsResponse.description,
                            style:
                                TextStyle(color: Colors.black, fontSize: 13)),
                      ])),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
