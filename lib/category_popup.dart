import 'package:flutter/material.dart';

class CategoryesPopUp extends StatefulWidget {
  final VoidCallback popularFoods;
  final VoidCallback fastFoods;
   const CategoryesPopUp({Key? key, required this.popularFoods, required this.fastFoods}) : super(key: key);

  @override
  State<CategoryesPopUp> createState() => _CategoryesPopUpState();
}

class _CategoryesPopUpState extends State<CategoryesPopUp> {


  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(10),
      // title: const Text('Choose category'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: 300,
              // height: MediaQuery.of(context).size.height * 0.7,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white
              ),
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                children: [
                  Center(
                    child: Text('Categories', style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500
                    ),),
                  ),
                  SizedBox(height: 8.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                              onTap: widget.popularFoods,
                              child: _categoryItems(context, 'assets/images/salad.png', 'Salads', )),
                          const SizedBox(height: 15,),
                          _categoryItems(context, 'assets/images/drinks.png', 'Driks', ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: widget.fastFoods,
                              child: _categoryItems(context, 'assets/images/fast_food/hamburger.png', 'Fast Foods', )),
                          const SizedBox(height: 15,),
                          _categoryItems(context, 'assets/images/meat_foods.png', 'Meat Foods', ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                      }, child: Text('close'))
                    ],
                  )
                ],
              )
          ),
        ],
      ),

    );
  }
}
Widget _categoryItems(BuildContext context,image, title,){
  return SizedBox(
    height: 125,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Image(image: AssetImage(image),width: 100,),
        // SizedBox(height: 10,),
        Text(title, style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500
        ),),
      ],
    ),
  );
}