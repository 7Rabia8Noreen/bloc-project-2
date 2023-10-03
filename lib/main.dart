import 'package:bloc_project_2/apis/login_api.dart';
import 'package:bloc_project_2/apis/notes_api.dart';
import 'package:bloc_project_2/bloc/app_action.dart';
import 'package:bloc_project_2/bloc/app_bloc.dart';
import 'package:bloc_project_2/bloc/app_state.dart';
import 'package:bloc_project_2/components/iterable_listview.dart';
import 'package:bloc_project_2/components/login_view.dart';
import 'package:bloc_project_2/dialogs/generic_dialog.dart';
import 'package:bloc_project_2/dialogs/loading_screen.dart';
import 'package:bloc_project_2/models.dart';
import 'package:bloc_project_2/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc(
        loginApi: LoginApi(),
        notesApi: NotesApi(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(homePage),
        ),
        body: BlocConsumer<AppBloc, AppState>(
          listener: (context, state) {
             if(state.isLoading){
              LoadingScreen.instance().show(context: context, text: pleaseWait,);
             }
             else{
              LoadingScreen.instance().hide();
             }
             final loginError= state.loginError;

             if(loginError != null){
              showGenericDialog(
                context: context,
                 title: loginErrorDialogTitle,
                  content: loginErrorDialogContent,
                   optionBuilder: () => {
                    ok :true,
                   });
             }
             if(state.isLoading ==false && 
             state.loginError ==null &&
             state.loginHandle == LoginHandle.fooBar() && 
             state.fetchedNotes ==null
             ){
                context.read<AppBloc>().add( const LoadNotesAction());
             }
          },
          builder: (context, state) {
            final notes= state.fetchedNotes;
            if(notes ==null){
              return LoginView(onLoginTapped: (email, password) {
                context.read<AppBloc>().add(
                  LoginAction(email: email, password: password,),
                );
                
              },);
            }
            else{
              return notes.toListView();
            }
            
          },
        ),
      ),
    );
  }
}
