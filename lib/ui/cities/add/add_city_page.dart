import 'package:flutter/material.dart';
import 'package:weatherapp/ui/cities/add/add_city_bloc.dart';
import 'package:weatherapp/ui/common/header_widget.dart';
import 'package:weatherapp/ui/common/loader_widget.dart';
import 'package:weatherapp/ui/ui_constants.dart';

class AddCityPage extends StatefulWidget {
  @override
  _AddCityPageState createState() => _AddCityPageState();
}

class _AddCityPageState extends State<AddCityPage> {
  final bloc = AddCityBloc();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: bloc,
      builder: (context, child) {
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
                const SizedBox(height: 15),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: TextField(
                    onChanged: bloc.onChangedText,
                    decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        border: InputBorder.none,
                        filled: true,
                        hintText: 'Search city',
                        fillColor: Colors.grey[200],
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        )),
                  ),
                ),
                const SizedBox(height: 25),
                Expanded(
                  child: ListView.builder(
                      itemCount: bloc.cities.length,
                      itemBuilder: (context, index) {
                        final city = bloc.cities[index];
                        return ListTile(
                          title: Text(
                            city.title,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.add,
                              color: primaryColor,
                            ),
                            onPressed: () => {},
                          ),
                        );
                      }),
                ),
                if (bloc.loading)
                  Center(
                    child: LoaderWidget(),
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
