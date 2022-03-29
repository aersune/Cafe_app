import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_restaurant/category_popup.dart';
import 'package:my_restaurant/details_page.dart';
import 'package:remixicon/remixicon.dart';
import 'package:my_restaurant/colors.dart' as color;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Timer timer;
  int counter = 0;

  List info = [];

  List fastFood = [];

  int selectedPage = 0;

  _initData() {
    DefaultAssetBundle.of(context).loadString('json/info.json').then((value) {
      info = json.decode(value);
    });
    DefaultAssetBundle.of(context)
        .loadString('json/fast_food.json')
        .then((value) => {fastFood = json.decode(value)});
  }

  @override
  void initState() {
    super.initState();
    _initData();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => addValue());
  }

  void addValue() {
    setState(() {
      counter++;
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  late int selectedIndex = 0;
  var whichPage = 0;
  var _contextColor = color.AppColor.contentBackground;

  var _categoryName = 'Popular Food';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.white,
          title:  Padding(
            padding: EdgeInsets.only(left: 25.0),
            child:  Row(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage('assets/images/avatar.png'),
                      fit: BoxFit.cover
                    )
                  ),
                ),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Good Morning', style: TextStyle(color: Colors.black54, fontSize: 15),),
                    Text('Javokhir',style: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w500),)
                  ],
                )
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Remix.menu_2_line),
                color: Colors.black,
              ),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Text(
                'Eat Some \nGood Food',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 30),
                  width: (MediaQuery.of(context).size.width) * 0.6,
                  child: TextField(
                    textInputAction: TextInputAction.go,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color(0xff343434)),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10.0)),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Search',
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: _contextColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => CategoryesPopUp(
                            popularFoods: () {
                              setState(() {
                                selectedPage = 0;
                                _categoryName = 'Popular Food';
                                Navigator.pop(context);
                              });
                            },
                            fastFoods: (){
                              setState(() {
                                selectedPage = 1;
                                _categoryName = 'Fast Food';
                                Navigator.pop(context);
                              });
                            },
                          ),
                        );
                      },
                      icon: Icon(Remix.equalizer_fill),
                      color: Colors.white,
                      iconSize: 26.0,
                    )),
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overScroll) {
                        overScroll.disallowIndicator();
                        return true;
                      },
                      child: selectedPage == 0 ? ListView.builder(
                          padding: const EdgeInsets.only(bottom: 20),
                          shrinkWrap: true,
                          itemCount: info.length.toDouble() ~/ 2,
                          itemBuilder: (context, i) {
                            int a = 2 * i;
                            int b = 2 * i + 1;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: info[i]['id'] == 0 ? 45 : 0),
                        child: Column(
                          // mainAxisSize: MainAxisSize.max,
                          children: [
                            const SizedBox(
                              height: 60,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndex = a;
                                });
                                Navigator.push(context,
                                    MaterialPageRoute(
                                        builder: (contex) {
                                  return DetailsPage(
                                    pageIndex: selectedIndex,
                                    info: info,
                                  );
                                }));
                              },
                              child: Container(
                                width: 170,
                                height: 200,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(50),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.4),
                                        blurRadius: 25,
                                        offset: Offset(0, 0),
                                      )
                                    ]),
                                child: Stack(
                                  alignment: AlignmentDirectional.topCenter,
                                  clipBehavior: Clip.none,
                                  children: [
                                    Positioned(
                                      top: -45,
                                      left: 10,
                                      child: Image.asset(
                                        info[a]['img'],
                                        height: 150,
                                      ),
                                    ),
                                    Center(child: Container(
                                      width: 120,
                                      padding: const EdgeInsets.only(top: 70),
                                      child: Text(
                                        info[a]['title'],
                                        maxLines: 2,
                                        softWrap: false,
                                        // overflow: TextOverflow.fade,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black54),
                                      ),
                                    )),
                                    Container(
                                      padding: const EdgeInsets.only(bottom: 10),
                                      alignment: Alignment.bottomCenter,
                                      child: Text('\$' +
                                        info[a]['price'],
                                        style: const TextStyle(
                                            color: Colors.orangeAccent,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: info[i]['id'] == 0 ? 45 : 0),
                        child: Column(
                          children: [
                            Container(
                              color: Colors.white,
                              child: Material(
                                color: Colors.transparent,
                                borderRadius:
                                    BorderRadius.circular(20.0),
                                child: InkWell(
                                  borderRadius:
                                      BorderRadius.circular(50.0),
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = b;
                                    });
                                    Navigator.push(context,
                                        MaterialPageRoute(
                                            builder: (contex) {
                                      return DetailsPage(
                                        pageIndex: selectedIndex,
                                        info: info,
                                      );
                                    }));
                                  },
                                  child: Ink(
                                    child: Container(
                                      // padding: EdgeInsets.only(top: 20),
                                      width: 170,
                                      height: 200,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(
                                                  50),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.4),
                                              blurRadius: 25,
                                              offset: Offset(0, 0),
                                            )
                                          ]),
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Positioned(
                                            top: -45,
                                            left: 10,
                                            child: Image.asset(
                                              info[b]['img'],
                                              height: 150,
                                            ),
                                          ),
                                          Center(
                                              child: Container(
                                            width: 120,
                                            padding: EdgeInsets.only(
                                                top: 70),
                                            child: Text(
                                              info[b]['title'],
                                              maxLines: 2,
                                              softWrap: false,
                                              // overflow: TextOverflow.fade,
                                              textAlign:
                                                  TextAlign.center,
                                              overflow: TextOverflow
                                                  .ellipsis,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight:
                                                      FontWeight.w600,
                                                  color:
                                                      Colors.black54),
                                            ),
                                          )),
                                          Container(
                                            padding: EdgeInsets.only(
                                                bottom: 10),
                                            alignment: Alignment
                                                .bottomCenter,
                                            child: Text('\$' +
                                              info[b]['price'],
                                              style: TextStyle(
                                                  color: Colors
                                                      .orangeAccent,
                                                  fontSize: 16,
                                                  fontWeight:
                                                      FontWeight
                                                          .w500),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 60,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }) :
            ListView.builder(
                padding: const EdgeInsets.only(bottom: 20),
                shrinkWrap: true,
                itemCount: fastFood.length.toDouble() ~/ 2,
                itemBuilder: (context, i) {
                  int a = 2 * i;
                  int b = 2 * i + 1;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: fastFood[i]['id'] == 0 ? 45 : 0),
                        child: Column(
                          // mainAxisSize: MainAxisSize.max,
                          children: [
                            const SizedBox(
                              height: 60,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndex = a;
                                });
                                Navigator.push(context,
                                    MaterialPageRoute(
                                        builder: (contex) {
                                          return DetailsPage(
                                            pageIndex: selectedIndex,
                                            info: fastFood,
                                          );
                                        }));
                              },
                              child: Container(
                                width: 170,
                                height: 200,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.circular(50),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.4),
                                        blurRadius: 25,
                                        offset: Offset(0, 0),
                                      )
                                    ]),
                                child: Stack(
                                  alignment: AlignmentDirectional.topCenter,
                                  clipBehavior: Clip.none,
                                  children: [
                                    Positioned(
                                      top: -45,
                                      left: 10,
                                      child: Container(
                                        width: 150,
                                        height: 150,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage( fastFood[a]['img'])
                                            )
                                        ),
                                      ),
                                    ),
                                    Center(child: Container(
                                      width: 120,
                                      padding: const EdgeInsets.only(top: 70),
                                      child: Text(
                                        fastFood[a]['title'],
                                        maxLines: 2,
                                        softWrap: false,
                                        // overflow: TextOverflow.fade,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black54),
                                      ),
                                    )),
                                    Container(
                                      padding: const EdgeInsets.only(bottom: 10),
                                      alignment: Alignment.bottomCenter,
                                      child: Text('\$' +
                                        fastFood[a]['price'],
                                        style: const TextStyle(
                                            color: Colors.orangeAccent,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: fastFood[i]['id'] == 0 ? 45 : 0),
                        child: Column(
                          children: [
                            Container(
                              color: Colors.white,
                              child: Material(
                                color: Colors.transparent,
                                borderRadius:
                                BorderRadius.circular(20.0),
                                child: InkWell(
                                  borderRadius:
                                  BorderRadius.circular(50.0),
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = b;
                                    });
                                    Navigator.push(context,
                                        MaterialPageRoute(
                                            builder: (contex) {
                                              return DetailsPage(
                                                pageIndex: selectedIndex,
                                                info: fastFood,
                                              );
                                            }));
                                  },
                                  child: Ink(
                                    child: Container(
                                      // padding: EdgeInsets.only(top: 20),
                                      width: 170,
                                      height: 200,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(
                                              50),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey
                                                  .withOpacity(0.4),
                                              blurRadius: 25,
                                              offset: Offset(0, 0),
                                            )
                                          ]),
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Positioned(
                                            top: -30,
                                            left: 10,
                                            child: Container(
                                              width: 150,
                                              height: 150,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage( fastFood[b]['img'])
                                                )
                                              ),

                                            ),
                                          ),
                                          Center(
                                              child: Container(
                                                width: 120,
                                                padding: EdgeInsets.only(
                                                    top: 70),
                                                child: Text(
                                                  fastFood[b]['title'],
                                                  maxLines: 2,
                                                  softWrap: false,
                                                  // overflow: TextOverflow.fade,
                                                  textAlign:
                                                  TextAlign.center,
                                                  overflow: TextOverflow
                                                      .ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      color:
                                                      Colors.black54),
                                                ),
                                              )),
                                          Container(
                                            padding: EdgeInsets.only(
                                                bottom: 10),
                                            alignment: Alignment
                                                .bottomCenter,
                                            child: Text('\$' +
                                              info[b]['price'],
                                              style: TextStyle(
                                                  color: Colors
                                                      .orangeAccent,
                                                  fontSize: 16,
                                                  fontWeight:
                                                  FontWeight
                                                      .w500),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 60,
                            ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                  ),
                  Positioned(
                    top: 15,
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.5,
                      padding: const EdgeInsets.only(left: 25, top: 5),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.elliptical(30, 30),
                            bottomLeft: Radius.elliptical(30, 30),
                          )),
                      child: Text(
                        _categoryName,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
