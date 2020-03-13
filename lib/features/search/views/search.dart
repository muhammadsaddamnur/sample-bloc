import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samplebloc/core/ui/ui_list.dart';
import 'package:samplebloc/features/detail/views/detail.dart';
import 'package:samplebloc/features/search/bloc/search_bloc.dart';

class SearchView extends StatefulWidget {
  final SearchBloc searchBloc;
  const SearchView({Key key, this.searchBloc}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController search = new TextEditingController();
  Timer _debounce;
  String data = "";

  @override
  void initState() {
    super.initState();
    search.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _debounce.cancel();
    search.removeListener(_onSearchChanged);
    search.dispose();

    super.dispose();
  }

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (search.text != '') {
        if (data != search.text) {
          BlocProvider.of<SearchBloc>(context).add(Search(userId: search.text));
        }
      } else {
        BlocProvider.of<SearchBloc>(context).add(GetBiji());
      }

      data = search.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contoh Search'),
        actions: <Widget>[],
      ),
      body: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: search,
            decoration: InputDecoration(hintText: 'Masukan User Id'),
          ),
        ),
        BlocBuilder(
            bloc: widget.searchBloc,
            builder: (context, state) {
              if (state is SearchLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is SearchFailed) {
                return Text(state.error);
              } else if (state is SearchSuccess) {
                return state.result.length <= 0
                    ? Text(
                        'Pencarian Kosong\nKaya Hati :(',
                        textAlign: TextAlign.center,
                      )
                    : Expanded(
                        child: ListView.builder(
                            itemCount: state.result.length,
                            itemBuilder: (context, index) {
                              return UiList1(
                                text: 'User id : ' +
                                    state.result[index].userId.toString() +
                                    ' , ' +
                                    state.result[index].title,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) => Detail(
                                                id: state.result[index].id
                                                    .toString(),
                                                userId: state
                                                    .result[index].userId
                                                    .toString(),
                                                title:
                                                    state.result[index].title,
                                                body: state.result[index].body,
                                              )));
                                },
                              );
                            }),
                      );
              }
              return Center(child: CircularProgressIndicator());
            })
      ]),
    );
  }
}
