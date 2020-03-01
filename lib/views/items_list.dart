import 'package:flutter/material.dart';
import '../widgets/item_design.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../views/search.dart';

class ItemsDesign extends StatefulWidget {
  @override
  _ItemsDesignState createState() => _ItemsDesignState();
}

class _ItemsDesignState extends State<ItemsDesign> {
  List<String> images = ['https://www.cielo.co.za/21145-thickbox_default_2x/astoria-couch-velvet-charcoal.jpg',
    'https://www.makro.co.za/sys-master/images/h6b/h72/9375259000862/silo-MIN_377160_EAA_large',
    'https://www.head2bed.co.uk/images/products/galleries/1327/blowup/stylform-doris-modern-floating-bed.jpeg?id=14253',
    'https://www.makro.co.za/sys-master/images/h12/hb6/9472219578398/d03e7d4d-d614-4242-9120-19fb73383f17-qpn13_large',
    'https://robbreportedit.files.wordpress.com/2019/09/sony-16k-crystal-led-tv.jpg'];
  List<double> price = [18988.99,16775.00, 23000.89, 10000.00, 98000.00];
  List<String> names = ['Tuscan Sleeper Couch','Hisense 670L Side by Side Inox Fridge','Carla Bed (Driftwood)','Goldair GGOP-540 Electric Oven','Samsung 109\'inc smart tv'];
  List<String> seller = ['Bredlows','Game stores','Mr Bed','Markro','Takealot',];

  bool isLoadingMore = false;
//  int currentValue = 50;
  int theWatcher = 0;
  int second = 1;

  String _message(){
    var message;
    var hour = DateTime.now().hour;
    if(hour >= 0 && hour < 12){
      message = "Morning, Happy shopping";
    }else if(hour >= 12 && hour < 16){
      message = "Afternoon, Happy shopping";
    }else if(hour >= 16 && hour < 21){
      message = "Evening, Happy shopping";
    }else{
      message = "Happy shopping";
    }
    return message;
  }

  @override
  void initState() {
    // TODO: implement initState
    _getProducts();
    super.initState();
  }

  Future<void> _getProducts() async{
    //this breaks the code since the api call is incorrect
    await Provider.of<Products>(context, listen: false).getAllProducts(50 * second, 50 * theWatcher).then((_){
      setState(() {
        isLoadingMore = false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    //after _getProducts is done this class would be notified of the changes and i word use data below to display
    var data = Provider.of<Products>(context, listen: true).getProducts;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScroll) {
          return <Widget>[
            SliverAppBar(
              elevation: 6.5,
              backgroundColor: Colors.black,
              expandedHeight: 400.0,
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    setState(() {
                      isLoadingMore = false;
                    });
                    Navigator.of(context).pushNamed(Search.routeName);
                  },
                  icon: Icon(
                      Icons.search,
                    size: 24,
                  ),
                ),
              ],
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(_message(), style: TextStyle(fontFamily: 'Quicksand', fontWeight: FontWeight.bold, fontSize: 10, letterSpacing: .5),),
                ),
                background: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(15),
                      width: deviceSize.width,
                      height: 200,
                      child: Image.asset('assets/images/ebay.png'),
                    ),
                  ],
                ),
              ),
            )
          ];
        },
        body: Column(
          children: <Widget>[
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scroll){
                  if(scroll.metrics.maxScrollExtent == scroll.metrics.pixels && !isLoadingMore) {
                    setState(() {
                      isLoadingMore = true;
                      theWatcher += 1;
                      second += 1;
                    });
                  }
                  _getProducts();
                  return isLoadingMore;
                },
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ItemDesign(images[index], price[index], names[index],seller[index]);
                  },
                  itemCount: images.length,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                height: isLoadingMore ? 50.0 : 0,
                color: Colors.transparent,
                child: Center(
                  child: new CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
