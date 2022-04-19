import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class PerInfo extends StatelessWidget {
  PerInfo(this.imageURL, this.info, this.subTitle, this.title);
  String? imageURL;
  String? info;
  String? title;
  String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NewGradientAppBar(
            centerTitle: true,
            title: Text("$title"),
            gradient: LinearGradient(colors: [
              Colors.blue.shade200,
              Colors.blue.shade300,
              Colors.blue.shade400
            ])),
        body: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: <Widget>[
                InteractiveViewer(
                    minScale: 0.1,
                    maxScale: 5,
                    child: Container(
                      child: Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              imageURL!,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                      ),
                    )),
                SizedBox(
                  height: 10.0,
                ),
                // 商品の説明
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: Container(
                    color: Colors.grey[400],
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: "サークルの説明",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                // fontStyle: FontStyle.italic
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
                SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: Container(
                    // color: Colors.grey,
                    child: Text('${info!}'),
                  ),
                ),
                // 出品者情報
                SizedBox(
                  height: 10.0,
                ),
              ],
            )));
  }
}
