import 'package:flutter/material.dart';
import 'package:netflix_ui/data/data.dart';
import '../widgets/widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

late ScrollController _scrollController;

class _HomeScreenState extends State<HomeScreen> {
  double _scrollOffset = 0.0;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _scrollOffset = _scrollController.offset;
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.grey.shade800,
        child: const Icon(Icons.cast),
      ),
      appBar: PreferredSize(
        child: CustomAppBar(
          scrollOffset: _scrollOffset,
        ),
        preferredSize: Size(
          screenSize.width,
          50.0,
        ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: const [
          SliverToBoxAdapter(
            child: ContentHeader(
              featuredContent: sintelContent,
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(
              top: 20.0,
            ),
            sliver: SliverToBoxAdapter(
              child: Previews(
                key: PageStorageKey('previews'),
                title: 'Previews',
                contentList: previews,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ContentList(
              key: PageStorageKey('myList'),
              title: 'My List',
              contentList: myList,
            ),
          ),
          SliverToBoxAdapter(
            child: ContentList(
                key: PageStorageKey('orginals'),
                title: 'Netflix Originals',
                contentList: originals,
                isOriginals: true),
          ),
          SliverPadding(
            padding: EdgeInsets.only(
              bottom: 20.0,
            ),
            sliver: SliverToBoxAdapter(
              child: ContentList(
                key: PageStorageKey('previews'),
                title: 'Trendings',
                contentList: trending,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
