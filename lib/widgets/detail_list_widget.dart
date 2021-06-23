import 'package:comic_salvat/models/comic_model.dart';
import 'package:flutter/material.dart';

class DetailListW extends StatelessWidget {

  final ComicModel dataComic;

  const DetailListW({ required this.dataComic});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, 'detail', arguments: this.dataComic );
                },
                child: Hero(
                  transitionOnUserGestures: true,
                  tag: '${this.dataComic.id}',
                  child: FadeInImage(
                        height: 100,
                        width: 70,
                        placeholder: AssetImage('assets/images/loading.gif'),
                        image: NetworkImage(this.dataComic.pathImage),
                        fit: BoxFit.cover
                      ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(this.dataComic.title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),
                      SizedBox(height: 10),
                      Text(this.dataComic.description, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white)),
                    ]
                  )
                ),
              ),
              /*
              Container(
                width: 40,
                child: Column(
                  children: [
                    
                    CircleAvatar(
                      child: Icon(Icons.add_sharp, color: Colors.white),
                      backgroundColor: Colors.amber,
                    )
                  ]
                ),
              )*/
            ],
          ),
          Divider(
            color: Colors.white30,
          ),
        ],
      ),
    );
  }
}