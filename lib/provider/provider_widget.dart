import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 负责创建viewModel对象和初始化数据加载
class ProviderWidget<T extends ChangeNotifier>
    extends StatefulWidget {
  /// viewModel
  final T model;
  final ValueWidgetBuilder<T> builder;
  final Widget child;

  /// 初始化数据
  final Function(T model) initData;

  @override
  State<StatefulWidget> createState() => _ProviderWidgetState<T>();

  ProviderWidget(
      {@required this.model,
      @required this.builder,
      this.child,
      this.initData});
}

class _ProviderWidgetState<T extends ChangeNotifier>
    extends State<ProviderWidget<T>> {
  T model;

  @override
  void initState() {
    model = widget.model;
    widget.initData?.call(model);
    super.initState();
  }

  @override
  void dispose() {
    model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: model,
      child: Consumer(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}

class ProviderWidget2<A extends ChangeNotifier, B extends ChangeNotifier>
    extends StatefulWidget {
  /// viewModel
  final A modelA;
  final B modelB;
  final Widget Function(BuildContext context, A model1, B model2, Widget child) builder;
  final Widget child;

  /// 初始化数据
  final Future Function(A modelA, B modelB) initData;

  @override
  State<StatefulWidget> createState() => _ProviderWidget2State<A, B>();

  ProviderWidget2(
      {@required this.modelA,
        @required this.modelB,
        @required this.builder,
        this.child,
        this.initData});
}

class _ProviderWidget2State<A extends ChangeNotifier, B extends ChangeNotifier>
    extends State<ProviderWidget2<A, B>> {
  A modelA;
  B modelB;

  @override
  void initState() {
    modelA = widget.modelA;
    modelB = widget.modelB;
    widget.initData?.call(modelA, modelB);
    super.initState();
  }

  @override
  void dispose() {
    modelA.dispose();
    modelB.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<A>.value(value: modelA),
        ChangeNotifierProvider<B>.value(value: modelB),
      ],
      child: Consumer2<A, B>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}