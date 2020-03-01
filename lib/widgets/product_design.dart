import 'package:flutter/material.dart';
import '../widgets/adpative_button.dart';
import 'package:numberpicker/numberpicker.dart';

class ProductDesign extends StatefulWidget {
  static const routeName = "/product-design";
  final image;
  final price;
  final name;
  final seller;

  ProductDesign(this.image, this.price, this.name, this.seller);

  @override
  _ProductDesignState createState() => _ProductDesignState();
}

class _ProductDesignState extends State<ProductDesign> {
  var _value = 1;

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    double total = widget.price * _value;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        centerTitle: true,
        title: Text(
          widget.name,
          style: TextStyle(fontFamily: 'Quicksand'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                width: deviceSize.width,
                height: deviceSize.height * 0.40,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5)),
                  child: Hero(
                    tag: widget.image,
                    child: Image.network(
                      widget.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '${widget.name}',
                      style: TextStyle(
                          fontFamily: 'Quicksand-Bold',
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, bottom: 20),
              child: Text(
                widget.seller,
                style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Thank you for registering with the eBay Developers Program. '
                'We are reviewing your account information. Access to your new account is pending approval, which takes at least one business day.',
                style: TextStyle(fontFamily: 'Quicksand'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(30)
                  ),
                  height: 40,
                  width: 140,
                  child: new NumberPicker.integer(
                      scrollDirection: Axis.horizontal,
                      initialValue: _value,
                      minValue: 1,
                      maxValue: 5,
                      decoration: BoxDecoration(
                      ),
                      onChanged: (newValue) => setState(() =>
                      _value = newValue
                      )),
                ),
              ),
            ),
            Center(child: Padding(
              padding: const EdgeInsets.only(bottom : 20.0, top: 5),
              child: Text('Total : R${num.parse(total.toStringAsFixed(2))}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, fontFamily: 'Quicksand'),),
            )),
            Center(child: Container(width: 250,height:50, child: AdaptiveButton('Add to cart', _adding, false))),
          ],
        ),
      ),
    );
  }

  _adding() {}
}
