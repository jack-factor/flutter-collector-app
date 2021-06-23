import 'package:comic_salvat/models/comic_model.dart';
import 'package:comic_salvat/services/comic_service.dart' as ComicService;
import 'package:flutter/material.dart';

class ComicProvider  extends ChangeNotifier {

  List<ComicModel> comics = [];
  int isExist = 0;
  int pending = 0;
  int completed = 0;
  int total = 0;


  List<ComicModel> scans = [];

  chargeComicByType(int isExist) async {
    final comics = await ComicService.getAll(isExist);
    final comicTotal = await ComicService.getTotalRows();
    this.comics = [... comics];
    this.isExist = isExist;
    this.pending = comicTotal.pending;
    this.completed = comicTotal.completed;
    this.total = comicTotal.total;
    notifyListeners();
  }

  changeIsExist(ComicModel comic) async {
    await ComicService.setExist(comic);
    chargeComicByType(this.isExist);
  }

}


