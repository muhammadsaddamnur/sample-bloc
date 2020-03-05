import 'package:samplebloc/features/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  final HomeBloc homeBloc;
  const Home({Key key, this.homeBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: <Widget>[
          BlocBuilder(
              bloc: homeBloc,
              builder: (context, state) {
                if (state is HomeLoading) {
                  return CircularProgressIndicator();
                } else if (state is HomeFailed) {
                  return Text(state.error);
                } else if (state is HomeSuccess) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: state.result.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(state.result[index].title),
                          );
                        }),
                  );
                }
                return RaisedButton(onPressed: () {
                  BlocProvider.of<HomeBloc>(context).add(GetNota());
                });
              }),
          RaisedButton(
              child: Text('data'),
              onPressed: () {
                BlocProvider.of<HomeBloc>(context).add(GetBiji());
              }),
          RaisedButton(onPressed: () {
            BlocProvider.of<HomeBloc>(context).add(GetNota());
          })
        ],
      ),
    ));
  }
}
