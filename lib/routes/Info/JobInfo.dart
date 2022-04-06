import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class JobInfo extends StatelessWidget {
  JobInfo(this.imageURL, this.info, this.subInfo, this.subTitle, this.title);
  String? imageURL;
  String? info;
  String? subInfo;
  String? title;
  String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        centerTitle: true,
        title: Text("$title"),
        gradient:
          LinearGradient(colors: [Colors.blue.shade200, Colors.blue.shade300, Colors.blue.shade400])
      ),

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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                    text: "時給",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      // fontStyle: FontStyle.italic
                    ),
                  ),),
              ]),
              SizedBox(
                height: 25,
                width: double.infinity,
                child: Container(
                  color: Colors.grey,
                  child: Text('1000円～'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                    text: "アルバイトの説明",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      // fontStyle: FontStyle.italic
                    ),
                  ),),
              ]),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: Container(
                  color: Colors.grey,
                  child: Text('${info!}'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                    text: "詳細情報",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      // fontStyle: FontStyle.italic
                    ),
                  ),),
              ]),
              SizedBox(
                height: 200,
                width: double.infinity,
                child: Container(
                  color: Colors.grey,
                  child: Text('${subInfo!}'),
                ),
              ),
              // 出品者情報
              SizedBox(height: 10.0,),
            ],
      )
    )
      
      
    );
  }
}