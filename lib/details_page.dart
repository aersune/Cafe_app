import 'package:flutter/material.dart';
import 'package:my_restaurant/home_page.dart' as home;
class DetailsPage extends StatelessWidget {
  final pageIndex;
  final info;
  const DetailsPage({Key? key,required this.pageIndex, required this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(info[pageIndex]['title']),
      ),
    );
  }
}
