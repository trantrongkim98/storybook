import 'package:flutter/material.dart';
import 'package:base_widget/base_widget.dart';

class HomePage extends StatefulWidget {
  static const String router = "HomePage";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _content(),
    );
  }

  Widget _content() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(top: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // DeleteButton(
            //   state: ButtonState.IDLE,
            //   height: 90,
            //   width: 270,
            //   backgroundColor: Colors.amber,
            //   icon: Icons.delete,
            //   borderRadius: BorderRadius.circular(30),
            //   text: "Delete",
            // ),
            // Button(
            //   width: 200,
            //   height: 60,
            //   onCallback: () {},
            //   color: Colors.red,
            //   alignment: Alignment.center,
            //   borderRadius: BorderRadius.circular(30),
            //   child: Text("Xin chao"),
            // ),
            KTextInput(
              password: false,
              hint: "asdfasdfasd",
              backgroundColor: Colors.white,
              error: Text("dsafsdfasdfs"),
              margin: EdgeInsets.symmetric(horizontal: 20),
              // padding: EdgeInsets.symmetric(horizontal: 20),
              border: Border.all(color: Colors.grey,width: 1),
              shadowColor: Colors.blue,
              onSizeCallback: (size){
                print(size);
              },
              borderRadius: BorderRadius.circular(10),
            ),
          ],
        ),
      ),
    );
  }
}
