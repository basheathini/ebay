import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';

class Search extends StatefulWidget {
  static const routeName = "/search";
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: Platform.isIOS
                ? const EdgeInsets.only(top: 70)
                : const EdgeInsets.only(top: 60),
            child: Center(
              child: Container(
                width: deviceSize.width * 0.89,
                height: 63,
                child: Card(
                  elevation: 15,
                  child: TextFormField(
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Lato',
                        color: Colors.black,
                        letterSpacing: 3.9),
                    textAlign: TextAlign.center,
                    readOnly: false,
                    validator: (value) {
                      print(value);
                      return;
                    },
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.white,
                        )),
                        prefixIcon: GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                                width: 25,
                                height: 25,
                                child: Icon(Icons.close)),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        fillColor: Colors.white,
                        hintText: 'Search products',
                        hintStyle: TextStyle(fontSize: 12),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(240, 240, 240, 1)
                                    .withOpacity(0.9),
                                width: 1)),
                        suffixIcon: GestureDetector(
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.green,
                          ),
                          onTap: () async {
                            await Provider.of<Products>(context, listen: false).getProductProductByName('Tuscan Sleeper Couch').then((_) {
                                Navigator.of(context).pop();
                            });
                          },
                        )),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
