part of '../main.dart';

class ActivitySearch extends StatefulWidget {
  final String search;

  const ActivitySearch({Key key, this.search = ''}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SearchState();
  }
}

class SearchState extends State<ActivitySearch>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  TextEditingController _controller;
  GlobalKey<PullToRefreshNotificationState> _refresh = GlobalKey();
  final List<Book> _books = [];
  bool loading;

  @override
  initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _controller = TextEditingController();
    if (widget.search.isNotEmpty) {
      _controller.text = widget.search;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        this.startSearch();
      });
    }
  }

  @override
  dispose() {
    _tabController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void submit() {
    _refresh.currentState
        .show(notificationDragOffset: SliverPullToRefreshHeader.height);
  }

  Future<bool> startSearch() async {
    print('搜索漫画: ' + _controller.text);
    setState(() {
      loading = true;
    });
    _books.clear();
    try {
      final List<Book> books = await HttpHanManJia.instance
          .searchBook(_controller.text)
          .timeout(Duration(seconds: 5));
      _books.addAll(books);
      loading = false;
    } catch (e) {
      loading = false;
      return false;
    }
    setState(() {});
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RawKeyboardListener(
          focusNode: FocusNode(),
          onKey: (RawKeyEvent event) {
            print('is enter: ${LogicalKeyboardKey.enter == event.logicalKey}');
            if (_controller.text.isEmpty) return;
            if (event.runtimeType == RawKeyUpEvent &&
                LogicalKeyboardKey.enter == event.logicalKey) {
              print('回车键搜索');
              submit();
            }
          },
          child: FocusWidget.builder(
            context,
            (_, focusNode) => TextField(
              focusNode: focusNode,
              decoration: InputDecoration(
                hintText: '搜索书名',
                prefixIcon: IconButton(
                  onPressed: () {
                    _refresh.currentState.show(
                        notificationDragOffset:
                            SliverPullToRefreshHeader.height);
                  },
                  icon: Icon(Icons.search),
                ),
              ),
              textAlign: TextAlign.left,
              controller: _controller,
              autofocus: widget.search.isEmpty,
              textInputAction: TextInputAction.search,
              onSubmitted: (String name) {
                focusNode.unfocus();
                print('onSubmitted');
                submit();
              },
              keyboardType: TextInputType.text,
              onEditingComplete: () {
                focusNode.unfocus();
                print('onEditingComplete');
                submit();
              },
            ),
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          // isScrollable: true,
          tabs: [
            Tab(text: "源1"),
            Tab(text: "其它源"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          PullToRefreshNotification(
            key: _refresh,
            onRefresh: startSearch,
            child: CustomScrollView(slivers: [
              PullToRefreshContainer((info) => SliverPullToRefreshHeader(
                    info: info,
                    onTap: submit,
                  )),
              SliverLayoutBuilder(
                builder: (_, __) {
                  if (loading == null)
                    return SliverFillRemaining(
                        child: Center(child: Text('输入关键词搜索')));
                  if (loading) return SliverToBoxAdapter();
                  if (_books.length == 0) {
                    return SliverFillRemaining(
                        child: Center(child: Text('一本也没有')));
                  }
                  return SliverList(
                    delegate: SliverChildBuilderDelegate((_, i) {
                      return WidgetBook(
                        _books[i],
                        subtitle: _books[i].author,
                      );
                    }, childCount: _books.length),
                  );
                },
              ),
            ]),
          ),
          Center(
            child: Text(
              '换源功能，请关注后续新版本',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
