import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'orders.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seller APP',
      home: MyHomePage(title: 'Orde Listing'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Orders> orders;
  bool loading;

Future<List<Orders>> getStudent(BuildContext context) async {
  final url = "http://a65f53d78453.ngrok.io/orders/seller/1";

  final response = await http.get(url);

  if (response.statusCode == 200) {
    return ordersFromJson(response.body);
  } else {
    throw Exception();
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 20),
            height: 150,
            decoration: BoxDecoration(color: Colors.white),
            child: FutureBuilder(
              future: getStudent(context),
              builder: (context,snapshot){
                if (snapshot.hasData){
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context,int index){
                      Orders item=snapshot.data[index];
                      return  Row(children: <Widget>[
                        Text(
                          item.source,
                        ),
                        ]
                        );
                        } 
                  );
                  
                }
                else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                
              }
              return Center(child: CircularProgressIndicator());
              }
              
            ),
            ),

        ],
      ),
    );
  }
}

