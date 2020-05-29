import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newsapplication/api_packet/NewsApiProvider.dart';
import 'package:newsapplication/constants/Constants.dart';
import 'package:newsapplication/constants/DateGetter.dart';
import 'package:newsapplication/model/SourceModel.dart';
import 'package:newsapplication/model/responseNews/NewsResponse.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import 'NewsCard.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime dateTime = new DateTime.now();
  Future<NewsResponse> mFuture;
  int selected = 0;
  NewsResponse newsResponse = new NewsResponse();
  bool _reload = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mFuture = getNews(null);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
        appBar: getAppbar(),
        body: ListView(
          children: [
            getTopHeader(),
            StickyHeader(
                header: getSourcesList(context), content: newsCardList(context))
          ],
        ));
  }

  Stack newsCardList(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder<NewsResponse>(
          future: mFuture,
          builder: (context, projectSanap) {
            if (projectSanap.hasData) {
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: projectSanap.data.articles.length,
                  itemBuilder: (context, index) {
                    return NewsCard(
                      newsResponse: projectSanap.data.articles[index],
                    );
                  });
            } else {
              return Center(
                child: LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                ),
              );
            }
          },
        ),
        Visibility(
          visible: _reload,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
              ),
            ),
          ),
        )
      ],
    );
  }

  Container getSourcesList(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: sourceList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                color: index == selected
                    ? kPrimaryColor.withOpacity(0.2)
                    : Colors.white,
                splashColor: kPrimaryColor.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    side: BorderSide(color: kPrimaryColor)),
                onPressed: () {
                  setState(() {
                    selected = index;
                  });
                  mFuture = getNews(sourceList[index].value);
                },
                child: Text(sourceList[index].title),
              ),
            );
          }),
    );
  }

  Padding getTopHeader() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(children: [
          TextSpan(
              text: "Today's Headlines \n",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor)),
          TextSpan(
              text: getStrToday(),
              style: TextStyle(
                  color: kSecondaryColor, fontWeight: FontWeight.bold))
        ]),
      ),
    );
  }

  AppBar getAppbar() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: kPrimaryColor.withOpacity(0.7),
      leading: IconButton(
        splashColor: kPrimaryColor.withOpacity(0.2),
        onPressed: () {},
        icon: Icon(
          Icons.menu,
          color: Colors.white,
        ),
      ),
      title: Text(
        "Newspedia",
        style: TextStyle(
            fontSize: 23, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          splashColor: kPrimaryColor.withOpacity(0.2),
          onPressed: () {},
          icon: Icon(
            Icons.search,
            color: Colors.white,
          ),
        )
      ],
    );
  }

  Future<NewsResponse> getNews(String name) async {
    setState(() {
      _reload = true;
    });
    NewsResponse newsResponse = await NewsApi.getApiNews(name);
    if (newsResponse != null) {
      debugPrint(newsResponse.status);
      setState(() {
        _reload = false;
      });
      return newsResponse;
    } else {
      return newsResponse;
    }
  }
}
