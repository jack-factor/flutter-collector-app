import 'package:comic_salvat/models/comic_model.dart';
import 'package:flutter/material.dart';

// ACTION BUTTONS

class ActionButton extends StatelessWidget {
  final String title;
  final int total;
  final IconData icon;
  final int indexPage;

  const ActionButton({
    required this.title,
    required this.total,
    required this.icon,
    required this.indexPage,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, 'list', arguments: this.indexPage );
        },
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                child: Icon(this.icon, color: Colors.white),
                backgroundColor: Colors.amber,
              ),
              Expanded(child: Container()),
              Text(this.title, style: TextStyle(color: Colors.white70, fontSize: 14),) ,
              Text('${this.total}', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            ]
          ),
        ),
      ),
    );
  }
}


// CARD VIEW BOOTOM

class CardComicSmallW extends StatelessWidget {

  final ComicModel comicDetail;
  final bool maxSize;

  const CardComicSmallW({
    required this.maxSize,
    required this.comicDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (this.maxSize) ? 150 : 120,
      child: GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, 'detail', arguments: this.comicDetail );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Hero(
              tag: '${this.comicDetail.id}',
              child: FadeInImage(
                placeholder: AssetImage('assets/images/loading.gif'),
                image: NetworkImage(this.comicDetail.pathImage),
                height: (this.maxSize) ? 200 : 100,
                width:  (this.maxSize) ? 140 : 70,
                fit: BoxFit.cover,
              ),
            ),
            Center(child: Text(this.comicDetail.title, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white))),
          ],
        ),
      ),
    );
  }
  
}