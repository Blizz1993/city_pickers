import 'package:flutter/material.dart';

/// 这是一个可以指定SafeArea区域背景色的AppBar
/// PreferredSizeWidget提供指定高度的方法
/// 如果没有约束其高度，则会使用PreferredSizeWidget指定的高度

class CustomAppbar extends StatefulWidget implements PreferredSizeWidget {
  final double contentHeight; //从外部指定高度
  Color navigationBarBackgroundColor; //设置导航栏背景的颜色
  Widget leadingWidget;
  Widget trailingWidget;
  String title;
  Color titleColor;
  TextStyle appBarTitleStyle;
  BorderSide borderSide;
  double leadingLeftMargin;
  double containerWidth;
  CustomAppbar({
    @required this.leadingWidget,
    @required this.title,
    this.contentHeight = 88,
    this.navigationBarBackgroundColor,
    this.titleColor = Colors.black,
    this.appBarTitleStyle,
    this.trailingWidget,
    this.borderSide,
    this.leadingLeftMargin = 5,
    this.containerWidth = 500,
  }) : super();

  @override
  State<StatefulWidget> createState() {
    return new _CustomAppbarState();
    
  }

  @override
  Size get preferredSize => new Size.fromHeight(contentHeight);
}

/// 这里没有直接用SafeArea，而是用Container包装了一层
/// 因为直接用SafeArea，会把顶部的statusBar区域留出空白
/// 外层Container会填充SafeArea，指定外层Container背景色也会覆盖原来SafeArea的颜色
///     var statusheight = MediaQuery.of(context).padding.top;  获取状态栏高度

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: widget.navigationBarBackgroundColor?? Color(0xffefefef),
      child: new SafeArea(
        top: true,
        child: new Container(
            decoration: new UnderlineTabIndicator(
              borderSide: widget.borderSide ?? BorderSide(width: 1.0, color: Color(0xffd5d5d5)),
            ),
            height: widget.contentHeight,
            child: new Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  left: 0,
                  child: new Container(
                    padding: EdgeInsets.only(left: widget.leadingLeftMargin),
                    child: widget.leadingWidget,
                  ),
                ),
                new Container(
                  width: widget.containerWidth,
                  child: new Text(widget.title,
                      style: widget.appBarTitleStyle ?? TextStyle(
                        fontSize: 32.0,),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                  ),
                ),
                Positioned(
                  right: 0,
                  child: new Container(
                    margin: const EdgeInsets.only(right: 0),
                    padding: const EdgeInsets.only(right: 0),
                    child: widget.trailingWidget,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
