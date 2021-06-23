import 'dart:ui';
import 'package:comic_salvat/services/comic_provider.dart';
import 'package:comic_salvat/widgets/component_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final _screamSize = MediaQuery.of(context).size;
    var isMax = (_screamSize.height > 780);
    

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        color: Color.fromRGBO(164, 5, 31, 1),
        child: Column(
          children: <Widget>[
            SizedBox(height: 40.0),
            Row(
              children: [
                Text('La colección definitiva', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold,)),
              ],
            ),
            SizedBox(height: 20.0),
            HomeBannerW(),
            SizedBox(height: 20.0),
            HomeBodyW(),
            SizedBox(height: 20.0),
            Row(
              children: [
                Text('Próximamente:', style: TextStyle(color: Colors.white, fontSize: 20)),
              ],
            ),
            SizedBox(height: 20.0),
            FotterW(maxSize: isMax),
          ]
        ),
      ),
    );
  }
}

class HomeBannerW extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final _screamSize = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        height: _screamSize.height * 0.3,
        width: _screamSize.width - 40,
        decoration: BoxDecoration(
          color: Colors.grey,
          image: DecorationImage(
            image: AssetImage('assets/banner/banner_1.jpeg'),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Container()),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              width: _screamSize.width - 40,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color.fromRGBO(255, 255, 255, 0.04), Colors.black],
                  stops: [0.1, 1]
                  // stops: [0.1, 0.9],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Novelas Gráficas de Marvel',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class HomeBodyW extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final comictotal = Provider.of<ComicProvider>(context);
    comictotal.chargeComicByType(0);
    // comictotal.chargeTotalRows();
    return Container(
      height: 110,
      child: Row(
                children: <Widget>[
                  ActionButton(title: 'Me faltan', total: comictotal.pending, icon: Icons.warning_amber, indexPage: 0),
                  SizedBox(width: 20),
                  ActionButton(title: 'Mi lista', total: comictotal.completed, icon: Icons.star_border_outlined, indexPage: 1),
                  SizedBox(width: 20),
                  ActionButton(title: 'Colección', total: comictotal.total, icon: Icons.collections_bookmark_outlined, indexPage: 2),
                ],
              )
      );

  }
}


class FotterW extends StatelessWidget {

  final bool maxSize;

  const FotterW({
    required this.maxSize
  });


  @override
  Widget build(BuildContext context) {
    
    final comicListProvider = Provider.of<ComicProvider>(context);
    final listComic = comicListProvider.comics;
    final _screamSize = MediaQuery.of(context).size;


    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.all(10),
        height: (this.maxSize)? _screamSize.height * 0.3: 140,
        color: Colors.white24,
        child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listComic.length,
                itemBuilder: (BuildContext context, int idx){
                  return Row(
                    children: [
                      CardComicSmallW(
                        comicDetail: listComic[idx],
                        maxSize: this.maxSize
                      ),
                      SizedBox(width: 20),
                    ],
                  );
                }
        ),
      ),
    );
  }
}



