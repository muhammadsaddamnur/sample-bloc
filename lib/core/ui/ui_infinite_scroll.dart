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
  final bool topFloat;
  final Widget topFloatWidget;
  final Widget loadingWidget;

  UiInfiniteScroll(
      {this.onPull,
      this.onRefresh,
      @required this.itemCount,
      this.header,
      @required this.child,
      this.isLoading,
      @required this.message,
      this.topFloat,
      this.topFloatWidget,
      this.loadingWidget});

  @override
  _UiInfiniteScrollState createState() => _UiInfiniteScrollState();
}

class _UiInfiniteScrollState extends State<UiInfiniteScroll> {
  ScrollController infiniteController;
  bool isTop = false;

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

    if (widget.topFloat) {
      if (infiniteController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (isTop == true) {
          isTop = false;
          setState(() {});
        }
      } else if (infiniteController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isTop == false) {
          isTop = true;
          setState(() {});
        }
      }
      if (currentScroll == 0.0) {
        if (isTop == true) {
          isTop = false;
          setState(() {});
        }
      }
    }
  }

  void onTop() async {
    isTop = false;
    setState(() {});
    await infiniteController.animateTo(0,
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
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
          onRefresh: () async {
            if (widget.onRefresh != null) {
              await widget.onRefresh();
            }
            return null;
          },
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
                            ? (widget.loadingWidget == null
                                ? Container(
                                    child: Center(
                                        child: CircularProgressIndicator()))
                                : widget.loadingWidget)
                            : widget.itemCount == 0
                                ? Center(
                                    child: UiTextSubTitle(text: widget.message))
                                : Container(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(
                                        child: widget.message == null
                                            ? SizedBox()
                                            : UiTextSubTitle(
                                                text: widget.message)))
                        : widget
                            .child(widget.header != null ? index - 1 : index);
              },
            ),
          ),
        ),
        floatingActionButton: isTop
            ? (widget.topFloatWidget != null
                ? widget.topFloatWidget
                : FloatingActionButton(
                    onPressed: onTop,
                    mini: true,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.arrow_upward, color: Colors.grey),
                  ))
            : null);
  }
}
