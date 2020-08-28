import 'package:flutter/material.dart';
import 'package:weatherapp/ui/cities/add/add_city_page.dart';
import 'package:weatherapp/ui/common/header_widget.dart';
import 'package:weatherapp/ui/ui_constants.dart';

class CitiesPage extends StatelessWidget {
  void handleNavigatePress(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => AddCityPage()),
    );
  }

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
        onPressed: () => handleNavigatePress(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: <Widget>[
            HeaderWidget(
              title: 'My cities',
            ),
            Expanded(
              child: Center(
                child: Text(
                  "You didn't add any cities yet :(",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
