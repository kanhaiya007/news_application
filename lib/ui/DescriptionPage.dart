import 'package:flutter/material.dart';
import 'package:newsapplication/constants/Constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Description extends StatefulWidget {
  final String url;

  const Description({Key key, this.url}) : super(key: key);

  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  bool _progress = true;

  @override
  Widget build(BuildContext context) {
    // debugPrint(widget.url);
    return Scaffold(
      appBar: getAppbar(),
      body: Stack(
        children: [
          WebView(
            onPageFinished: (finish) {
              setState(() {
                _progress = false;
              });
            },
            initialUrl: widget.url,
          ),
          Visibility(
            visible: _progress,
            child: Container(
              color: Colors.white.withOpacity(0.4),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  AppBar getAppbar() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: kPrimaryColor.withOpacity(0.7),
      title: Text(
        "News Buster",
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
}
