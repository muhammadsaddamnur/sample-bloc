import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:samplebloc/core/ui/ui_text.dart';

class UiInfiniteScroll extends StatefulWidget {
  final Function onPull;
  final Function onRefresh;
  final int itemCount;
  final Widget header;
  final Widget Function(int) child;
  final bool isLoading;
  final String message;

  UiInfiniteScroll(
      {this.onPull,
      this.onRefresh,
      this.itemCount,
      this.header,
      this.child,
      this.isLoading,
      this.message});

  @override
  _UiInfiniteScrollState createState() => _UiInfiniteScrollState();
}

class _UiInfiniteScrollState extends State<UiInfiniteScroll> {
  ScrollController infiniteController;

  @override
  void initState() {
    super.initState();
    infiniteController = ScrollController();
    infiniteController.addListener(infiniteControllerListener);
  }

  void infiniteControllerListener() {
    final maxScroll = infiniteController.position.maxScrollExtent;
    final currentScroll = infiniteController.position.pixels;
    var infinite = widget.onPull;
    if (currentScroll == maxScroll) {
      infinite();
    }
  }

  @override
  void dispose() {
    infiniteController.removeListener(infiniteControllerListener);
    infiniteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: widget.onRefresh,
      color: Colors.green,
      backgroundColor: Colors.white,
      child: Container(
        color: Colors.white,
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: infiniteController,
          itemCount: widget.header != null
              ? widget.itemCount + 2
              : widget.itemCount + 1,
          itemBuilder: (BuildContext context, int index) {
            return widget.header != null && index == 0
                ? widget.header
                : index >=
                        (widget.header != null
                            ? widget.itemCount + 1
                            : widget.itemCount)
                    ? widget.isLoading == true
                        ? CircularProgressIndicator()
                        : widget.itemCount == 0
                            ? UiTextSubTitle(text: widget.message)
                            : Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                    child: widget.message == null
                                        ? SizedBox()
                                        : UiTextSubTitle(text: widget.message)))
                    : widget.child(widget.header != null ? index - 1 : index);
          },
        ),
      ),
    ));
  }
}
