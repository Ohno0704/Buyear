import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class InquiryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NewGradientAppBar(
            centerTitle: true,
            title: Text("お問い合わせページ"),
            gradient: LinearGradient(colors: [
              Colors.blue.shade200,
              Colors.blue.shade300,
              Colors.blue.shade400
            ])),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "匿名でのお問い合わせ(Googleフォーム)",
                  style: TextStyle(
                    color: Colors.blue[300],
                    fontSize: 25.0,
                  ),
                ),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              InkWell(
                child: Text(
                  "リンク",
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                onTap: () async {
                  if (await canLaunch(
                      "https://docs.google.com/forms/d/e/1FAIpQLSfuvx1oimnecM_Ii3pGji6oqFWQmDsUuzdRC4ixlUEMTy-wEg/viewform?usp=sf_link")) {
                    await launch(
                        "https://docs.google.com/forms/d/e/1FAIpQLSfuvx1oimnecM_Ii3pGji6oqFWQmDsUuzdRC4ixlUEMTy-wEg/viewform?usp=sf_link");
                  }
                },
              ),
            ]),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "LINE公式アカウント",
                  style: TextStyle(
                    color: Colors.blue[300],
                    fontSize: 25.0,
                  ),
                ),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              InkWell(
                child: Text(
                  "リンク",
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                onTap: () async {
                  if (await canLaunch("https://lin.ee/5zqLQjb")) {
                    await launch("https://lin.ee/5zqLQjb");
                  }
                },
              ),
            ]),
          ],
        ));
  }
}
