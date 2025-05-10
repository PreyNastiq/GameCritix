import 'package:game_critix/Services/Database/Gamedata.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GamedataDB {
  //database => notes
  final database = Supabase.instance.client.from('gamedata');

  //create
  Future createGamedata(Gamedata newGamedata) async {
    await database.insert(newGamedata.toMap());
  }

  //read
  final stream = Supabase.instance.client
      .from('gamedata')
      .stream(primaryKey: ['id']).map((data) =>
          data.map((gamedataMap) => Gamedata.fromMap(gamedataMap)).toList());

  //update
  Future updateGamedata(Gamedata oldGamedata,String newTitle,newPrice,newDescription) async {
    await database.update({
      'title': newTitle,
      'price': newPrice,
      'description': newDescription,
    }).eq('id', oldGamedata.id!);
  }

  //delete
  Future deleteGamedata(Gamedata gamedata) async {
    await database.delete().eq('id', gamedata.id!);
  }
}