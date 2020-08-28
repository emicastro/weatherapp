import 'package:flutter/material.dart';
import 'package:weatherapp/ui/common/header_widget.dart';

class AddCityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: <Widget>[
            HeaderWidget(title: 'Add city'),
          ],
        ),
      ),
    );
  }
}
