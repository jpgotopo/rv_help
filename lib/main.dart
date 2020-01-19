import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart';
import 'package:auto_size_text/auto_size_text.dart';
//import 'package:flutter/services.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RV Helps',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  //String _opcionSeleccionada;
  bool removeItem = false;
  @override
  void initState() { 
    super.initState();
    
  }
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final key = new GlobalKey<ScaffoldState>();
    void _openDrawer() {
      key.currentState.openDrawer();
    }

    return Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: SingleChildScrollView(
            child: Column(
              
              children: <Widget>[
                Image.asset('assets/telemovil.png'),

                ItemLink(Icons.satellite, 'RV', 'http://rvs.telemovilperu.com/'), Divider(),
                ItemLink(Icons.router, 'Emprendedor', 'https://admin.telemovilgps.com/'),Divider(),
                ItemLink(Icons.drive_eta, 'Senior', 'http://tracking.telemovilperu.com/'),Divider(),
                ItemLink(Icons.place, 'Standard', 'http://admin.telemovilperu.com/'),Divider(),
                ItemLink(Icons.language, 'Consulta Placa', 'http://webexterno.sutran.gob.pe:8080/ConsultaSutran/'),Divider(),
                ItemLink(Icons.data_usage, 'Agente', 'https://agentes.telemovilgps.com/'),Divider(),
                
              ],
            ),
          ),
        ),
      ),
      drawerEdgeDragWidth: 0.0,
      appBar: AppBar(
        
        title: Text('RV Help'),
      ),
      body: Center(
       
        child: FutureBuilder(
          future: DefaultAssetBundle.of(context).loadString('assets/locals.json'),
          builder: (context, snapshot){
            var myData = json.decode(snapshot.data.toString());
            
            return Column(
              children: <Widget>[
                
                Image.asset('assets/telemovil.png'),
                Text('ASISTENTE RV MONITOREO', style: TextStyle(fontWeight: FontWeight.bold),),
                SingleChildScrollView(
                  child: Container(
                    height: media.height * 0.55,
                    width: media.width * 0.8,
                    
                    child: ListView.builder(
                      itemCount: 7,
                      itemBuilder: (BuildContext context, index){
                        return CardItemLocal(
                          textLocal: myData[index]['Lugar'].toString(),
                          textLat: myData[index]['Latitud'].toString(),
                          textLong: myData[index]['Longitud'].toString(),
                          iconoA: IconButton(
                            onPressed: (){
                             final data1 = ClipboardData(text: myData[index]['Latitud'].toString(),);
                              Clipboard.setData(data1); 
                            },
                            tooltip: 'Copiado al Portapales',
                            icon: Icon(Icons.computer)
                          ),
                          iconoB: IconButton(
                            onPressed: (){
                              final data2 = ClipboardData(text: myData[index]['Latitud'].toString(),);
                              Clipboard.setData(data2);
                              
                            },
                            tooltip: 'Copiado al Portapales',
                            icon: Icon(Icons.computer)
                          ),
                        );
                        //Text(myData[index]['Lugar']);
                      },
                    ),
                  ),
                ),
                /* removeItem? Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(''),
                  ) : Divider(), */
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(6),
                      child: RaisedButton(
                        onPressed: (){},
                        child: Row(children: <Widget>[
                          Icon(Icons.add, color: Colors.white),
                          Padding(
                            padding: EdgeInsets.only(left: 3),
                            child: Text('Agregar', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white)),
                          
                          )
                          
                        ],),
                        color: Color(0xFF1e88e5),
                      )
                    ),
                    Padding(
                      padding: EdgeInsets.all(6),
                      child: RaisedButton(
                        onPressed: (){},
                        child: Row(children: <Widget>[
                          Icon(Icons.update, color: Colors.white),
                          Padding(
                            padding: EdgeInsets.only(left: 3),
                            child: Text('Modificar', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white)),
                          
                          )
                          
                        ],),
                        color: Color(0xFF43a047),
                      )
                    ),
                    Padding(
                      padding: EdgeInsets.all(6),
                      child: RaisedButton(
                        onPressed: (){
                          
                        },
                        child: Row(children: <Widget>[
                          Icon(Icons.delete, color: Colors.white),
                          Padding(
                            padding: EdgeInsets.only(left: 3),
                            child: Text('Eliminar', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),),
                          
                          )
                          
                        ],),
                        color: Color(0xFFe53935),
                      )
                    ),
                  ],
                )
              ],
            );
          },
          
        )
        
      ),
      
    );

  }

}

class CardItemLocal extends StatelessWidget {
  CardItemLocal({this.textLocal, this.iconoA, this.textLat, this.iconoB, this.textLong});
  final String textLocal;
  final Widget iconoA;
  final String textLat;
  final Widget iconoB;
  final String textLong;

    @override
    Widget build(BuildContext context) {
      return Card(
        margin: EdgeInsets.all(20),
        elevation: 10.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(5),
              child: SelectableText(textLocal, style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF8E8E8E)),),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: SelectableText(textLat, style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF9E9E9E))),
            ),
            Padding(
              padding: EdgeInsets.only(left:3),
              child: iconoA,
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: SelectableText(textLong, style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF8E8E8E)),),
            ),
            Padding(
              padding: EdgeInsets.only(left:3),
              child: iconoB,
            ),
          ],
        ),
      );
        
      
    }
  }

class ItemLink extends StatelessWidget {
  ItemLink(this.icono, this.etiqueta, this.enlace);
  final IconData icono;
  final String etiqueta;
  final String enlace;
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        
        child: Row(
          
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: Icon(icono, color: Color(0xFF1e88e5),),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(etiqueta, style:TextStyle(fontSize: 14, fontWeight: FontWeight.w600, ), textAlign: TextAlign.start,),
                Padding(
                  padding: EdgeInsets.only(top: 3),
                  child: InkWell(
                    child: SingleChildScrollView(child: AutoSizeText(enlace.length <35? enlace: 'Abrir Enlace', textAlign: TextAlign.justify,)),
                    onTap: ()=> launch(enlace ),
                  ),
                )
              ],
            )
          ],
        ),

      ),
    );
  }
}

//Texto Copiable
