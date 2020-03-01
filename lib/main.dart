import 'package:ebay_sample/models/product.dart';
import 'package:flutter/material.dart';
import 'views/items_list.dart';
import 'widgets/product_design.dart';
import 'package:provider/provider.dart';
import 'helpers/custom_route_helper.dart';
import 'views/search.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: Products())
        ],
        child: Consumer<Products>(
            builder: (context, products, _) => MaterialApp(
                  title: 'eBay Demo',
                  theme: ThemeData(
                    primarySwatch: Colors.green,
                    accentColor: Colors.lightBlue,
                    pageTransitionsTheme: PageTransitionsTheme(builders: {
                      TargetPlatform.android: CustomPageTransitionBuilder(),
                      TargetPlatform.iOS: CustomPageTransitionBuilder()
                    }),
                  ),
                  home: ItemsDesign(),
                  debugShowCheckedModeBanner: false,
                  routes: {
                    ProductDesign.routeName: (context) => ProductDesign('','','',''),
                    Search.routeName: (context) => Search(),
                  },
            )
        )
    );
  }
}
