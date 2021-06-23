import 'package:comic_salvat/models/comic_model.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    final dataComic = ModalRoute.of(context)?.settings.arguments as ComicModel;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(164, 5, 31, 1),
        title: Text('Detalle', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        centerTitle: false,
        elevation: 0,
      ),
      body: Container(
        color: Color.fromRGBO(164, 5, 31, 1),
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            HeadDetailW(dataComic: dataComic),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Descripción:', style: TextStyle(color: Colors.white, fontSize: 20)),
              ],
            ),
            SizedBox(height: 20),
            BodyDetailW(dataComic: dataComic),
          ],
        )
      ),
    );
  }
}


// BODY

class BodyDetailW extends StatelessWidget {

  final ComicModel dataComic;

  const BodyDetailW({ required this.dataComic});


  @override
  Widget build(BuildContext context) {
    
    final _screamSize = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.all(20),
        width: _screamSize.width - 40,
        height: _screamSize.height * 0.3,
        color: Colors.white24,
        child: ListView(
          children: [
            Text(this.dataComic.description, style: TextStyle(fontSize: 16, color: Colors.white))
          ]
        ),
      ),
    );
  }
}


// HEAD


class HeadDetailW extends StatelessWidget {

  final ComicModel dataComic;

  const HeadDetailW({required this.dataComic});

  @override
  Widget build(BuildContext context) {
  
    final _screamSize = MediaQuery.of(context).size;
  
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.all(20),
        color: Colors.white24,
        child: Row(
          children: [
                Hero(
                  tag: '${this.dataComic.id}',
                  child: FadeInImage(
                    width: 150,
                    height: 220,
                    placeholder: AssetImage('assets/images/loading.gif'),
                    image: NetworkImage(this.dataComic.pathImage),
                    fit: BoxFit.cover),
                ),
                SizedBox(width: 20),
                Column(
                  children: [
                    Container(
                      width: _screamSize.width - 250,
                      child: Text(
                        this.dataComic.title,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    IconButton(
                      onPressed: (){
                        print('Press');
                      },
                      icon: CircleAvatar(
                        child: Icon(Icons.add),
                      ),
                    )
                  ],
                ),
              ],
            ),
      ),
    );
  }
}