import 'package:flutter/material.dart';
import '../widgets/product_design.dart';

class ItemDesign extends StatelessWidget {
  static const routeName = '/item-design';
  String image;
  double price;
  String name;
  String seller;

  ItemDesign(this.image, this.price, this.name, this.seller);

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;

    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDesign(image, price, name, seller)));
//        Navigator.of(context).pushNamed(ProductDesign.routeName, arguments: '');
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Card(
            elevation: 5,
            color: Colors.white,
            child: Container(
              width: deviceSize.width,
              height: 330,
              child: Padding(
                padding: const EdgeInsets.all(.1),
                child: Stack(
                  children: <Widget>[
                    Hero(
                      tag: image,
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                        placeholder: AssetImage(
                          "assets/images/placeholder.png",
                        ),
                        image: NetworkImage(
                          image,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 270.0),
                      child: GridTileBar(
                          backgroundColor: Colors.black54,
                          title: Center(
                            child: Column(
                              children: <Widget>[
                                Center(
                                  child: Text(name,
                                      style: TextStyle(
                                          fontFamily: 'Quicksand',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Theme.of(context).primaryColor)),
                                )
                              ],
                            ),
                          ),
                          subtitle: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Center(
                                child: Text(
                                  'R${price}',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ));
  }
}
