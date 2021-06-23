import 'package:comic_salvat/pages/detail_page.dart';
import 'package:comic_salvat/pages/home_page.dart';
import 'package:comic_salvat/pages/list_page.dart';
import 'package:comic_salvat/services/comic_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
 
void main()=>runApp(MyApp());

 
class MyApp extends StatelessWidget {

  
  
  @override
  Widget build(BuildContext context) {
    
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ComicProvider()),
      ],
      child: MaterialApp(
        title: 'Mi colección',
        debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        routes: {
          'home': (_)=> HomePage(),
          'list': (_)=> ListPage(),
          'detail': (_)=> DetailPage(),
        },
      ),
    );
  }
}