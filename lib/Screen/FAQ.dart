import 'package:flutter/material.dart';

class FAQClass extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<FAQClass> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text("Frequently Asked Questions",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
        child: new ListView.builder(
          itemCount: vehicles.length,
          itemBuilder: (context, i) {
            return new ExpansionTile(
              title: new Text(
                vehicles[i].title,
                style: new TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
              children: <Widget>[
                new Column(
                  children: _buildExpandableContent(vehicles[i]),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  _buildExpandableContent(Vehicle vehicle) {
    List<Widget> columnContent = [];

    for (String content in vehicle.contents)
      columnContent.add(
        new ListTile(
          title: new Text(
            content,
            style: new TextStyle(fontSize: 18.0),
          ),
          leading: new Text(" "),
        ),
      );

    return columnContent;
  }
}

class Vehicle {
  final String title;
  List<String> contents = [];

  Vehicle(this.title, this.contents);
}

List<Vehicle> vehicles = [
  new Vehicle(
    'Small Home Appliances',
    [
      "Find handy and practical home appliances designed to make your life simpler: electric kettles, OTGs, microwave ovens, "
          "sandwich makers, hand blenders, coffee makers, and many more other "
          "time-saving appliances that are truly crafted for a quicker lifestyle. "
          "Live life king size with these appliances at home."
    ],
  ),
  new Vehicle(
    'Lifestyle',
    [
      "Avenir ShopApp, 'India ka Fashion Capital', is your one-stop fashion destination for anything and everything you need to look good. Our exhaustive range of Western and Indian wear, summer and winter clothing, formal and casual footwear, bridal and artificial jewellery, long-lasting make-up, grooming tools and accessories are sure to sweep you off your feet. Shop from crowd favourites like Vero Moda, Forever 21, Only, Arrow, Woodland, Nike, Puma, Revlon, Mac, and Sephora among dozens of other top-of-the-ladder names. From summer staple maxi dresses, no-nonsense cigarette pants, traditional Bandhani kurtis to street-smart biker jackets, you can rely on us for a wardrobe that is up to date. Explore our in-house brands like Metronaut, Anmi, and Denizen, to name a few, for carefully curated designs that are the talk of the town. Get ready to be spoiled"
          " for choice.Festivals, office get-togethers, weddings, brunches, or nightwear - Avenir will have your back each time. "
    ],
  ),
  new Vehicle(
    'No Cost EMI',
    [
      "In an attempt to make high-end products accessible to all, our No Cost EMI plan enables you to shop with us under EMI, without shelling out any processing fee. Applicable on select mobiles, laptops, large and small appliances, furniture, electronics and watches, you can now shop without burning a hole in your pocket. If you've been eyeing"
          " a product for a long time, chances are it may be up for a no cost EMI. Take a look ASAP! Terms and conditions apply."
    ],
  ),
];
