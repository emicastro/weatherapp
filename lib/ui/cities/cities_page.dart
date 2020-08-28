import 'package:flutter/material.dart';
import 'package:weatherapp/ui/common/header_widget.dart';
import 'package:weatherapp/ui/ui_constants.dart';

class CitiesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: primaryColor,
        onPressed: () {},
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: <Widget>[
            HeaderWidget(
              title: 'My cities',
            ),
          ],
        ),
      ),
    );
  }
}
