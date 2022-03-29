import 'package:flutter/material.dart';
import 'package:my_restaurant/colors.dart' as color;
import 'package:remixicon/remixicon.dart';
class DetailsPage extends StatefulWidget {
  final int pageIndex;
  final dynamic info;
  final int selectedPage;

  const DetailsPage({Key? key,required this.pageIndex, required this.info,required this.selectedPage}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
     int count = 0;

  var _orangeColor = Colors.orangeAccent.withOpacity(0.9);


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    var  foodPrice = double.parse(widget.info[widget.pageIndex]['price']);

    double _totalPrice = count.toDouble() != 0 ? count.toDouble() * foodPrice : 0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: IconButton(onPressed: (){Navigator.pop(context);},
                   icon: Icon(Icons.arrow_back_ios,size: 28,),
                  ),
                ),
                Expanded(child: Container()),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: IconButton(onPressed: (){},
                        icon: Icon(Remix.shopping_cart_2_line, size: 25,color: color.AppColor.textColor,),
                      ),
                    ),
                    Positioned(
                      right: 25,
                        top: 10,
                        child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: _orangeColor,
                        shape: BoxShape.circle
                      ),
                          child: Center(
                            child: Text('1',style: TextStyle(
                              color: Colors.black87,
                              fontSize: 13,
                              fontWeight: FontWeight.w500
                            ),),
                          ),
                    ))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: IconButton(onPressed: (){},
                    icon: Icon(Remix.menu_3_fill, size: 25,),
                  ),
                ),
              ],
            ),

            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage( widget.selectedPage == 0 ? 'assets/images/salad_bg.jpg' : '',),
                            opacity: 0.9,
                            fit: BoxFit.cover
                        )
                    ),
                    child:  Container(
                      padding: const EdgeInsets.only(top: 20),
                      alignment: Alignment.topCenter,
                      child: Image.asset(widget.info[widget.pageIndex]['img'],),
                    ),
                  ),
                  // SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: _orangeColor,
                            borderRadius: BorderRadius.circular(30)
                        ),
                        child: Row(
                          children: [
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                // splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                splashFactory: NoSplash.splashFactory,
                                onTap: (){
                                  setState(() {
                                    count > 0 ? count-- : null;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(Icons.remove),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 8),
                              child: Text(count.toString(), style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                highlightColor: Colors.transparent,
                                splashFactory: NoSplash.splashFactory,
                                splashColor: Colors.transparent,
                                onTap: (){
                                  setState(() {
                                    count++;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(Icons.add),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only( top: 20),
                          child: Text(widget.info[widget.pageIndex]['title'],style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: color.AppColor.textColor,
                          ),),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('\$', style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: color.AppColor.contentBackground
                                ),),
                                Text(
                                  widget.info[widget.pageIndex]['price'],
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w600,
                                    color: color.AppColor.textColor,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(width: 20,),
                            Row(
                              children: [
                                ImageIcon(AssetImage('assets/icons/star.png'),color: color.AppColor.contentBackground,size: 20,),
                                SizedBox(width: 5,),
                                Text(
                                  '4.9',
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w600,
                                    color: color.AppColor.textColor,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Text(
                          'Details',
                          style: TextStyle(
                            fontSize: 20,
                            color: color.AppColor.textColor,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur"
                              " adipiscing elit, sed do eiusmod tempor incididunt"
                              " ut labore et dolore magna aliqua.",
                          style: TextStyle(
                            fontSize: 16,
                            letterSpacing: 0.1,
                            height: 1.5
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),


          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 30,right: 30,bottom: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           Column(
             mainAxisSize: MainAxisSize.min,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(
                   'Total',style: TextStyle(
                 fontSize: 20,
                 fontWeight: FontWeight.w500
               ),
               ),
               Row(
                 crossAxisAlignment: CrossAxisAlignment.end,
                 children: [
                   Text('\$', style: TextStyle(
                       fontSize: 18,
                       fontWeight: FontWeight.bold,
                       color: color.AppColor.contentBackground
                   ),),
                   Text(
                     _totalPrice.toString(),
                     style: TextStyle(
                       fontSize: 28,
                       fontWeight: FontWeight.w600,
                       color: color.AppColor.textColor,
                     ),
                   )
                 ],
               ),
             ],
           ),
            Expanded(child: Container(height: 0,)),
            InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: (){
              },
              child: Ink(
                decoration: BoxDecoration(
                  color: color.AppColor.contentBackground,
                  borderRadius: BorderRadius.circular(15)
                ),
                width: width * 0.5,
                height: 60,
                child:
                    Center(child: Text('Add to cart', style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500
                    ),),
                    ),
              ),
            ),
            // SizedBox(width: 30,)
          ],
        ),
      ),
    );
  }
}
