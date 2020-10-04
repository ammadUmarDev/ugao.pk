import 'package:flutter/material.dart';
import 'package:ugao/components/appbar.dart';
import 'package:ugao/components/h3.dart';
import 'package:url_launcher/url_launcher.dart';

import 'add_thumbnail.dart';
import 'model/media_info.dart';

class Tutorial_Screen extends StatefulWidget {
  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<Tutorial_Screen> {
  List<MediaInfo> mediaList = [];
  List<String> urlList = [
    "https://youtu.be/3qftaXO1nzc",
    "https://youtu.be/nv_TsIGVU1M"
  ];

  void openAddLinkDialog() async {
    // Open  thumbnail dialog to add link
    await Thumbnail.addLink(
      context: context,

      /// callback that return thumbnail information in `MediaInfo` object
      onLinkAdded: (mediaInfo) {
        if (mediaInfo != null && mediaInfo.thumbnailUrl.isNotEmpty) {
          setState(() {
            mediaList.add(mediaInfo);
          });
        }
      },
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget getMediaList() {
    return MediaListView(
      onPressed: (url) {
        _launchURL(url);
      },
      urls: urlList,
      mediaList: mediaList,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPageName(
        pageName: "Tutorials",
      ),
      body: (mediaList == null || mediaList.isEmpty) &&
              (urlList == null || urlList.isEmpty)
          ? Center(
              child: H3(
              textBody: "We are filming tutorials for you :)",
            ))
          : getMediaList(),
    );
  }
}
