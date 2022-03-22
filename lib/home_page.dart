import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Timer timer;
  int counter = 0;

  List info =[];
  _initData(){
    DefaultAssetBundle.of(context).loadString('json/info.json').then((value) {
      info = json.decode(value);

    });
  }

  @override
  void initState(){
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
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Text('Good Morning',style: TextStyle(color: Colors.black),),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(onPressed: (){}, icon: Icon(Remix.menu_2_line),color: Colors.black,),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Text('Eat Some \nGood Food', style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black.withOpacity(0.7),
            ),),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.only(left: 30),
                width: (MediaQuery.of(context).size.width) * 0.6,
                child:  TextField(
                  textInputAction: TextInputAction.go,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Color(0xff343434)
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    focusedBorder:  OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(10.0)

                    ),
                    filled: true,
                    fillColor:  Colors.white,
                    labelText: 'Search',
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: IconButton(onPressed: (){}, icon: Icon(Remix.qr_scan_2_line),color: Colors.white,iconSize: 30.0,)),
              SizedBox(width: 15,),
            ],
          ),
          SizedBox(height: 10,),
          Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overScroll){
                      overScroll.disallowIndicator();
                      return true;
                    },
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          var a = info[index] * 2;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SizedBox(height: 30,),
                                  Container(
                                    width: 170,
                                    height: 190,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(50)
                                    ),
                                  ),

                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    width: 170,
                                    height: 190,
                                    decoration: BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius: BorderRadius.circular(50)
                                    ),
                                  ),
                                  SizedBox(height: 30,),
                                ],
                              ),
                            ],
                          );
                        }),
                  ),
                ),
              ),
              Positioned(
                top: 20,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Text('Popular Food', style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),),
              )
            ],
          )
        ],
      )
    );
  }
}
