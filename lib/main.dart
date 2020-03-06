import 'package:samplebloc/features/home/bloc/home_bloc.dart';
import 'package:samplebloc/features/home/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samplebloc/features/infinite_scroll/bloc/infinite_scroll_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MultiBlocProvider(
          providers: [
            BlocProvider<HomeBloc>(
              create: (BuildContext context) => HomeBloc(),
            ),
            BlocProvider<InfiniteScrollBloc>(
              create: (BuildContext context) => InfiniteScrollBloc(),
            ),
          ],
          child: Home(),
        ));
  }
}
