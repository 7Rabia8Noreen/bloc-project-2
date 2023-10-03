import 'package:bloc_project_2/models.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable 
abstract class NotesApiProtocol{
  NotesApiProtocol();

  Future<Iterable<Note>?> getNotes({
    required LoginHandle loginHandle
  });
}

class NotesApi implements NotesApiProtocol{
  @override
  Future<Iterable<Note>?> getNotes({
    required LoginHandle loginHandle,
    }) => Future.delayed(
      Duration(seconds: 2),
      ()=> loginHandle==LoginHandle.fooBar()? mockNotes:null
    );

}