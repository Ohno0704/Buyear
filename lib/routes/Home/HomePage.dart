import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_application_1/routes/Home/Account/MyPage.dart';
import 'package:flutter_application_1/routes/Home/ItemPage.dart';
import 'package:firebase_storage/firebase_storage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<HomePage> {
  
  late List<AssetImage> listOfImage; //画像ファイル名の配列
  bool clicked = false;
  List<String?> listOfStr = [];
  String? images;
  bool isLoading = false;
  var itemNum = 10;
  
  @override
  void initState() {
    super.initState();
    getImages();
  }

  void getImages() {
    listOfImage = [];
    for (int i = 1; i <= 6; i++) {
      listOfImage.add(
          AssetImage('images/onepiece0' + i.toString() + '.png'));
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        centerTitle: true,
        title: Text("ホーム"),
        gradient:
          LinearGradient(colors: [Colors.blue.shade200, Colors.blue.shade300, Colors.blue.shade400]),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyPage(),
                  ),
                );
            },
            icon: Icon(Icons.account_circle))
        ],
      ),
      body: Container(
        child: GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            itemCount: listOfImage.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0
            ),
            itemBuilder: (BuildContext context, int index) {
              return GridTile(
                    child: Material(
                      child: GestureDetector(
                        child: Stack(children: <Widget>[
                          this.images == listOfImage[index].assetName ||
                                  listOfStr.contains(listOfImage[index].assetName)
                              ? Positioned.fill(
                                  child: Opacity(
                                  opacity: 0.7,
                                  child: Image.asset(
                                    listOfImage[index].assetName,
                                    fit: BoxFit.fill,
                                  ),
                                ))
                              : Positioned.fill(
                                  child: Opacity(
                                  opacity: 1.0,
                                  child: Image.asset(
                                    listOfImage[index].assetName,
                                    fit: BoxFit.fill,
                                  ),
                                )),
                          this.images == listOfImage[index].assetName ||
                                  listOfStr.contains(listOfImage[index].assetName)
                              ? Positioned(
                                  left: 0,
                                  bottom: 0,
                                  child: Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  ))
                              : Visibility(
                                  visible: false,
                                  child: Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.black,
                                  ),
                                )
                        ]),
                        onTap: () {
                          setState(() {
                            // if (listOfStr
                            //     .contains(listOfImage[index].assetName)) {
                            //   this.clicked = false;
                            //   listOfStr.remove(listOfImage[index].assetName);
                            //   this.images = null;
                            // } else {
                            //   this.images = listOfImage[index].assetName;
                            //   listOfStr.add(this.images);
                            //   this.clicked = true;
                            // }
                          });
                        },
                      ),
                    ),
                  );
                  // Container(
                  //   child: Text(
                  //     "￥$index",
                  //     style: TextStyle(
                  //         fontSize: 16.0, fontWeight: FontWeight.w400, fontFamily: "Roboto"),
                  //     ),
                  // )
            //     ]
            //  );
            }
          )
      )
    );
  }
    //   body: Container(
    //   width: double.infinity,
    //   child: GridView.count(
    //     crossAxisCount: 2,
    //     children: List.generate(itemNum, (index) {
    //       return Column(
    //         children: <Widget>[
    //           GridTile(
    //             child: GestureDetector(
    //               onTap: () {
    //                 Navigator.push(
    //                   context,
    //                   MaterialPageRoute(builder: (context) => ItemPageAndAddFriend(index),
    //                   ),
    //                 );
    //               },
    //               child: Image.asset(
    //                 'images/buyear_rogo.jpeg',
    //                 fit: BoxFit.cover,
    //               ),
    //             ),
    //           ),
              // Container(
              //   child: Text(
              //     "￥$index",
              //     style: TextStyle(
              //         fontSize: 16.0, fontWeight: FontWeight.w400, fontFamily: "Roboto"),
              //   ),
              // ),
    //         ],
    //       );
    //     }
    //     )
    //   ),
    // )
}