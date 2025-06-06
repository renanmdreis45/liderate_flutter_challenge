import 'package:flutter/material.dart';

class MockImage extends StatefulWidget {
  final double width;
  final double height;

  const MockImage({
    super.key,
    this.width = 200,
    this.height = 200,
  });

  @override
  State<MockImage> createState() => _MockImageState();
}

class _MockImageState extends State<MockImage> {
  bool _isLoaded = false;

  @override
  Widget build(BuildContext context) {
    final url =
        'https://picsum.photos/seed/picsum/${widget.width.toInt()}/${widget.height.toInt()}';

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (!_isLoaded) const CircularProgressIndicator(),
          AnimatedOpacity(
            opacity: _isLoaded ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 2000),
            child: Image.network(
              url,
              fit: BoxFit.cover,
              width: widget.width,
              height: widget.height,
              loadingBuilder: (context, child, progress) {
                if (progress == null) {
                  Future.microtask(() {
                    if (mounted) {
                      setState(() {
                        _isLoaded = true;
                      });
                    }
                  });
                }
                return child;
              },
              errorBuilder: (_, __, ___) => const Icon(Icons.error),
            ),
          ),
        ],
      ),
    );
  }
}
