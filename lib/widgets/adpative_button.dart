import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AdaptiveButton extends StatefulWidget {
  final String text;
  final Function handler;
  final bool isLoading;
  AdaptiveButton(this.text, this.handler, this.isLoading);

  @override
  _AdaptiveButtonState createState() => _AdaptiveButtonState();
}

class _AdaptiveButtonState extends State<AdaptiveButton> {
  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? RaisedButton(
            child: widget.isLoading
                ? Text(
                    widget.text,
                    style: TextStyle(fontSize: 18,fontFamily: 'Quicksand'),
                  )
                : Text(
                    widget.text,
                    style: TextStyle(fontSize: 18, fontFamily: 'Quicksand'),
                  ),
            onPressed: widget.handler,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)),
            ),
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
//                    color: Colors.black,
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
          )
        : (Platform.isIOS
            ? CupertinoButton(
                child: widget.isLoading
                    ? Text(
                        widget.text,
                        style: TextStyle(fontSize: 18),
                      )
                    : Text(
                        widget.text,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                onPressed: widget.handler,
                color: Theme.of(context).primaryColor,
              )
            : RaisedButton(
                child: widget.isLoading
                    ? Text(
                        widget.text,
                        style: TextStyle(fontSize: 18, fontFamily: 'Quicksand'),
                      )
                    : Text(
                        widget.text,
                        style: TextStyle(fontSize: 18, fontFamily: 'Quicksand'),
                      ),
                onPressed: widget.handler,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25),bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 8.0),
//                    color: Colors.black,
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
              ));
  }
}
