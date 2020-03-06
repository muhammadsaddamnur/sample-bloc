import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        body: SafeArea(
      child: BlocProvider<InfiniteScrollBloc>(
        create: (BuildContext context) => InfiniteScrollBloc(),
        child: BlocBuilder(
            bloc: widget.infiniteScrollBloc,
            builder: (context, state) {
              if (state is InfiniteScrollLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is InfiniteScrollFailed) {
                return Text(state.error);
              } else if (state is InfiniteScrollSuccess) {
                return ListView.builder(
                    itemCount: state.result.length,
                    itemBuilder: (context, index) {
                      return UiList1(
                        text: state.result[index].title,
                        onTap: () {},
                      );
                    });
              }
              return Center(child: CircularProgressIndicator());
            }),
      ),
    ));
  }
}
