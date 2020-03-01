import 'package:flutter/foundation.dart';
class CartItem{

  String image;
  String name;
  int price;
  String seller;
  int quantity;

  CartItem({@required this.image, @required this.name, @required this.price, @required this.seller, @required this.quantity});

}

class Cart with ChangeNotifier{

  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items{
    return _items;
  }

  int get itemCount{
    return _items.length;
  }

  double get totalAmount{
    var total = 0.0;
    _items.forEach((key, cartItem){
      total +=  cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String productId, String image, String name, String seller, int price, int quantity ){
    if(_items.containsKey(productId)){
      _items.update(productId, (existingCartItem)=> CartItem(
          name: existingCartItem.name,
          image: existingCartItem.image,
          price: existingCartItem.price,
          seller: existingCartItem.seller,
          quantity : existingCartItem.quantity
      ));
    }else{
      _items.putIfAbsent(productId, () => CartItem(image: image, name: name, seller: seller, quantity: quantity));
    }
    notifyListeners();
  }

  void removeItem(String productId){
    _items.remove(productId);
    notifyListeners();
  }

  void clearItems(){
    _items = {};
    notifyListeners();
  }
  void removeSingleItem(String productId){
    if(!_items.containsKey(productId)){
      return;
    }
    if(_items[productId].quantity > 1){
      items.update(productId, (existingCartItem) => CartItem(
          image: existingCartItem.image,
          name: existingCartItem.name,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity -1
      ));
    }else{
      _items.remove(productId);
    }
    notifyListeners();
  }
}