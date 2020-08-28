import 'package:flutter/material.dart';
import 'package:weatherapp/ui/cities/cities_page.dart';
import 'package:weatherapp/ui/ui_constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  void handleNavigateTap(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => CitiesPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
            child: Image.asset(
          'assets/welcome.jpg',
        )),
        SafeArea(
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: maxWidth,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Image.asset('assets/logo.png', height: 60),
                  const SizedBox(
                    height: 50,
                  ),
                  Text('Hi!\nWelcome',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Where you want to go?',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  RaisedButton(
                    color: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                      15.0,
                    )),
                    child: Text(
                      'Add city',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () => handleNavigateTap(context),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}
