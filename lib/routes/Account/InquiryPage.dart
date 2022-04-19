import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class InquiryPage extends StatelessWidget {
  // InquiryPage(this.title);
  // String? title;
  TextStyle hyperLinkStyleO =
      TextStyle(color: Colors.blue, decoration: TextDecoration.underline);

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
            Row(
              children: [
                Text('匿名でのお問い合わせはこちらまで'),
              ],
            ),
            Row(
              children: [
                Text(
                    'https://docs.google.com/forms/d/e/1FAIpQLSfuvx1oimnecM_Ii3pGji6oqFWQmDsUuzdRC4ixlUEMTy-wEg/viewform?usp=sf_link')
              ],
            )
          ],
        ));
  }
}
