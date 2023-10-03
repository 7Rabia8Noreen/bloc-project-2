
import 'package:bloc_project_2/apis/login_api.dart';
import 'package:bloc_project_2/apis/notes_api.dart';
import 'package:bloc_project_2/bloc/app_action.dart';
import 'package:bloc_project_2/bloc/app_state.dart';
import 'package:bloc_project_2/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBloc extends Bloc<AppAction, AppState>{

  final LoginApiProtocol loginApi;
  final NotesApiProtocol notesApi;

  AppBloc({
    required this.loginApi,
     required this.notesApi,
     }) : super( const AppState.empty()) {

      on<LoginAction>((event, emit) async{
         //start loading
         emit(
       const AppState(
            isLoading: true, 
            loginError: null, 
            loginHandle: null,
             fetchedNotes: null,
             ),
         );
         final  loginHandle= await loginApi.login(
          email: event.email,
           password: event.password,
           );
     
          emit(
        AppState(
            isLoading: false, 
            loginError: loginHandle == null? LoginErrors.invalidHandle : null, 
            loginHandle: loginHandle,
             fetchedNotes: null,
             ),
         );
      });
      on<LoadNotesAction>((event, emit) async{
          //start loading
         emit(
        AppState(
            isLoading: true, 
            loginError: null, 
            loginHandle: state.loginHandle,
             fetchedNotes: null,
             ),
         );
         final loginHandle= state.loginHandle;
         if(loginHandle != LoginHandle.fooBar()){
           //invalid login handle, cannot fetch notes
             emit(
        AppState(
            isLoading: false, 
            loginError: LoginErrors.invalidHandle, 
            loginHandle: loginHandle,
             fetchedNotes: null,
             ),
         );
         return;
         }
        
        //valid login handle and fetch notes
         final notes= await notesApi.getNotes(
          loginHandle: loginHandle!,
          );

          emit(
        AppState(
            isLoading: false, 
            loginError: null, 
            loginHandle: loginHandle,
             fetchedNotes: notes,
             ),
         );
      });
     }
  

}