import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samplebloc/core/ui/ui_infinite_scroll.dart';
import 'package:samplebloc/core/ui/ui_list.dart';
import 'package:samplebloc/features/infinite_scroll/bloc/infinite_scroll_bloc.dart';

class InfiniteScroll extends StatefulWidget {
  final InfiniteScrollBloc infiniteScrollBloc;
  const InfiniteScroll({Key key, this.infiniteScrollBloc}) : super(key: key);

  @override
  _InfiniteScrollState createState() => _InfiniteScrollState();
}

class _InfiniteScrollState extends State<InfiniteScroll> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<InfiniteScrollBloc>(context).add(PullScroll());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Contoh Infinite'),
        ),
        body: SafeArea(
          child: BlocBuilder(
              bloc: widget.infiniteScrollBloc,
              builder: (context, state) {
                if (state is InfiniteScrollLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is InfiniteScrollFailed) {
                  return Text(state.error);
                } else if (state is InfiniteScrollSuccess) {
                  return UiInfiniteScroll(
                    itemCount: state.result.length,
                    onPull: () {
                      BlocProvider.of<InfiniteScrollBloc>(context)
                          .add(PullScroll());
                    },
                    onRefresh: () {
                      BlocProvider.of<InfiniteScrollBloc>(context)
                          .add(PullScroll());
                    },
                    isLoading: state.isLoading,
                    child: (index) {
                      return UiList1(
                        text:
                            index.toString() + ' ' + state.result[index].title,
                        onTap: () {},
                      );
                    },
                  );
                }
                return Center(child: CircularProgressIndicator());
              }),
        ));
  }
}
