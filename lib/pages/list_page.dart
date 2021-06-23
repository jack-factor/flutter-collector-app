import 'package:comic_salvat/models/comic_model.dart';
import 'package:comic_salvat/services/comic_provider.dart';
import 'package:comic_salvat/services/comic_service.dart' as ComicService;
import 'package:comic_salvat/widgets/detail_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final _screamSize = MediaQuery.of(context).size;
    final int indexPage = ModalRoute.of(context)?.settings.arguments as int;
    var _titleView = '';
    int _indxIsExit = 0;
    
    switch (indexPage) {
      case 0:
        _titleView = 'Me faltan';
        _indxIsExit = 0;
        break;
      case 1:
        _titleView = 'Mi lista';
        _indxIsExit = 1;
        break;
      case 2:
        _titleView = 'Colección';
        _indxIsExit = 2;
        break;
      default:
        _titleView = 'Colección';
        _indxIsExit = 2;
    }
    print(indexPage);

    return Scaffold(
      backgroundColor: Color.fromRGBO(164, 5, 31, 1),
      body: Column(
        children: [
          SizedBox(height: 50),
          Container(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: (){ Navigator.of(context).pop();},
                  icon: Icon(
                    Icons.keyboard_arrow_left),
                    color: Colors.white,
                    iconSize: 35,
                ),
                SizedBox(width: 20),
                Text(_titleView, style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),)
              ],
            ),
          ),
          SizedBox(height:20),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: _screamSize.height - 140,
              width: _screamSize.width - 40,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              color: Colors.white24,
              // list data
              child: ListComicFW(indxIsExit: _indxIsExit),
            ),
          ),
        ],
      )
    );
  }
}



class ListComicFW extends StatefulWidget {

  final int indxIsExit;

  const ListComicFW({ required this.indxIsExit});

  @override
  _ListComicFWState createState() => _ListComicFWState(indxIsExit);
}

class _ListComicFWState extends State<ListComicFW> {

  final int indxIsExit;

  _ListComicFWState(this.indxIsExit);

  @override
  Widget build(BuildContext context) {
    
    var textDismiss = Text('Mover de la lista', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16));
    final comicListProvider = Provider.of<ComicProvider>(context, listen: false);

    return FutureBuilder(
      future: ComicService.getAll(indxIsExit),
      builder: (BuildContext context, AsyncSnapshot <List<ComicModel>> snapshot){
        if (snapshot.hasData){
          List<ComicModel> listComic = snapshot.data as List<ComicModel>;
          return ListView.builder(
            itemCount: listComic.length,
            itemBuilder: (BuildContext context, int idx){
              if (indxIsExit == 2){
                return DetailListW( dataComic: listComic[idx]);
              } else {
                return Dismissible(
                  background: Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.amber,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        textDismiss,
                        textDismiss,
                      ],
                    ),
                  ),
                  key: ValueKey<int>(listComic[idx].id as int),
                  child: DetailListW( dataComic: listComic[idx]),
                  onDismissed: (DismissDirection direction){
                    comicListProvider.changeIsExist(listComic[idx]);
                  },
                );
              }
            }
          );
        } else {
          return CircularProgressIndicator();
        }
    });
  }
}