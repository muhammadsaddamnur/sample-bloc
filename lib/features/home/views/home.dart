import 'package:flutter/cupertino.dart';
import 'package:samplebloc/core/ui/ui_list.dart';
import 'package:samplebloc/core/ui/ui_text.dart';
import 'package:samplebloc/features/detail/views/detail.dart';
import 'package:samplebloc/features/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samplebloc/features/infinite_scroll/views/infinite_scroll.dart';

class Home extends StatefulWidget {
  final HomeBloc homeBloc;
  const Home({Key key, this.homeBloc}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<HomeBloc>(context).add(GetData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Contoh Tanpa Infinite'),
          actions: <Widget>[
            RaisedButton(
                color: Colors.white,
                child: UiTextSubTitle(text: 'Infinite'),
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => InfiniteScroll()));
                })
          ],
        ),
        body: SafeArea(
          child: BlocBuilder(
              bloc: widget.homeBloc,
              builder: (context, state) {
                if (state is HomeLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is HomeFailed) {
                  return Text(state.error);
                } else if (state is HomeSuccess) {
                  return ListView.builder(
                      itemCount: state.result.length,
                      itemBuilder: (context, index) {
                        return UiList1(
                          text: state.result[index].title,
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => Detail(
                                          id: state.result[index].id.toString(),
                                          userId: state.result[index].userId
                                              .toString(),
                                          title: state.result[index].title,
                                          body: state.result[index].body,
                                        )));
                          },
                        );
                      });
                }
                return Center(child: CircularProgressIndicator());
              }),
        ));
  }
}
