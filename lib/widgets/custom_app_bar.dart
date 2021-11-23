import 'package:flutter/material.dart';
import 'package:netflix_ui/assets.dart';
import 'package:netflix_ui/widgets/widget.dart';

class CustomAppBar extends StatelessWidget {
  final double scrollOffset;

  const CustomAppBar({
    Key? key,
    this.scrollOffset = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 10.0,
        ),
        color: Colors.black.withOpacity(
          (scrollOffset / 350).clamp(0, 1).toDouble(),
        ),
        child: const Responsive(
          mobile: _CustomAppBarMobile(),
          desktop: _CustomAppBarDesktop(),
          tablet: null,
        ));
  }
}

class _AppBarButton extends StatelessWidget {
  final String title;
  const _AppBarButton({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _CustomAppBarDesktop extends StatelessWidget {
  const _CustomAppBarDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Image.asset(Assets.netflixLogo1),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _AppBarButton(
                  title: 'Home',
                ),
                _AppBarButton(
                  title: 'Tv Shows',
                ),
                _AppBarButton(
                  title: 'Movies',
                ),
                _AppBarButton(
                  title: 'Latest',
                ),
                _AppBarButton(
                  title: 'My List',
                ),
              ],
            ),
          ),
          const Spacer(),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
                const _AppBarButton(
                  title: 'KIDS',
                ),
                const _AppBarButton(
                  title: 'DVD   ',
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.card_giftcard,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBarMobile extends StatelessWidget {
  const _CustomAppBarMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Image.asset(Assets.netflixLogo0),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _AppBarButton(
                  title: 'Tv Shows',
                ),
                _AppBarButton(
                  title: 'Movies',
                ),
                _AppBarButton(
                  title: 'My List',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
