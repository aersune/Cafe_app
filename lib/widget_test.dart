import 'package:flutter/material.dart';
class AddFullRequest extends StatefulWidget {
  @override
  _AddFullRequestState createState() => _AddFullRequestState();
}

class _AddFullRequestState extends State<AddFullRequest> {
  int _x = 0;

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              Text("$_x"),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddItemScr(
                        onPressed: () => setState(() => _x++),
                      ),
                    ),
                  );
                },
                child: Text('goto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddItemScr extends StatelessWidget {
  final VoidCallback onPressed;
  const AddItemScr({
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          FlatButton(
            onPressed: onPressed,
            child: Text('Increment'),
          ),
        ],
      ),
    );
  }
}