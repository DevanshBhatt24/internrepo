import 'package:flutter/material.dart';
import 'package:technical_ind/screens/News/category_specific_news.dart';

class NewsBites extends StatefulWidget {
  final String topic;
  NewsBites({this.topic});

  @override
  State<NewsBites> createState() => _NewsBitesState();
}

class _NewsBitesState extends State<NewsBites> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: NewsDetailsPage(
        keyword: widget.topic,
      ),
    );
  }
}

class NewsBites2 extends StatefulWidget {
  final String topic;
  NewsBites2({this.topic});

  @override
  State<NewsBites2> createState() => _NewsBites2State();
}

class _NewsBites2State extends State<NewsBites2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: NewsDetailsPage(
        keyword: widget.topic,
      ),
    );
  }
}

class NewsBites3 extends StatefulWidget {
  final String topic;
  NewsBites3({this.topic});

  @override
  State<NewsBites3> createState() => _NewsBites3State();
}

class _NewsBites3State extends State<NewsBites3> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: NewsDetailsPage(
        keyword: widget.topic,
      ),
    );
  }
}

class NewsBites4 extends StatefulWidget {
  final String topic;
  NewsBites4({this.topic});

  @override
  State<NewsBites4> createState() => _NewsBites4State();
}

class _NewsBites4State extends State<NewsBites4> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: NewsDetailsPage(
        keyword: widget.topic,
      ),
    );
  }
}

class NewsBites5 extends StatefulWidget {
  final String topic;
  NewsBites5({this.topic});

  @override
  State<NewsBites5> createState() => _NewsBites5State();
}

class _NewsBites5State extends State<NewsBites5> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: NewsDetailsPage(
        keyword: widget.topic,
      ),
    );
  }
}
