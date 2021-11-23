import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:netflix_ui/models/models.dart';
import 'package:netflix_ui/widgets/widget.dart';
import 'package:video_player/video_player.dart';

class ContentHeader extends StatelessWidget {
  final Content featuredContent;
  const ContentHeader({
    Key? key,
    required this.featuredContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: _ContentHederMobile(
        featuredContent: featuredContent,
      ),
      desktop: _ContetntHederDesktop(
        featuredContent: featuredContent,
      ),
      tablet: null,
    );
  }
}

class _PlayButton extends StatelessWidget {
  const _PlayButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: !Responsive.isDesktop(context)
          ? const EdgeInsets.fromLTRB(
              15.0,
              5.0,
              20.0,
              5.0,
            )
          : const EdgeInsets.fromLTRB(
              25.0,
              10.0,
              30.0,
              10.0,
            ),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Colors.black,
        ),
        onPressed: () {},
        icon: const Icon(
          Icons.play_arrow,
          size: 30.0,
        ),
        label: const Text(
          'Play',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _ContentHederMobile extends StatelessWidget {
  final Content featuredContent;
  const _ContentHederMobile({
    Key? key,
    required this.featuredContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 500.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                featuredContent.imageUrl,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 500.0,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black,
                Colors.transparent,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        Positioned(
          bottom: 110.0,
          child: SizedBox(
            width: 250.0,
            child: Image.asset(
              featuredContent.titleImageUrl,
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 40.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              VerticalIconButton(
                icon: Icons.add,
                title: 'List',
                onTap: () {},
              ),
              const _PlayButton(),
              VerticalIconButton(
                icon: Icons.info_outline,
                title: 'Info',
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ContetntHederDesktop extends StatefulWidget {
  final Content featuredContent;
  const _ContetntHederDesktop({
    Key? key,
    required this.featuredContent,
  }) : super(key: key);

  @override
  State<_ContetntHederDesktop> createState() => _ContetntHederDesktopState();
}

class _ContetntHederDesktopState extends State<_ContetntHederDesktop> {
  late VideoPlayerController _videoPlayerController;
  late bool _isMuted = true;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(
      widget.featuredContent.videoUrl,
    )
      ..initialize().then((_) => setState(() {}))
      ..setVolume(0)
      ..play();
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _videoPlayerController.value.isPlaying
          ? _videoPlayerController.pause()
          : _videoPlayerController.play(),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          AspectRatio(
            aspectRatio: _videoPlayerController.value.isInitialized
                ? _videoPlayerController.value.aspectRatio
                : 2.344,
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Image.asset(
                    widget.featuredContent.imageUrl,
                    fit: BoxFit.cover,
                  ),
          ),
          AspectRatio(
            aspectRatio: _videoPlayerController.value.isInitialized
                ? _videoPlayerController.value.aspectRatio
                : 2.344,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black,
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
          Positioned(
            left: 60,
            right: 60,
            bottom: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 250,
                  child: Image.asset(
                    widget.featuredContent.titleImageUrl,
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Text(
                  widget.featuredContent.description,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          offset: Offset(2.0, 4.0),
                          blurRadius: 6.0,
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    const _PlayButton(),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        25.0,
                        10.0,
                        30.0,
                        10.0,
                      ),
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.black,
                        ),
                        icon: const Icon(
                          Icons.info_outline,
                          size: 30.0,
                        ),
                        label: const Text(
                          'More Info',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    if (_videoPlayerController.value.isInitialized)
                      IconButton(
                        icon: Icon(
                          _isMuted ? Icons.volume_off : Icons.volume_up,
                          size: 30,
                          color: Colors.white,
                        ),
                        onPressed: () => setState(() {
                          _isMuted
                              ? _videoPlayerController.setVolume(100)
                              : _videoPlayerController.setVolume(0);
                          _isMuted = _videoPlayerController.value.volume == 0;
                        }),
                      )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
