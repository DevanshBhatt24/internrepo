import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../styles.dart';
import 'package:share/share.dart';

class AppbarWithShare extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(56);
  final String text, imageUrl, title;
  final bool showShare;
  final bool showBack;
  final bool showTitle;
  final bool showBookmark;
  final VoidCallback onShare;
  final Future<bool> Function() isSaved;
  final Future<void> Function() onSaved, delSaved;
  AppbarWithShare(
      {this.text,
      this.showBookmark = true,
      this.title,
      this.showTitle = false,
      this.imageUrl,
      this.showShare = true,
      this.showBack = true,
      this.onShare,
      this.isSaved,
      this.onSaved,
      this.delSaved});
  @override
  _AppbarWithShareState createState() => _AppbarWithShareState();
}

class _AppbarWithShareState extends State<AppbarWithShare> {
  bool isSaved = false;

  @override
  void initState() {
    super.initState();
    if (widget.isSaved != null)
      widget.isSaved().then((value) {
        print(value);
        setState(() {
          isSaved = value;
        });
      });
  }

  void bookmark() {
    setState(() {
      isSaved = !isSaved;
    });
  }

  void share() {
    final RenderBox box = context.findRenderObject();
    final String text = widget.text;
    Share.share(
      text,
      subject: 'Bottomstreet',
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      leading: widget.showBack
          ? IconButton(
              icon: Icon(CupertinoIcons.back, color: white60),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          : null,
      title: widget.showTitle ? Text("${widget.title}") : Container(),
      actions: [
        widget.showBookmark
            ? IconButton(
                icon: (isSaved)
                    ? Icon(
                        Icons.bookmark,
                        size: 28,
                      )
                    : Icon(
                        Icons.bookmark_border,
                        size: 28,
                      ),
                onPressed: () async {
                  if (widget.onSaved != null) {
                    if (isSaved)
                      widget.delSaved().whenComplete(() => bookmark());
                    else
                      widget.onSaved().whenComplete(() => bookmark());
                  }
                },
                //size: 32,
              )
            : SizedBox.shrink(),
        // SizedBox(
        //   width: 18,
        // ),
        widget.showShare
            ? IconButton(
                onPressed: widget.onShare,
                icon: Icon(
                  Icons.share_outlined,
                  size: 28,
                ),
              )
            : SizedBox.shrink(),
        widget.showShare
            ? SizedBox(
                width: 18,
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
